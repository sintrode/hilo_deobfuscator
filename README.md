# hilo deobfuscator
Deobfuscates batch scripts that use the CHCP 708 character set as a substitution cipher.

If your obfuscated script contains lines like

    set "@lo@= !#$&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~""
    set "@hi@=¡¢¤¥§¨©ª«¬-®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ£"

and your script does not contain additional layers of obfuscation (a UTF-16 LE BOM, additional empty variables, etc.) then this will remove the substitution layer of obfuscation.

`lo` and `hi` can be replaced as situations warrant, keeping in mind that a few substitutions are required:
 * `\` needs to be passed as `\\`
 * `^` needs to be passed as `\c`
 * `"` needs to be passed as `\q`
 
 # This script MUST be saved as ANSI to work!
 I don't know why. I don't care why. Just do it.
 
 # Requirements
 JREPL.BAT must be in the same directory as this script. If it is not present, it will be downloaded from [DOSTips](https://www.dostips.com/forum/viewtopic.php?f=3&t=6044).
 
 # Usage
 `hilo_deobfuscator.bat <input file>`
