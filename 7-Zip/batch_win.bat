REM compress with utf-8
for /d %%X in (*) do "C:\Program Files\7-Zip\7z.exe" a "%%X.zip" "%%X\" -mcu