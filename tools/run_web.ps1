$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$flutter = Join-Path $env:USERPROFILE 'flutter\bin\flutter.bat'
$modelName = 'gemma-3n-E2B-it-int4.litertlm'
$modelPath = Join-Path $repoRoot "models\$modelName"
$chromeProfile = Join-Path $env:LOCALAPPDATA 'KhipuAI\ChromeProfile'
$server = $null
$virtualDrive = $null
$exitCode = 1
$locationPushed = $false

try {
    if (-not (Test-Path -LiteralPath $flutter)) {
        throw "No se encontro Flutter en $flutter"
    }

    $existingApp = Get-NetTCPConnection -LocalPort 7357 -State Listen -ErrorAction SilentlyContinue |
        Select-Object -First 1
    if ($existingApp) {
        $existingProcess = Get-CimInstance Win32_Process `
            -Filter "ProcessId=$($existingApp.OwningProcess)"
        if ($existingProcess.CommandLine -like '*flutter_tools.snapshot*--web-port=7357*') {
            Write-Host 'Khipu AI ya esta ejecutandose en http://127.0.0.1:7357' -ForegroundColor Yellow
            Start-Process 'http://127.0.0.1:7357'
            exit 0
        }
        throw "El puerto 7357 esta ocupado por $($existingProcess.Name) (PID $($existingApp.OwningProcess))."
    }

    $existingModelServer = Get-NetTCPConnection -LocalPort 8765 -State Listen -ErrorAction SilentlyContinue |
        Select-Object -First 1
    if ($existingModelServer) {
        throw "El puerto 8765 esta ocupado (PID $($existingModelServer.OwningProcess)). Cierra la ejecucion anterior."
    }

    foreach ($letter in @('K', 'R', 'X', 'Y', 'Z')) {
        if (-not (Test-Path "$letter`:\")) {
            $virtualDrive = "$letter`:"
            break
        }
    }
    if (-not $virtualDrive) {
        throw 'No hay una unidad temporal libre (K, R, X, Y o Z).'
    }

    & subst.exe $virtualDrive $repoRoot
    if ($LASTEXITCODE -ne 0) { throw 'No se pudo crear la ruta temporal.' }

    if (Test-Path -LiteralPath $modelPath) {
        $python = Get-Command python -ErrorAction Stop
        $server = Start-Process -FilePath $python.Source `
            -ArgumentList @('-u', "$virtualDrive\tools\model_server.py", '--directory', "$virtualDrive\models", '--port', '8765') `
            -WindowStyle Hidden -PassThru
        Start-Sleep -Milliseconds 500
        if ($server.HasExited) { throw 'El servidor local del modelo no pudo iniciar.' }
        Write-Host "Modelo local disponible para Chrome: $modelName" -ForegroundColor Green
    } else {
        Write-Warning "No se encontro models\$modelName"
        Write-Warning 'La interfaz abrira, pero Gemma no podra instalarse hasta copiar ese archivo.'
    }

    Push-Location "$virtualDrive\app"
    $locationPushed = $true
    New-Item -ItemType Directory -Path $chromeProfile -Force | Out-Null
    & $flutter pub get
    if ($LASTEXITCODE -ne 0) { throw 'flutter pub get fallo.' }

    & $flutter run -d chrome --no-pub `
        --web-hostname=127.0.0.1 `
        --web-port=7357 `
        "--web-browser-flag=--user-data-dir=$chromeProfile" `
        "--dart-define=GEMMA_MODEL_URL=http://127.0.0.1:8765/$modelName"
    $exitCode = $LASTEXITCODE
}
catch {
    Write-Error $_
    $exitCode = 1
}
finally {
    if ($locationPushed) {
        Pop-Location
    }
    if ($server -and -not $server.HasExited) {
        Stop-Process -Id $server.Id -Force -ErrorAction SilentlyContinue
    }
    if ($virtualDrive) {
        & subst.exe $virtualDrive /d 2>$null
    }
}

exit $exitCode
