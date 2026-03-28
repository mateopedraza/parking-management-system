@echo off
setlocal

set "JETSON_API_TOKEN=%~1"
if "%JETSON_API_TOKEN%"=="" set "JETSON_API_TOKEN=dev-jetson-token"

set "DEFAULT_DEVICE_ID=%~2"
if "%DEFAULT_DEVICE_ID%"=="" set "DEFAULT_DEVICE_ID=jetson-01"

set "ALLOWED_ORIGIN=%~3"
if "%ALLOWED_ORIGIN%"=="" set "ALLOWED_ORIGIN=*"

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0run_website_backend.ps1" -JetsonApiToken "%JETSON_API_TOKEN%" -DefaultDeviceId "%DEFAULT_DEVICE_ID%" -AllowedOrigin "%ALLOWED_ORIGIN%"

endlocal
