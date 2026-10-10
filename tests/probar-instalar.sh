#!/usr/bin/env bash
#
# Pruebas del instalador (instalar.sh) en modo local: casos de -Atlas/-Entidad,
# la regla de composición de la orquestadora nacional y los errores esperados.
# No prueba el modo remoto (descarga real desde GitHub); eso se hace a mano,
# ver README.md#instalación.
#
set -euo pipefail

raiz="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
temporal="$(mktemp -d)"
trap 'rm -rf "$temporal"' EXIT

# Copia el instalador junto a atlas/, para que se detecte como modo local.
preparar() {
    rm -rf "$temporal/caso"
    mkdir -p "$temporal/caso"
    cp "$raiz/instalar.sh" "$temporal/caso/"
    cp -R "$raiz/atlas" "$temporal/caso/atlas"
}

destino_de() {
    printf '%s/destino-%s' "$temporal" "$1"
}

instalar_en() {
    local proyecto="$1"
    shift
    (
        cd "$proyecto"
        "$temporal/caso/instalar.sh" "$@"
    )
}

instalar_global_en() {
    local hogar="$1" proyecto="$2"
    shift 2
    (
        cd "$proyecto"
        HOME="$hogar" "$temporal/caso/instalar.sh" --global "$@"
    )
}

debe_pasar() {
    local nombre="$1"
    shift
    if ! "$@"; then
        printf 'FALLA prueba: %s debía pasar\n' "$nombre" >&2
        exit 1
    fi
}

debe_fallar() {
    local nombre="$1"
    shift
    if "$@"; then
        printf 'FALLA prueba: %s debía fallar\n' "$nombre" >&2
        exit 1
    fi
}

existe_carpeta() {
    [ -d "$1" ]
}

no_existe_carpeta() {
    [ ! -d "$1" ]
}

# --- Casos de detección del destino ---
preparar
proyecto="$temporal/proyecto-vacio"
mkdir -p "$proyecto"
debe_pasar "sin carpeta: usa .agents/skills" instalar_en "$proyecto" --atlas ambiental
debe_pasar "sin carpeta: skill instalada en .agents/skills" existe_carpeta "$proyecto/.agents/skills/navegar-anla"

preparar
proyecto="$temporal/proyecto-claude"
mkdir -p "$proyecto/.claude/skills"
debe_pasar "una carpeta compatible: la reutiliza" instalar_en "$proyecto" --atlas ambiental
debe_pasar "una carpeta compatible: instala en .claude/skills" existe_carpeta "$proyecto/.claude/skills/navegar-anla"

preparar
proyecto="$temporal/proyecto-prioridad"
mkdir -p "$proyecto/.agents/skills" "$proyecto/.claude/skills" "$proyecto/.opencode/skills"
debe_pasar "varias carpetas compatibles: prioriza .agents/skills" instalar_en "$proyecto" --atlas ambiental
debe_pasar "prioridad: instala en .agents/skills" existe_carpeta "$proyecto/.agents/skills/navegar-anla"
debe_pasar "prioridad: no instala en .claude/skills" no_existe_carpeta "$proyecto/.claude/skills/navegar-anla"
debe_pasar "prioridad: no instala en .opencode/skills" no_existe_carpeta "$proyecto/.opencode/skills/navegar-anla"

preparar
proyecto="$temporal/proyecto-explicito"
d="$(destino_de explicito)"
mkdir -p "$proyecto/.claude/skills"
debe_pasar "destino explícito prevalece" instalar_en "$proyecto" --atlas ambiental --destino "$d"
debe_pasar "destino explícito: instala en ruta indicada" existe_carpeta "$d/navegar-anla"
debe_pasar "destino explícito: no instala en candidata" no_existe_carpeta "$proyecto/.claude/skills/navegar-anla"

preparar
proyecto="$temporal/proyecto-global"
hogar="$temporal/hogar"
mkdir -p "$proyecto" "$hogar/.opencode/skills"
debe_pasar "global: detecta carpeta bajo HOME" instalar_global_en "$hogar" "$proyecto" --atlas ambiental
debe_pasar "global: instala en candidata bajo HOME" existe_carpeta "$hogar/.opencode/skills/navegar-anla"

# --- Caso 1: un atlas (sin orquestadora nacional) ---
preparar
d="$(destino_de uno)"
debe_pasar "un atlas" instalar_en "$temporal" --atlas ambiental --destino "$d"
debe_pasar "un atlas: skill de entidad instalada" existe_carpeta "$d/navegar-anla"
debe_pasar "un atlas: orquestadora sectorial instalada" existe_carpeta "$d/atlas-orquestador-ambiental"
debe_pasar "un atlas: sin orquestadora nacional" no_existe_carpeta "$d/atlas-orquestador-colombia"

# --- Caso 2: dos atlas (con orquestadora nacional) ---
preparar
d="$(destino_de dos)"
debe_pasar "dos atlas" \
    instalar_en "$temporal" --atlas ambiental,minero-energetico --destino "$d"
debe_pasar "dos atlas: entidad ambiental" existe_carpeta "$d/navegar-anla"
debe_pasar "dos atlas: entidad minero-energetico" existe_carpeta "$d/navegar-upme"
debe_pasar "dos atlas: orquestadora nacional agregada" existe_carpeta "$d/atlas-orquestador-colombia"

# --- Caso 3: --entidad de atlas distintos sin --atlas (sin orquestadora) ---
preparar
d="$(destino_de entidad-cruzada)"
debe_pasar "entidad de atlas distintos" \
    instalar_en "$temporal" --entidad navegar-anla,navegar-upme --destino "$d"
debe_pasar "entidad cruzada: primera skill" existe_carpeta "$d/navegar-anla"
debe_pasar "entidad cruzada: segunda skill" existe_carpeta "$d/navegar-upme"
debe_pasar "entidad cruzada: sin orquestadora nacional" no_existe_carpeta "$d/atlas-orquestador-colombia"

# --- Caso 4: --entidad atlas-orquestador-colombia (por nombre, sin --atlas) ---
preparar
d="$(destino_de orquestadora-nacional)"
debe_pasar "entidad orquestadora nacional" \
    instalar_en "$temporal" --entidad atlas-orquestador-colombia --destino "$d"
debe_pasar "orquestadora nacional instalada" existe_carpeta "$d/atlas-orquestador-colombia"

# --- Caso 5: nombre inexistente (debe fallar) ---
preparar
d="$(destino_de inexistente)"
debe_fallar "skill inexistente" \
    instalar_en "$temporal" --entidad navegar-no-existe --destino "$d"

# --- Caso 6: sin --atlas ni --entidad (debe fallar) ---
preparar
d="$(destino_de sin-argumentos)"
debe_fallar "sin --atlas ni --entidad" \
    instalar_en "$temporal" --destino "$d"

printf 'Pruebas del instalador: OK\n'
