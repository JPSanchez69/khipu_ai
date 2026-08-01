#Requires -Version 5.1
param(
  [string]$DeviceId = "",
  [Parameter(Mandatory = $true)]
  [string]$ModelPath,
  [string]$PackageId = "pe.khipu.khipu_ai",
  [string]$FileName = "gemma3-1b-it-int4.task"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $ModelPath)) {
  Write-Error "No existe el archivo: $ModelPath"
}

$adb = "adb"
if ($DeviceId) {
  $adbArgs = @("-s", $DeviceId)
} else {
  $adbArgs = @()
}

$tmpRemote = "/data/local/tmp/khipu_gemma.task"
$appRelative = "app_flutter/$FileName"

Write-Host "1) Push a /data/local/tmp (puede tardar)..."
& $adb @adbArgs push $ModelPath $tmpRemote
if ($LASTEXITCODE -ne 0) { Write-Error "adb push falló" }

Write-Host "2) Copiar a Documents de la app (run-as → app_flutter)..."
& $adb @adbArgs shell "run-as $PackageId cp $tmpRemote $appRelative"
if ($LASTEXITCODE -ne 0) {
  Write-Error "run-as cp falló. ¿APK debug instalado? package=$PackageId"
}

Write-Host "3) Verificar..."
& $adb @adbArgs shell "run-as $PackageId ls -la app_flutter/"
$localSize = (Get-Item -LiteralPath $ModelPath).Length
$remoteStat = & $adb @adbArgs shell "run-as $PackageId stat -c %s $appRelative"
$remoteSize = [int64]("$remoteStat".Trim())
if ($remoteSize -ne $localSize) {
  Write-Error "Tamaño distinto: local=$localSize remoto=$remoteSize"
}

Write-Host "OK: modelo en app_flutter ($remoteSize bytes), propiedad de la app."
Write-Host "Abre Khipu: debe activar Gemma 3 1B sin 'Permission denied'."
Write-Host "NOTA: usa 'adb install -r' (no 'flutter install')."
