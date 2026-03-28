param(
    [string]$JetsonApiToken = "dev-jetson-token",
    [string]$DefaultDeviceId = "jetson-01",
    [string]$AllowedOrigin = "*"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$uvExe = Join-Path $env:USERPROFILE ".local\bin\uv.exe"

Set-Location $repoRoot

$env:JETSON_API_TOKEN = $JetsonApiToken
$env:DEFAULT_DEVICE_ID = $DefaultDeviceId
$env:ALLOWED_ORIGIN = $AllowedOrigin
$env:UV_CACHE_DIR = Join-Path $repoRoot ".uv-cache"
$env:UV_PYTHON_INSTALL_DIR = Join-Path $repoRoot ".uv-python"
$env:PYTHONUTF8 = "1"
$env:PYTHONIOENCODING = "utf-8"

Write-Host "Starting website/backend on http://127.0.0.1:5000"
Write-Host "DEVICE_ID=$DefaultDeviceId"

if (Test-Path $uvExe) {
    & $uvExe run --offline --python 3.12 --with Flask==2.3.0 --with flask-cors==4.0.0 WebPageRun.py
    exit $LASTEXITCODE
}

$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if ($pythonCmd) {
    & $pythonCmd.Source WebPageRun.py
    exit $LASTEXITCODE
}

$pyLauncher = Get-Command py -ErrorAction SilentlyContinue
if ($pyLauncher) {
    & $pyLauncher.Source -3 WebPageRun.py
    exit $LASTEXITCODE
}

throw "Neither uv.exe, python.exe, nor py.exe was found. Install one of them before running the backend."
