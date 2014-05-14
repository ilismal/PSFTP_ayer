#Necesita PSFTP.EXE en la misma carpeta

#Eliminamos scripts de psftp previos
if (Test-Path .\sftp.txt)
{
    Remove-Item .\sftp.txt
}

#Calculamos qué día fue ayer
$ayer = (Get-Date).AddDays(-1).ToString('yyyyMMdd')

#Generamos el script de psftp para hoy
Write-Output "cd /dir_destino" | Out-File -encoding ascii .\sftp.txt
Write-Output "mget *_$ayer.txt" | Out-File -encoding ascii -Append .\sftp.txt
Write-Output "quit" | Out-File -encoding ascii -Append .\sftp.txt

#Obtenemos los ficheros por SFTP
& ".\PSFTP.EXE" usu@server.local -pw ***** -b .\sftp.txt

#Los copiamos al destino
Copy-Item *_$ayer.dat .\dst

#Eliminamos los ficheros descargados
Remove-Item .\*_$ayer.dat
