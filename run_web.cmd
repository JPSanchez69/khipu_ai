@echo off
setlocal

rem Evita el bloqueo de hooks_runner cuando la ruta del proyecto tiene espacios.
set "KHIPU_DRIVE="
for %%D in (K R X Y Z) do (
  if not exist "%%D:\" if not defined KHIPU_DRIVE set "KHIPU_DRIVE=%%D:"
)

if not defined KHIPU_DRIVE (
  echo No hay una unidad virtual libre entre K:, R:, X:, Y: y Z:.
  exit /b 1
)

subst %KHIPU_DRIVE% "%~dp0"
if errorlevel 1 (
  echo No se pudo crear la ruta temporal para Khipu AI.
  exit /b 1
)

pushd "%KHIPU_DRIVE%\app"
call "%USERPROFILE%\flutter\bin\flutter.bat" pub get
if errorlevel 1 goto :cleanup_error

call "%USERPROFILE%\flutter\bin\flutter.bat" run -d chrome --no-pub
set "KHIPU_EXIT=%ERRORLEVEL%"
popd
subst %KHIPU_DRIVE% /d
exit /b %KHIPU_EXIT%

:cleanup_error
popd
subst %KHIPU_DRIVE% /d
exit /b 1
