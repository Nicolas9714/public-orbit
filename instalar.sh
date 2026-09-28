#!/usr/bin/env bash
#
# Instala skills de los atlas sectoriales de Public Orbit.
#
# Copia las skills de uno o varios atlas sectoriales (subcarpetas atlas/<alias>
# de este monorepo) hacia una carpeta destino, típicamente dentro del proyecto
# del usuario (ej. .claude/skills para Claude Code, .agents/skills para Codex).
#
# Funciona desde un clon del monorepo (modo local) o ejecutado directo desde
# GitHub sin clonar (modo remoto): si el script no encuentra la carpeta atlas/
# junto a sí mismo, descarga el repositorio como tarball y usa esa copia como
# fuente, borrándola al terminar.
#
# Ejemplos:
#   bash instalar.sh --atlas ambiental
#   bash instalar.sh --atlas todos --actualizar
#   bash instalar.sh --atlas ambiental --entidad navegar-anla --global
#   bash instalar.sh --entidad navegar-anla,navegar-upme
#   curl -fsSL https://raw.githubusercontent.com/Nicolas9714/public-orbit/main/instalar.sh | bash -s -- --atlas ambiental
#
set -euo pipefail

# Tabla de atlas registrados: alias -> nombre de la subcarpeta bajo atlas/.
# Al registrar un atlas nuevo, agregar una línea aquí.
declare -A atlas_registrados=(
    ["ambiental"]="ambiental"
    ["minero-energetico"]="minero-energetico"
)

# Alias del nodo nacional: no se instala completo vía -Atlas/--atlas, pero sus
# skills sueltas (la orquestadora nacional) sí se pueden pedir por --entidad.
NACIONAL="nacional"

atlas_arg=""
destino=".claude/skills"
entidad_arg=""
modo_global=0
actualizar=0
rama="main"

mostrar_uso() {
    echo "Uso: bash instalar.sh [--atlas LISTA] [--entidad LISTA] [opciones]"
    echo ""
    echo "Se requiere al menos --atlas o --entidad."
    echo ""
    echo "Opciones:"
    echo "  --atlas LISTA      Atlas a instalar, separados por coma (ambiental|minero-energetico|todos)"
    echo "  --entidad LISTA    Skills sueltas a instalar por nombre, separadas por coma"
    echo "  --destino RUTA     Carpeta destino (default: .claude/skills)"
    echo "  --global           Instala en la carpeta del usuario en vez del proyecto"
    echo "  --actualizar       git pull en el monorepo antes de copiar (solo modo local)"
    echo "  --rama RAMA        Rama o tag a descargar en modo remoto (default: main)"
}

while [ $# -gt 0 ]; do
    case "$1" in
        --atlas)
            atlas_arg="$2"
            shift 2
            ;;
        --destino)
            destino="$2"
            shift 2
            ;;
        --entidad)
            entidad_arg="$2"
            shift 2
            ;;
        --global)
            modo_global=1
            shift
            ;;
        --actualizar)
            actualizar=1
            shift
            ;;
        --rama)
            rama="$2"
            shift 2
            ;;
        *)
            echo "Error: opción desconocida '$1'" >&2
            mostrar_uso
            exit 1
            ;;
    esac
done

if [ -z "$atlas_arg" ] && [ -z "$entidad_arg" ]; then
    echo "Error: se requiere --atlas o --entidad (al menos uno de los dos)." >&2
    mostrar_uso
    exit 1
fi

# --- Detectar modo local (checkout del monorepo) o remoto (sin clonar) ---
# En modo local, el script vive junto a atlas/. En modo remoto (por ejemplo,
# `curl ... | bash`), no hay BASH_SOURCE utilizable o no hay atlas/ al lado:
# se descarga el repo desde GitHub a una carpeta temporal y esa es la fuente.
raiz_sistema=""
if [ -n "${BASH_SOURCE[0]:-}" ]; then
    dir_script="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || true)"
    if [ -n "$dir_script" ] && [ -d "$dir_script/atlas" ]; then
        raiz_sistema="$dir_script"
    fi
fi

tmp_descarga=""
if [ -z "$raiz_sistema" ]; then
    if [ "$actualizar" -eq 1 ]; then
        echo "Aviso: --actualizar no aplica en modo remoto (no hay clon que actualizar); se ignora." >&2
        actualizar=0
    fi
    echo "Descargando Public Orbit desde GitHub..."
    tmp_descarga="$(mktemp -d)"
    trap 'rm -rf "$tmp_descarga"' EXIT
    if ! curl -fsSL "https://github.com/Nicolas9714/public-orbit/archive/refs/heads/$rama.tar.gz" | tar -xz -C "$tmp_descarga"; then
        echo "Error: no se pudo descargar o extraer la rama/tag '$rama' de public-orbit." >&2
        exit 1
    fi
    raiz_sistema="$(find "$tmp_descarga" -mindepth 1 -maxdepth 1 -type d | head -n1)"
    if [ -z "$raiz_sistema" ] || [ ! -d "$raiz_sistema/atlas" ]; then
        echo "Error: la descarga no tiene la estructura esperada (falta atlas/)." >&2
        exit 1
    fi
fi

# En el monorepo, las skills de cada atlas viven en atlas/<alias>/skills.
raiz_atlas="$raiz_sistema/atlas"

# --- Expandir "todos" y resolver alias pedidos ---
declare -a alias_pedidos=()
if [ -n "$atlas_arg" ]; then
    IFS=',' read -r -a atlas_pedidos_raw <<< "$atlas_arg"
    for a in "${atlas_pedidos_raw[@]}"; do
        if [ "$a" = "todos" ]; then
            for clave in "${!atlas_registrados[@]}"; do
                alias_pedidos+=("$clave")
            done
        else
            alias_pedidos+=("$a")
        fi
    done

    # Eliminar duplicados
    declare -A vistos=()
    declare -a alias_unicos=()
    for a in "${alias_pedidos[@]}"; do
        if [ -z "${vistos[$a]:-}" ]; then
            alias_unicos+=("$a")
            vistos[$a]=1
        fi
    done
    alias_pedidos=("${alias_unicos[@]}")

    # --- Validación: alias desconocidos ---
    for a in "${alias_pedidos[@]}"; do
        if [ -z "${atlas_registrados[$a]:-}" ]; then
            echo "Error: el alias de atlas '$a' no existe." >&2
            echo "Alias válidos: ${!atlas_registrados[*]}, todos" >&2
            exit 1
        fi
    done

    # --- Validación: subcarpetas de atlas existen en la fuente ---
    for a in "${alias_pedidos[@]}"; do
        carpeta="${atlas_registrados[$a]}"
        ruta_atlas="$raiz_atlas/$carpeta"
        if [ ! -d "$ruta_atlas" ]; then
            echo "Error: no se encontró la carpeta del atlas '$a' en $ruta_atlas" >&2
            echo "Debería existir en el monorepo; verifica que el checkout o la descarga estén completos." >&2
            exit 1
        fi
    done
fi

# --- Resolver --entidad: cada nombre se busca en todos los atlas (incluido
#     el nodo nacional, para poder pedir atlas-orquestador-colombia por
#     nombre sin usar --atlas). Los nombres de skill son únicos en todo el
#     repo, así que el primer directorio que coincide es el correcto. ---
declare -a entidades=()
declare -a entidad_atlas=()
declare -a entidad_ruta=()
if [ -n "$entidad_arg" ]; then
    IFS=',' read -r -a entidades <<< "$entidad_arg"

    # Universo de búsqueda: atlas registrados + nodo nacional.
    declare -a alias_busqueda=("${!atlas_registrados[@]}" "$NACIONAL")

    for e in "${entidades[@]}"; do
        encontrada=""
        for a in "${alias_busqueda[@]}"; do
            if [ "$a" = "$NACIONAL" ]; then
                carpeta="$NACIONAL"
            else
                carpeta="${atlas_registrados[$a]}"
            fi
            ruta="$raiz_atlas/$carpeta/skills/$e"
            if [ -d "$ruta" ]; then
                encontrada="$a"
                entidad_ruta+=("$ruta")
                break
            fi
        done
        if [ -z "$encontrada" ]; then
            echo "Error: la skill '$e' no existe en ningún atlas." >&2
            disponibles=""
            for a in "${alias_busqueda[@]}"; do
                if [ "$a" = "$NACIONAL" ]; then
                    carpeta="$NACIONAL"
                else
                    carpeta="${atlas_registrados[$a]}"
                fi
                ruta_skills="$raiz_atlas/$carpeta/skills"
                [ -d "$ruta_skills" ] || continue
                for d in "$ruta_skills"/*/; do
                    [ -d "$d" ] || continue
                    disponibles="$disponibles $(basename "$d")"
                done
            done
            echo "Skills disponibles:$disponibles" >&2
            echo "Si buscas todo un sector, usa --atlas en vez de --entidad." >&2
            exit 1
        fi
        entidad_atlas+=("$encontrada")
    done
fi

# --- Resolver destino efectivo ---
if [[ "$destino" = /* ]]; then
    destino_efectivo="$destino"
elif [ "$modo_global" -eq 1 ]; then
    destino_efectivo="$HOME/$destino"
else
    destino_efectivo="$(pwd)/$destino"
fi

# --- Actualizar el monorepo antes de copiar (solo modo local) ---
if [ "$actualizar" -eq 1 ]; then
    echo "Actualizando el monorepo (Public Orbit)..."
    if ! git -C "$raiz_sistema" pull; then
        echo "Advertencia: git pull falló en $raiz_sistema, se continúa con la versión local." >&2
    fi
fi

# --- Copia ---
mkdir -p "$destino_efectivo"

copiar_skill_exacta() {
    local origen="$1" nombre="$2" destino_skill
    if ! [[ "$nombre" =~ ^[a-z0-9-]+$ ]]; then
        echo "Error: nombre de skill no seguro '$nombre'." >&2
        exit 1
    fi
    destino_skill="$destino_efectivo/$nombre"
    rm -rf -- "$destino_skill"
    cp -R -- "$origen" "$destino_skill"
}

declare -a instaladas_skill=()
declare -a instaladas_atlas=()
declare -A ya_instalada=()

for a in "${alias_pedidos[@]}"; do
    carpeta="${atlas_registrados[$a]}"
    ruta_skills="$raiz_atlas/$carpeta/skills"

    for dir in "$ruta_skills"/*/; do
        [ -d "$dir" ] || continue
        nombre="$(basename "$dir")"
        copiar_skill_exacta "$dir" "$nombre"
        instaladas_skill+=("$nombre")
        instaladas_atlas+=("$a")
        ya_instalada["$nombre"]=1
    done
done

for i in "${!entidades[@]}"; do
    e="${entidades[$i]}"
    if [ -n "${ya_instalada[$e]:-}" ]; then
        continue
    fi
    copiar_skill_exacta "${entidad_ruta[$i]}" "$e"
    instaladas_skill+=("$e")
    instaladas_atlas+=("${entidad_atlas[$i]}")
    ya_instalada["$e"]=1
done

# --- Regla de composición: 2+ atlas completos (-Atlas/--atlas) => copiar
#     también la orquestadora nacional. Skills sueltas de --entidad de atlas
#     distintos NO activan esta regla. ---
if [ "${#alias_pedidos[@]}" -gt 1 ] && [ -z "${ya_instalada[atlas-orquestador-colombia]:-}" ]; then
    ruta_orquestador="$raiz_atlas/nacional/skills/atlas-orquestador-colombia"
    copiar_skill_exacta "$ruta_orquestador" "atlas-orquestador-colombia"
    instaladas_skill+=("atlas-orquestador-colombia")
    instaladas_atlas+=("public-orbit")
    ya_instalada["atlas-orquestador-colombia"]=1
fi

# --- Higiene: aviso de carpeta vieja sin sufijo de sector ---
ruta_vieja="$destino_efectivo/atlas-orquestador"
if [ -d "$ruta_vieja" ]; then
    echo ""
    echo "Advertencia: se encontró '$ruta_vieja', de una versión anterior de la orquestadora." >&2
    echo "Si ya no la necesitas, bórrala manualmente con:" >&2
    echo "  rm -rf '$ruta_vieja'" >&2
fi

# --- Reporte final ---
echo ""
echo "Skills instaladas en $destino_efectivo"

# Agrupado por atlas, en el orden en que se instalaron.
etiqueta_atlas() {
    case "$1" in
        ambiental)                 echo "Atlas ambiental" ;;
        minero-energetico)         echo "Atlas minero-energético" ;;
        nacional|public-orbit)     echo "Public Orbit (nodo nacional)" ;;
        *)                         echo "$1" ;;
    esac
}
declare -a grupos=()
for i in "${!instaladas_atlas[@]}"; do
    g="$(etiqueta_atlas "${instaladas_atlas[$i]}")"
    ya=0
    for x in "${grupos[@]}"; do [ "$x" = "$g" ] && ya=1 && break; done
    [ "$ya" -eq 0 ] && grupos+=("$g")
done
for g in "${grupos[@]}"; do
    declare -a del_grupo=()
    for i in "${!instaladas_skill[@]}"; do
        [ "$(etiqueta_atlas "${instaladas_atlas[$i]}")" = "$g" ] && del_grupo+=("${instaladas_skill[$i]}")
    done
    echo ""
    echo "  $g (${#del_grupo[@]})"
    for s in "${del_grupo[@]}"; do
        echo "    - $s"
    done
    unset del_grupo
done
echo ""
echo "${#instaladas_skill[@]} skill(s) instalada(s)."
echo ""
echo "Verifica la instalación con /skills en Claude Code."
