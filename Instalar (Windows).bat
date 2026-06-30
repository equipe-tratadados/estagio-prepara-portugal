@echo off
REM Instalar (Windows).bat
REM Duplo clique neste arquivo no Explorador de Arquivos para instalar os hooks
REM no repositorio atual. Requer o Git para Windows (Git Bash), que ja precisa
REM estar instalado para usar Git de qualquer forma.

cd /d "%~dp0"

if not exist ".hooks\install.sh" (
    echo Erro: .hooks\install.sh nao encontrado.
    echo Este arquivo precisa estar na raiz do repositorio, junto com a pasta .hooks\
    pause
    exit /b 1
)

set "BASH_EXE="
if exist "%ProgramFiles%\Git\bin\bash.exe" set "BASH_EXE=%ProgramFiles%\Git\bin\bash.exe"
if not defined BASH_EXE if exist "%ProgramFiles(x86)%\Git\bin\bash.exe" set "BASH_EXE=%ProgramFiles(x86)%\Git\bin\bash.exe"
if not defined BASH_EXE for %%I in (bash.exe) do set "BASH_EXE=%%~$PATH:I"

if not defined BASH_EXE (
    echo Erro: Git Bash nao foi encontrado neste computador.
    echo Instale o Git para Windows em https://git-scm.com/download/win
    echo e rode este instalador novamente.
    pause
    exit /b 1
)

"%BASH_EXE%" ".hooks/install.sh"

echo.
echo Instalacao concluida.
pause
