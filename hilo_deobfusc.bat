::------------------------------------------------------------------------------
:: NAME
::     hilo_deobfuscator.bat
::
:: DESCRIPTION
::     Performs a basic substitution cipher to deobfuscate scripts that have
::     had their text replaced with characters from the CHCP 708 charset.
::
:: REQUIREMENTS
::     jrepl.bat (https://www.dostips.com/forum/viewtopic.php?f=3&t=6044)
::
:: AUTHOR
::     sintrode
::------------------------------------------------------------------------------
:: NOTE: This should be the last step in any multi-step deobfuscation. Prior
::       steps include removing the UTF-16 LE BOM and eliminating any empty
::       variables, preferably with the regex s/%[_\x80-\xFF][_\x80-\xFF]+?%//g
::------------------------------------------------------------------------------
@echo off
setlocal
if "%~1"=="" (
	echo USAGE: %~0 ^<input file^>
	exit /b
)

set "lo= !#$&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]\c_`abcdefghijklmnopqrstuvwxyz{|}~\q"
set "hi=¡¢¤¥§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ£"

if not exist JREPL.BAT (
	echo jrepl.bat not found. Downloading it...
	curl -ksL https://www.dostips.com/forum/download/file.php?id=605 -o jrepl.zip
	tar -xvf jrepl.zip 2>nul
	del jrepl.zip
)
if not exist "%~1" (
	echo Specified input file %1 does not exist.
	exit /b
)

set "temp_file=%~n1.tmp"
if exist "%temp_file%" del "%temp_file%"
if exist "___%~nx1" del "___%~nx1"
call jrepl.bat "%hi%" "%lo%" /T "" /X /A /F "%~1" /O "%temp_file%"
call jrepl.bat "\x25(.)\x25" "$1" /XSEQ /F "%temp_file%" /O -
ren "%temp_file%" "___%~nx1"
