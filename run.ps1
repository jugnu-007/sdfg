
$SQLSoftware = @("MySQL", "PostgreSQL-32bit", "PostgreSQL-64bit") ################# SQLSoftware
$QueryArray = @("SQL Software Version", "Username", "Password", "Database Name", "Server Instance", "Server Port Number") ################# QueryArray



##################################################################### Edit for SQLSoftware #####################################################################

function WhatSQL{
    param(
        [string]$arch,
        [string]$v
    )
    if ($arch -eq "MySQL") { return "MySQL$v"}
    elseif ($arch -eq "PostgreSQL-32bit") { return "postgresql-x32-$v"}
    elseif ($arch -eq "PostgreSQL-64bit") { return "postgresql-x64-$v"}
}

function WhatPort {
    param(
        [string]$sqlPort
    )
    switch ($sqlPort) {
        "MySQL" { return 3306}
        "PostgreSQL-32bit" { return 5432}
        "PostgreSQL-64bit" { return 5432}
    }
}


############################################################### No Edit Zone #############################################################################

cls
$neoPath = "./neoLibrary.bin"
if (-not(Test-Path $neoPath)) {
    Write-Host "`n`t'" -n -f Red
    Write-Host "$neoPath" -n -f Yellow
    Write-Host "' file not found! 😲`n" -f Red
    return
}
try {
    $neoArray = (3,9,2,5,56,34,254,20,10,11,4,23,2,54,43,33,12,64,72,71,6,5,51,3)
    $neoBytes = [System.Security.Cryptography.ProtectedData]::Unprotect([System.IO.File]::ReadAllBytes($neoPath),$neoArray , 'CurrentUser')
    Invoke-Expression -Command $([System.Text.Encoding]::UTF8.GetString($neoBytes))
} catch {
    Write-Host "`n`t'" -n -f Red
    Write-Host "$neoPath" -n -f Yellow
    Write-Host "' file is tempered 😲`n" -f Red
    return
}
$date = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

$nolog = $false
$isIt = $false
for ($i = 0; $i -lt $($args.Count); $i += 1) {
    switch ($args[$i]) {
        "-nolog" { $nolog = $true }
        "-config" { $isConfig = $true }
        "-it" { $isIt = $true }
        "-debug" { $isDebug = $true }
        default {
            $errMsg = "Invalied arrgument is passed 😑"
            Write-Host "`n$(relativePosition $($errMsg.Length))$errMsg`n" -f Red
            return
        }
    }
}

$jsonFilePath = Join-Path -Path $PSScriptRoot -ChildPath '.\user.json'
$jsonFileBackupPath = Join-Path -Path $PSScriptRoot -ChildPath '.\user-backup.json'


if (-not(Test-Path $jsonFilePath -PathType Leaf) -and $nolog -eq $false) {

    $jsonData = @{}
    $Result1 = $(neoChoice $SQLSoftware "SQL Software")
    $Result2 = $(neoInput $QueryArray)
    $jsonData2 = [ordered]@{}

    for ($eachEle = 0; $eachEle -lt $Result2.Length; $eachEle++) {
        $jsonData2[$($QueryArray[$eachEle])] = $Result2[$eachEle]
    }
    $jsonData2["SQL Software"] = $Result1

    $jsonData["$Result1"] = @($jsonData2)

    $jsonContent = $jsonData | ConvertTo-Json -Depth 10
    $jsonContent | Set-Content -Path $jsonFilePath
    Set-Content -Path $jsonFileBackupPath -Value "// => `{`"Date Time`": `"$date`"`}"
    Add-Content -Path $jsonFileBackupPath -Value (Get-Content -Path $jsonFilePath)
    $viewFlag = $true

} elseif ($isConfig -eq $true) {
    try {
        $jsonContent = Get-Content -Path $jsonFilePath -Raw
        $jsonObject = $jsonContent | ConvertFrom-Json

        $Result1 = $(neoChoice $SQLSoftware "SQL Software")
        $Result2 = $(neoInput $QueryArray)   
        $jsonData2 = [ordered]@{}

        for ($eachEle = 0; $eachEle -lt $Result2.Length; $eachEle++) {
            $jsonData2[$($QueryArray[$eachEle])] = $Result2[$eachEle]
        }
        $jsonData2["SQL Software"] = $Result1

        if ($jsonObject."$Result1") {
            $jsonObject | Get-Member -MemberType NoteProperty | ForEach-Object {
                if ($_.Name -eq $Result1) {
                    $jsonObject.PSObject.Properties.Remove($_.Name)
                }
            }
        }
        $jsonObject | Add-Member -MemberType NoteProperty -Name "$Result1" -Value @($jsonData2)

        $jsonContent = $jsonObject | ConvertTo-Json -Depth 10
        $jsonContent | Set-Content -Path $jsonFilePath
        Add-Content -Path $jsonFileBackupPath -Value "// => `{`"Date Time`": `"$date`"`}"
        Add-Content -Path $jsonFileBackupPath -Value (Get-Content -Path $jsonFilePath)
        $viewFlag = $true

    } catch {
        if ((Test-Path $jsonFilePath)) {
            Remove-Item -Path $jsonFilePath -Force
        }
        $errMsg = "Something is wrong happening with you 👀"
        Write-Host "`n$(relativePosition $($errMsg.Length))$errMsg" -ForegroundColor Red
        Write-Host "$(relativePosition $($errMsg.Length))Please run the previous command again 🤏`n" -ForegroundColor Yellow
        return
    }

}

################################################################## Edit for QueryArray ########################################################################

if ($noLog -eq $true) {
    $Result1 = $(neoChoice $SQLSoftware "SQL Software")
    $Result2 = $(neoInput $QueryArray) 
    $SQL = $Result1[0]
    $SQLv = $Result2[0]
    $Username = $Result2[1]
    $Password = $Result2[2]
    $DatabaseName = $Result2[3]
    $ServerInstance = $Result2[4]
    $PORT = $Result2[5]
    Start-Sleep -Seconds 3
} else {
    try {
        $jsonContent = Get-Content -Path $jsonFilePath -Raw
        $jsonObject = $jsonContent | ConvertFrom-Json

        $lastKey = $jsonObject.PSObject.Properties | Select-Object -Last 1 | ForEach-Object { $_.Name }

        $jsonObject = $jsonObject."$($lastKey)"
        $SQL = $($jsonObject."SQL Software")

        $SQLv = $($jsonObject."SQL Software Version")
        $Username = $($jsonObject.Username)
        $Password = $($jsonObject.Password)
        $DatabaseName = $($jsonObject."Database Name")
        $ServerInstance = $($jsonObject."Server Instance")
        $PORT = $($jsonObject."Server Port Number")

    } catch {
        if ((Test-Path $jsonFilePath)) {
            Remove-Item -Path $jsonFilePath -Force
        }
        $errMsg = "Something is wrong happening with you 👀"
        Write-Host "`n$(relativePosition $($errMsg.Length))$errMsg" -ForegroundColor Red
        Write-Host "$(relativePosition $($errMsg.Length))Please run the previous command again 🤏`n" -ForegroundColor Yellow
        return
    }
}

###################################################################### No Edit Zone #########################################################################################


if (($DatabaseName -eq '') -or ($Username -eq '') -or ($Password -eq '') -or ($SQL -eq '') -or ($SQLv -eq '')) {
    if ((Test-Path $jsonFilePath)) {
        Remove-Item -Path $jsonFilePath -Force
    }
    $errMsg = "Error: Critical values (SQL Software Version, Username, Password or DataBase Name) cannot be null 😒"
    Write-Host "`n$(relativePosition $($errMsg.Length))$errMsg" -ForegroundColor Red
    $errMsg = "Please run the previous command again 🤏"
    Write-Host "$(relativePosition $($errMsg.Length))$errMsg`n" -ForegroundColor Yellow
    return
}







if ($ServerInstance -eq '' -or $ServerInstance -eq $null) {
    $ServerInstance = "localhost"
}

if ($PORT -eq "" -or $PORT -eq $null) {
    $PORT = WhatPort $SQL
} else {
    try {
        $PORT = [int]$PORT
    } catch {
        $errMsg = "Error: You have entered Port Number as string 😅"
        Write-Host "`n$(relativePosition $($errMsg.Length))$errMsg`n" -ForegroundColor Red
        return
    }
}

$portInUse = Test-NetConnection -ComputerName $ServerInstance -Port $PORT
if (-not $portInUse.TcpTestSucceeded) {
    $arrgumentSQLStart = $(WhatSQL $SQL $SQLv)
    
    Start-Process powershell -Verb RunAs -ArgumentList "net start $arrgumentSQLStart"
    if(-not($?)) {
        Write-Host "`n`n`n`t$SQL server is not running on port $PORT." -ForegroundColor Magenta
        Write-Host "`tRun Windows PowerShell as Administrator:" -n -ForegroundColor Blue
        Write-Host " net start $(WhatSQL $SQL $SQLv)`n" -ForegroundColor Yellow
        return
    }
}


if ($viewFlag -eq $true) {
    Start-Sleep -Seconds 3
}

cls
$sqlFilesFolder = $(neoInput @("Directory Path"))

if ($sqlFilesFolder -eq '' -and $isIt -eq $false) {
    $errMsg = "Directory path cannot be null 😒"
    Write-Host "`n$(relativePosition $($errMsg.Length))$errMsg`n" -f Red
    return
}

$outputFile = "./hello.txt"


















######################################################################### MySQL #########################################################################

$console = $Host.UI.RawUI
$sensitiveFile = "./user.cnf"


if ($SQL -like "*MySQL*") {
    $sensitiveFile = "./user.cnf"
    Set-Content -Path $sensitiveFile -Value "[client]`nhost=$ServerInstance`nuser=$Username`npassword=$Password`nport=$PORT`n"

    Write-Host
    foreach ($file in Get-ChildItem -Path $sqlFilesFolder -Recurse  -Filter *.sql | Sort-Object ) {
        $SQL_COMMANDS = @"
        source $($file.FullName)
"@
        Add-Content -Path $outputFile -Value "$(multiplexChar $console.BufferSize.Width '█')"

        $n =  [math]::Floor($($console.BufferSize.Width - $($file.Name.Length) - 2) / 2)
        Add-Content -Path $outputFile -Value "$(multiplexChar $n '█') $((Get-Item $file).Name) $(multiplexChar $n '█')"

        Add-Content -Path $outputFile -Value "$(multiplexChar $console.BufferSize.Width '█')"
        & mysql --defaults-extra-file=./user.cnf  -e $SQL_COMMANDS -D $DatabaseName >> $OutputFile
    }

    if(-not($?)) {
        $FinalResult = $true
    }

    Add-Content -Path $outputFile -Value "$(multiplexChar $console.BufferSize.Width '█')"
} 


################################################################ PostgreSQl #######################################################################

elseif ($SQL -like "*PostgreSQL*") {
    $sensitiveFile = "$env:APPDATA\postgresql\pgpass.conf"
    if (-not(Test-Path "$env:APPDATA\postgresql\" -PathType container)) {
        New-Item -Path "$env:APPDATA\postgresql\" -ItemType Directory -ErrorAction Stop | Out-Null
    }
    Set-Content -Path $sensitiveFile -Value "$ServerInstance`:$PORT`:$DatabaseName`:$Username`:$Password"

    Write-Host
    foreach ($file in Get-ChildItem -Path $sqlFilesFolder -Recurse  -Filter *.sql | Sort-Object ) {
        Add-Content -Path $outputFile -Value "$(multiplexChar $console.BufferSize.Width '█')"

        $n =  [math]::Floor($($console.BufferSize.Width - $($file.Name.Length) - 2) / 2)
        Add-Content -Path $outputFile -Value "$(multiplexChar $n '█') $((Get-Item $file).Name) $(multiplexChar $n '█')"

        Add-Content -Path $outputFile -Value "$(multiplexChar $console.BufferSize.Width '█')"
        &  psql -d $DatabaseName -U $Username -f $($file.FullName) >> $outputFile
    }

    if(-not($?)) {
        $FinalResult = $true
    }

    Add-Content -Path $outputFile -Value "$(multiplexChar $console.BufferSize.Width '█')" 
}

############################################################## Future Append SQL  #################################################################

# elseif ($SQL -eq "mssql") {}
# elseif ($SQL -eq "ariadb") {}
# elseif ($SQL -eq "mssql") {}



























################################################################### No Edit Zone ###################################################################################


if (($isIt -eq $false) -and (Test-Path $sensitiveFile)) {
    Remove-Item -Path $sensitiveFile -Force
}

$debugTime = 3
if ($isDebug -eq $true) {
    $debugTime = 20
}

for ($i = 0; $i -lt $debugTime; $i++){
    if ($host.UI.RawUI.KeyAvailable) {
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp,IncludeKeyDown")
        if ($key.KeyDown -eq "True"){
            break    
            }           
        } 
    Start-Sleep -Seconds 1
}



if ((Test-Path $outputFile)) {
    Get-Content -Path $outputFile | ForEach-Object {
        if ($_ -like '*█*'){
            Write-Host "$_" -ForegroundColor Blue
        } else {
            Write-Host "`t$_" -ForegroundColor Yellow
        }
    }
    Remove-Item -Path $outputFile -Force
}

if ($FinalResult -eq $true) {
    $FinalResultMsg1 = "SQL command not running successfully 🎻"
    $FinalResultMsg2 = "Are you sure the provided information or your code is correct 🙉"
    Write-Host "`n`t$(relativePosition $($FinalResultMsg1.Length))$FinalResultMsg1" -f Red
    Write-Host "`t$(relativePosition $($FinalResultMsg2.Length))$FinalResultMsg2`n" -f Yellow
}

############################################################ For Interactive ##########################################################


if ($isIt -eq $true) {
    if ($SQL -eq "mysql") {
        Start-Process mysql -ArgumentList "--defaults-extra-file=$sensitiveFile -D $DatabaseName"
    } elseif ($SQL -eq "psql") {
        Start-Process psql -ArgumentList "-d jay_neo -U neo"
    }
        
    Start-Sleep 2
    if ((Test-Path $sensitiveFile)) {
        Remove-Item -Path $sensitiveFile -Force
    }
}

# code by jay-neo