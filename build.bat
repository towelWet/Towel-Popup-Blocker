@echo off
setlocal enabledelayedexpansion

set "INPUT_FILE=list-files.txt"
set "STATE=idle"
set "CURRENT_FILE="

if not exist "%INPUT_FILE%" (
    echo Error: Input file "%INPUT_FILE%" not found.
    exit /b 1
)

echo Starting build process from %INPUT_FILE%...

for /F "usebackq tokens=*" %%L in ("%INPUT_FILE%") do (
    set "line=%%L"

    echo "!line!" | findstr /B /C:"=== File: ./" > nul
    if !errorlevel! equ 0 (
        set "filepath=!line:~12!"
        set "filepath=!filepath:~0,-4!"
        set "filepath=!filepath:/=\!"

        for %%F in ("!filepath!") do set "dir_path=%%~dpF"
        if defined dir_path (
            set "check_dir=!dir_path:~0,-1!"
            if not exist "!check_dir!" (
                if not "!check_dir!"=="" (
                    mkdir "!dir_path!" > nul
                    echo Created directory: !dir_path!
                )
            )
        )

        set "CURRENT_FILE=!filepath!"
        set "STATE=header"
        echo Processing file: !CURRENT_FILE!
        goto :continue_loop
    )

    if "!STATE!"=="header" (
        echo "!line!" | findstr /X /C:"----------------------------------------" > nul
        if !errorlevel! equ 0 (
            set "STATE=content"
            type nul > "!CURRENT_FILE!"
            goto :continue_loop
        ) else (
            type nul > "!CURRENT_FILE!"
            (echo !line!)>>"!CURRENT_FILE!"
            set "STATE=content"
            goto :continue_loop
        )
    )

    if "!STATE!"=="content" (
        (echo(!line!)>>"!CURRENT_FILE!"
    )

    :continue_loop
)

echo Build process finished.
endlocal
exit /b 0
