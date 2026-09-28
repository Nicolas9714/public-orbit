<#
.SYNOPSIS
    Instala skills de los atlas sectoriales de Public Orbit.

.DESCRIPTION
    Copia las skills de uno o varios atlas sectoriales (subcarpetas atlas/<alias>
    de este monorepo) hacia una carpeta destino, típicamente dentro del proyecto
    del usuario (ej. .claude\skills para Claude Code, .agents\skills para Codex).

    Funciona desde un clon del monorepo (modo local) o ejecutado directo desde
    GitHub sin clonar (modo remoto): si el script no encuentra la carpeta atlas
    junto a sí mismo, descarga el repositorio como ZIP a una carpeta temporal
    y usa esa copia como fuente, borrándola al terminar.

    Compatible con Windows PowerShell 5.1.

.EXAMPLE
    .\instalar.ps1 -Atlas ambiental

.EXAMPLE
    .\instalar.ps1 -Atlas todos -Actualizar

.EXAMPLE
    .\instalar.ps1 -Atlas ambiental -Entidad navegar-anla -Global

.EXAMPLE
    .\instalar.ps1 -Entidad navegar-anla,navegar-upme

.EXAMPLE
    $po = [scriptblock]::Create((irm https://raw.githubusercontent.com/Nicolas9714/public-orbit/main/instalar.ps1).TrimStart([char]0xFEFF))
    & $po -Atlas ambiental
#>

param(
    [string[]] $Atlas,
    [string]   $Destino = ".claude\skills",
    [string[]] $Entidad,
    [switch]   $Global,
    [switch]   $Actualizar,
    [string]   $Rama = "main"
)

$ErrorActionPreference = "Stop"

# Con powershell.exe -File, "a,b" llega como un solo texto y no como lista:
# se separa aquí para que ambas formas de invocar se comporten igual.
$Atlas   = @($Atlas   | ForEach-Object { $_ -split ',' } | ForEach-Object { $_.Trim() } | Where-Object { $_ })
$Entidad = @($Entidad | ForEach-Object { $_ -split ',' } | ForEach-Object { $_.Trim() } | Where-Object { $_ })

if (-not $Atlas -and -not $Entidad) {
    Write-Host "Error: se requiere -Atlas o -Entidad (al menos uno de los dos)." -ForegroundColor Red
    throw "Instalación cancelada."
}

# Tabla de atlas registrados: alias -> nombre de la subcarpeta bajo atlas/.
# Al registrar un atlas nuevo, agregar una línea aquí.
$atlasRegistrados = @{
    "ambiental"          = "ambiental"
    "minero-energetico"  = "minero-energetico"
}

# Alias del nodo nacional: no se instala completo vía -Atlas, pero sus skills
# sueltas (la orquestadora nacional) sí se pueden pedir por -Entidad.
$NACIONAL = "nacional"

# --- Detectar modo local (checkout del monorepo) o remoto (sin clonar) ---
# En modo local, el script vive junto a atlas/. En modo remoto (por ejemplo,
# invocado con irm | iex o [scriptblock]::Create), $PSScriptRoot viene vacío
# o no hay atlas/ al lado: se descarga el repo desde GitHub a una carpeta
# temporal y esa es la fuente.
$raizSistema = $null
if ($PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot "atlas"))) {
    $raizSistema = $PSScriptRoot
}

$carpetaDescarga = $null
try {
    if (-not $raizSistema) {
        if ($Actualizar) {
            Write-Host "Aviso: -Actualizar no aplica en modo remoto (no hay clon que actualizar); se ignora." -ForegroundColor Yellow
            $Actualizar = $false
        }
        Write-Host "Descargando Public Orbit desde GitHub..."
        $carpetaDescarga = Join-Path ([IO.Path]::GetTempPath()) ("public-orbit-" + [Guid]::NewGuid().ToString("N"))
        New-Item -ItemType Directory -Force -Path $carpetaDescarga | Out-Null
        $zipUrl = "https://github.com/Nicolas9714/public-orbit/archive/refs/heads/$Rama.zip"
        $zipPath = Join-Path $carpetaDescarga "public-orbit.zip"
        try {
            Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath -UseBasicParsing
        } catch {
            Write-Host "Error: no se pudo descargar la rama/tag '$Rama' de public-orbit." -ForegroundColor Red
            throw
        }
        Expand-Archive -Path $zipPath -DestinationPath $carpetaDescarga -Force
        $carpetaExtraida = Get-ChildItem -Path $carpetaDescarga -Directory | Select-Object -First 1
        if (-not $carpetaExtraida -or -not (Test-Path (Join-Path $carpetaExtraida.FullName "atlas"))) {
            Write-Host "Error: la descarga no tiene la estructura esperada (falta atlas)." -ForegroundColor Red
            throw "Instalación cancelada."
        }
        $raizSistema = $carpetaExtraida.FullName
    }

    # En el monorepo, las skills de cada atlas viven en atlas/<alias>/skills,
    # relativo a la raíz de la fuente (local o descargada).
    $raizAtlas = Join-Path $raizSistema "atlas"

    # --- Expandir "todos" y resolver alias pedidos ---
    $aliasPedidos = @()
    if ($Atlas) {
        foreach ($a in $Atlas) {
            if ($a -eq "todos") {
                foreach ($clave in $atlasRegistrados.Keys) {
                    $aliasPedidos += $clave
                }
            } else {
                $aliasPedidos += $a
            }
        }
        $aliasPedidos = @($aliasPedidos | Select-Object -Unique)

        # --- Validación: alias desconocidos ---
        $aliasValidos = $atlasRegistrados.Keys
        foreach ($a in $aliasPedidos) {
            if (-not $atlasRegistrados.ContainsKey($a)) {
                Write-Host "Error: el alias de atlas '$a' no existe." -ForegroundColor Red
                Write-Host "Alias válidos: $($aliasValidos -join ', '), todos"
                throw "Instalación cancelada."
            }
        }

        # --- Validación: subcarpetas de atlas existen en la fuente ---
        foreach ($a in $aliasPedidos) {
            $carpeta = $atlasRegistrados[$a]
            $rutaAtlas = Join-Path $raizAtlas $carpeta
            if (-not (Test-Path $rutaAtlas)) {
                Write-Host "Error: no se encontró la carpeta del atlas '$a' en $rutaAtlas" -ForegroundColor Red
                Write-Host "Debería existir en el monorepo; verifica que el checkout o la descarga estén completos."
                throw "Instalación cancelada."
            }
        }
    }

    # --- Resolver -Entidad: cada nombre se busca en todos los atlas
    #     (incluido el nodo nacional, para poder pedir
    #     atlas-orquestador-colombia por nombre sin usar -Atlas). Los
    #     nombres de skill son únicos en todo el repo. ---
    $entidadInfo = @{}
    if ($Entidad) {
        $aliasBusqueda = @($atlasRegistrados.Keys) + $NACIONAL
        foreach ($e in $Entidad) {
            $encontrada = $null
            foreach ($a in $aliasBusqueda) {
                if ($a -eq $NACIONAL) { $carpeta = $NACIONAL } else { $carpeta = $atlasRegistrados[$a] }
                $ruta = Join-Path (Join-Path $raizAtlas $carpeta) "skills\$e"
                if (Test-Path $ruta) {
                    $encontrada = $a
                    $entidadInfo[$e] = @{ Atlas = $a; Ruta = $ruta }
                    break
                }
            }
            if (-not $encontrada) {
                Write-Host "Error: la skill '$e' no existe en ningún atlas." -ForegroundColor Red
                $disponibles = @()
                foreach ($a in $aliasBusqueda) {
                    if ($a -eq $NACIONAL) { $carpeta = $NACIONAL } else { $carpeta = $atlasRegistrados[$a] }
                    $rutaSkills = Join-Path (Join-Path $raizAtlas $carpeta) "skills"
                    if (Test-Path $rutaSkills) {
                        $disponibles += (Get-ChildItem -Path $rutaSkills -Directory | ForEach-Object { $_.Name })
                    }
                }
                Write-Host "Skills disponibles: $($disponibles -join ', ')"
                Write-Host "Si buscas todo un sector, usa -Atlas en vez de -Entidad."
                throw "Instalación cancelada."
            }
        }
    }

    # --- Resolver destino efectivo ---
    if ([IO.Path]::IsPathRooted($Destino)) {
        $destinoEfectivo = [IO.Path]::GetFullPath($Destino)
    } elseif ($Global) {
        $destinoEfectivo = Join-Path $env:USERPROFILE $Destino
    } else {
        $destinoEfectivo = Join-Path (Get-Location) $Destino
    }

    # --- Actualizar el monorepo antes de copiar (solo modo local) ---
    if ($Actualizar) {
        Write-Host "Actualizando el monorepo (Public Orbit)..."
        git -C $raizSistema pull
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Advertencia: git pull falló en $raizSistema, se continúa con la versión local." -ForegroundColor Yellow
        }
    }

    # --- Copia ---
    if (-not (Test-Path $destinoEfectivo)) {
        New-Item -ItemType Directory -Force -Path $destinoEfectivo | Out-Null
    }

    function Copy-SkillExacta {
        param(
            [Parameter(Mandatory)] [string] $Origen,
            [Parameter(Mandatory)] [string] $Nombre
        )

        if ($Nombre -notmatch '^[a-z0-9-]+$') {
            throw "Nombre de skill no seguro: '$Nombre'."
        }

        $destinoSkill = Join-Path $destinoEfectivo $Nombre
        if (Test-Path -LiteralPath $destinoSkill) {
            Remove-Item -LiteralPath $destinoSkill -Recurse -Force
        }
        Copy-Item -LiteralPath $Origen -Destination $destinoSkill -Recurse -Force
    }

    $instaladas = @()
    $yaInstalada = @{}

    foreach ($a in $aliasPedidos) {
        $carpeta = $atlasRegistrados[$a]
        $rutaSkills = Join-Path (Join-Path $raizAtlas $carpeta) "skills"

        Get-ChildItem -Path $rutaSkills -Directory | ForEach-Object {
            Copy-SkillExacta -Origen $_.FullName -Nombre $_.Name
            $instaladas += [PSCustomObject]@{ Skill = $_.Name; Atlas = $a }
            $yaInstalada[$_.Name] = $true
        }
    }

    foreach ($e in $Entidad) {
        if ($yaInstalada.ContainsKey($e)) { continue }
        Copy-SkillExacta -Origen $entidadInfo[$e].Ruta -Nombre $e
        $instaladas += [PSCustomObject]@{ Skill = $e; Atlas = $entidadInfo[$e].Atlas }
        $yaInstalada[$e] = $true
    }

    # --- Regla de composición: 2+ atlas completos (-Atlas) => copiar también
    #     la orquestadora nacional. Skills sueltas de -Entidad de atlas
    #     distintos NO activan esta regla. ---
    if ($aliasPedidos.Count -gt 1 -and -not $yaInstalada.ContainsKey("atlas-orquestador-colombia")) {
        $rutaOrquestador = Join-Path $raizAtlas "nacional\skills\atlas-orquestador-colombia"
        Copy-SkillExacta -Origen $rutaOrquestador -Nombre "atlas-orquestador-colombia"
        $instaladas += [PSCustomObject]@{ Skill = "atlas-orquestador-colombia"; Atlas = "public-orbit" }
        $yaInstalada["atlas-orquestador-colombia"] = $true
    }

    # --- Higiene: aviso de carpeta vieja sin sufijo de sector ---
    $rutaVieja = Join-Path $destinoEfectivo "atlas-orquestador"
    if (Test-Path $rutaVieja) {
        Write-Host ""
        Write-Host "Advertencia: se encontró '$rutaVieja', de una versión anterior de la orquestadora." -ForegroundColor Yellow
        Write-Host "Si ya no la necesitas, bórrala manualmente con:"
        Write-Host "  Remove-Item -Recurse '$rutaVieja'"
    }

    # --- Reporte final ---
    Write-Host ""
    # Agrupado por atlas, en el orden en que se instalaron.
    $etiquetas = @{
        "ambiental"         = "Atlas ambiental"
        "minero-energetico" = "Atlas minero-energético"
        "nacional"          = "Public Orbit (nodo nacional)"
        "public-orbit"      = "Public Orbit (nodo nacional)"
    }
    Write-Host "Skills instaladas en $destinoEfectivo"
    $instaladas | Group-Object { if ($etiquetas.ContainsKey($_.Atlas)) { $etiquetas[$_.Atlas] } else { $_.Atlas } } | ForEach-Object {
        Write-Host ""
        Write-Host "  $($_.Name) ($($_.Count))"
        foreach ($item in $_.Group) {
            Write-Host "    - $($item.Skill)"
        }
    }
    Write-Host ""
    Write-Host "$($instaladas.Count) skill(s) instalada(s)."
    Write-Host ""
    Write-Host "Verifica la instalación con /skills en Claude Code."
} finally {
    if ($carpetaDescarga -and (Test-Path $carpetaDescarga)) {
        Remove-Item -LiteralPath $carpetaDescarga -Recurse -Force -ErrorAction SilentlyContinue
    }
}
