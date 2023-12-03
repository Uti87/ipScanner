@echo off
setlocal enabledelayedexpansion
chcp 65001 > nul 2>&1

if exist "ipaddresses.txt" del "ipaddresses.txt"

    echo Entra una Ip a escanear, lo haremos en 4 pasos, introduce el primer octeto:
    set /p "primerOcteto="

    if !primerOcteto! GEQ 0 IF !primerOcteto! LEQ 255 (
      GOTO segundoOcteto
    ) else (
      echo tiene que ser un numero entre 1 y 255
      GOTO salir
    )

    :segundoOcteto
    echo correcto, introduce el segundo octeto:
    set /p "segundoOcteto="
   if !segundoOcteto! GEQ 0 IF !segundoOcteto! LEQ 255 (
      GOTO tercerOcteto
    ) else (
      echo tiene que ser un numero entre 1 y 255
      GOTO salir
    )

    :tercerOcteto
      echo correcto, introduce el tercer octeto:
      set /p "tercerOcteto="
      if !tercerOcteto! GEQ 0 IF !tercerOcteto! LEQ 255 (
      GOTO confirmar
    ) else (
      echo tiene que ser un numero entre 1 y 255
      GOTO salir
    )
    
    :confirmar
    echo ¿la ip a escanear es la %primerOcteto%.%segundoOcteto%.%tercerOcteto%? S/n
    set /p "escaneo="
    if /i !escaneo! == s (
      set ip=!primerOcteto!.!segundoOcteto!.!tercerOcteto!
           for /l %%i in (1,1,255) do (    
           set /a "porcentaje=%%i * 100 / 255"
           if !porcentaje! equ 0 set /a porcentaje=1
           echo !porcentaje!^%% - !ip!.%%i
           for /f "tokens=*" %%a in (' ping -n 1 -w 1000 !ip!.%%i')  do (
           echo %%a | find "TTL" >> ipaddresses.txt
           )
        )
    )

:salir
pause


