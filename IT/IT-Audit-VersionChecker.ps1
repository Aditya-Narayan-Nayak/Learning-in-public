# IT Audit - Application and Runtime Version Checker
# Script to check installed application versions for banking PC audit
# Author: IT Audit Script
# Date: $(Get-Date)

Write-Host "=== IT Audit - Application Version Check ===" -ForegroundColor Green
Write-Host "Computer: $env:COMPUTERNAME" -ForegroundColor Yellow
Write-Host "Date: $(Get-Date)" -ForegroundColor Yellow
Write-Host "User: $env:USERNAME" -ForegroundColor Yellow
Write-Host ""

# Function to get application version from registry
function Get-InstalledAppVersion {
    param([string]$AppName)
    
    $registryPaths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )
    
    foreach ($path in $registryPaths) {
        try {
            $apps = Get-ItemProperty $path -ErrorAction SilentlyContinue | 
                    Where-Object { $_.DisplayName -like "*$AppName*" }
            if ($apps) {
                return $apps | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
            }
        }
        catch {
            # Continue to next path
        }
    }
    return $null
}

# Function to format output
function Write-AppInfo {
    param([string]$AppName, [object]$AppInfo, [string]$CustomVersion = "")
    
    Write-Host "`n--- $AppName ---" -ForegroundColor Cyan
    
    if ($CustomVersion) {
        Write-Host "Version: $CustomVersion" -ForegroundColor White
    }
    elseif ($AppInfo) {
        if ($AppInfo -is [array]) {
            foreach ($app in $AppInfo) {
                Write-Host "Name: $($app.DisplayName)" -ForegroundColor White
                Write-Host "Version: $($app.DisplayVersion)" -ForegroundColor White
                if ($app.Publisher) { Write-Host "Publisher: $($app.Publisher)" -ForegroundColor Gray }
                if ($app.InstallDate) { Write-Host "Install Date: $($app.InstallDate)" -ForegroundColor Gray }
                Write-Host ""
            }
        }
        else {
            Write-Host "Name: $($AppInfo.DisplayName)" -ForegroundColor White
            Write-Host "Version: $($AppInfo.DisplayVersion)" -ForegroundColor White
            if ($AppInfo.Publisher) { Write-Host "Publisher: $($AppInfo.Publisher)" -ForegroundColor Gray }
            if ($AppInfo.InstallDate) { Write-Host "Install Date: $($AppInfo.InstallDate)" -ForegroundColor Gray }
        }
    }
    else {
        Write-Host "Status: Not Found or Not Installed" -ForegroundColor Red
    }
}

# Create results array for export
$AuditResults = @()

# Check Windows Version
Write-Host "`n=== OPERATING SYSTEM ===" -ForegroundColor Green
$OSInfo = Get-CimInstance -ClassName Win32_OperatingSystem
Write-Host "OS: $($OSInfo.Caption)" -ForegroundColor White
Write-Host "Version: $($OSInfo.Version)" -ForegroundColor White
Write-Host "Build: $($OSInfo.BuildNumber)" -ForegroundColor White
$AuditResults += [PSCustomObject]@{Category="OS"; Name="Windows"; Version="$($OSInfo.Version) Build $($OSInfo.BuildNumber)"; Status="Installed"}

# Check .NET Framework Versions
Write-Host "`n=== .NET FRAMEWORK ===" -ForegroundColor Green
try {
    $dotNetVersions = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP" -Recurse |
        Get-ItemProperty -Name Version, Release -ErrorAction SilentlyContinue |
        Where-Object { $_.PSChildName -match '^(?!S)\p{L}' } |
        Select-Object PSChildName, Version, Release
    
    foreach ($version in $dotNetVersions) {
        Write-Host ".NET Framework $($version.PSChildName): $($version.Version)" -ForegroundColor White
        $AuditResults += [PSCustomObject]@{Category=".NET"; Name=".NET Framework $($version.PSChildName)"; Version=$version.Version; Status="Installed"}
    }
}
catch {
    Write-Host ".NET Framework: Error checking versions" -ForegroundColor Red
}

# Check .NET Core/.NET 5+ versions
try {
    $dotnetCommand = Get-Command dotnet -ErrorAction SilentlyContinue
    if ($dotnetCommand) {
        $dotnetInfo = & dotnet --list-runtimes 2>$null
        if ($dotnetInfo) {
            Write-Host "`n.NET Core/5+ Runtimes:" -ForegroundColor Yellow
            $dotnetInfo | ForEach-Object {
                Write-Host $_ -ForegroundColor White
                $AuditResults += [PSCustomObject]@{Category=".NET Core"; Name=$_.Split()[0]; Version=$_.Split()[1]; Status="Installed"}
            }
        }
    }
}
catch {
    Write-Host ".NET Core: Not found" -ForegroundColor Red
}

# Check Web Browsers
Write-Host "`n=== WEB BROWSERS ===" -ForegroundColor Green

# Chrome
$chrome = Get-InstalledAppVersion "Google Chrome"
Write-AppInfo "Google Chrome" $chrome
if ($chrome) {
    $AuditResults += [PSCustomObject]@{Category="Browser"; Name="Google Chrome"; Version=$chrome.DisplayVersion; Status="Installed"}
} else {
    $AuditResults += [PSCustomObject]@{Category="Browser"; Name="Google Chrome"; Version="N/A"; Status="Not Found"}
}

# Firefox
$firefox = Get-InstalledAppVersion "Mozilla Firefox"
Write-AppInfo "Mozilla Firefox" $firefox
if ($firefox) {
    $AuditResults += [PSCustomObject]@{Category="Browser"; Name="Mozilla Firefox"; Version=$firefox.DisplayVersion; Status="Installed"}
} else {
    $AuditResults += [PSCustomObject]@{Category="Browser"; Name="Mozilla Firefox"; Version="N/A"; Status="Not Found"}
}

# Edge
$edge = Get-InstalledAppVersion "Microsoft Edge"
Write-AppInfo "Microsoft Edge" $edge
if ($edge) {
    $AuditResults += [PSCustomObject]@{Category="Browser"; Name="Microsoft Edge"; Version=$edge.DisplayVersion; Status="Installed"}
} else {
    $AuditResults += [PSCustomObject]@{Category="Browser"; Name="Microsoft Edge"; Version="N/A"; Status="Not Found"}
}

# Internet Explorer
try {
    $ieVersion = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Internet Explorer" -Name svcVersion -ErrorAction SilentlyContinue).svcVersion
    if (-not $ieVersion) {
        $ieVersion = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Internet Explorer" -Name Version -ErrorAction SilentlyContinue).Version
    }
    Write-AppInfo "Internet Explorer" $null $ieVersion
    if ($ieVersion) {
        $AuditResults += [PSCustomObject]@{Category="Browser"; Name="Internet Explorer"; Version=$ieVersion; Status="Installed"}
    }
}
catch {
    $AuditResults += [PSCustomObject]@{Category="Browser"; Name="Internet Explorer"; Version="N/A"; Status="Not Found"}
}

# Check Microsoft Office
Write-Host "`n=== MICROSOFT OFFICE ===" -ForegroundColor Green
$officeVersions = @(
    "Microsoft Office Professional",
    "Microsoft Office Standard",
    "Microsoft Office 365",
    "Microsoft 365",
    "Office 16",
    "Office 15",
    "Office 14"
)

$officeFound = $false
foreach ($officeVersion in $officeVersions) {
    $office = Get-InstalledAppVersion $officeVersion
    if ($office) {
        Write-AppInfo $officeVersion $office
        $AuditResults += [PSCustomObject]@{Category="Office Suite"; Name=$office.DisplayName; Version=$office.DisplayVersion; Status="Installed"}
        $officeFound = $true
        break
    }
}

if (-not $officeFound) {
    # Check individual Office applications
    $officeApps = @("Microsoft Word", "Microsoft Excel", "Microsoft PowerPoint", "Microsoft Outlook")
    foreach ($app in $officeApps) {
        $appInfo = Get-InstalledAppVersion $app
        if ($appInfo) {
            Write-AppInfo $app $appInfo
            $AuditResults += [PSCustomObject]@{Category="Office App"; Name=$appInfo.DisplayName; Version=$appInfo.DisplayVersion; Status="Installed"}
        }
    }
}

# Check Java
Write-Host "`n=== JAVA ===" -ForegroundColor Green
$javaVersions = @("Java", "Java 8", "Java(TM)", "OpenJDK")
$javaFound = $false

foreach ($javaVersion in $javaVersions) {
    $java = Get-InstalledAppVersion $javaVersion
    if ($java) {
        Write-AppInfo "Java Runtime" $java
        if ($java -is [array]) {
            foreach ($j in $java) {
                $AuditResults += [PSCustomObject]@{Category="Runtime"; Name=$j.DisplayName; Version=$j.DisplayVersion; Status="Installed"}
            }
        } else {
            $AuditResults += [PSCustomObject]@{Category="Runtime"; Name=$java.DisplayName; Version=$java.DisplayVersion; Status="Installed"}
        }
        $javaFound = $true
    }
}

if (-not $javaFound) {
    Write-Host "Java: Not Found" -ForegroundColor Red
    $AuditResults += [PSCustomObject]@{Category="Runtime"; Name="Java"; Version="N/A"; Status="Not Found"}
}

# Check Adobe Products
Write-Host "`n=== ADOBE PRODUCTS ===" -ForegroundColor Green
$adobeProducts = @("Adobe Acrobat", "Adobe Reader", "Adobe Flash")
foreach ($product in $adobeProducts) {
    $adobe = Get-InstalledAppVersion $product
    Write-AppInfo $product $adobe
    if ($adobe) {
        $AuditResults += [PSCustomObject]@{Category="Adobe"; Name=$adobe.DisplayName; Version=$adobe.DisplayVersion; Status="Installed"}
    } else {
        $AuditResults += [PSCustomObject]@{Category="Adobe"; Name=$product; Version="N/A"; Status="Not Found"}
    }
}

# Check Security Software
Write-Host "`n=== SECURITY SOFTWARE ===" -ForegroundColor Green
$securityProducts = @("Symantec", "McAfee", "Norton", "Kaspersky", "Trend Micro", "ESET", "Bitdefender", "Windows Defender")
foreach ($product in $securityProducts) {
    $security = Get-InstalledAppVersion $product
    if ($security) {
        Write-AppInfo $product $security
        $AuditResults += [PSCustomObject]@{Category="Security"; Name=$security.DisplayName; Version=$security.DisplayVersion; Status="Installed"}
    }
}

# Check PowerShell Version
Write-Host "`n=== POWERSHELL ===" -ForegroundColor Green
$psVersion = $PSVersionTable.PSVersion.ToString()
Write-Host "PowerShell Version: $psVersion" -ForegroundColor White
$AuditResults += [PSCustomObject]@{Category="Runtime"; Name="PowerShell"; Version=$psVersion; Status="Installed"}

# Check Common Banking/Financial Software
Write-Host "`n=== BANKING/FINANCIAL SOFTWARE ===" -ForegroundColor Green
$bankingSoftware = @("Citrix", "VMware", "TeamViewer", "VPN", "RSA", "SafeNet")
foreach ($software in $bankingSoftware) {
    $bankingApp = Get-InstalledAppVersion $software
    if ($bankingApp) {
        Write-AppInfo $software $bankingApp
        if ($bankingApp -is [array]) {
            foreach ($app in $bankingApp) {
                $AuditResults += [PSCustomObject]@{Category="Banking/Financial"; Name=$app.DisplayName; Version=$app.DisplayVersion; Status="Installed"}
            }
        } else {
            $AuditResults += [PSCustomObject]@{Category="Banking/Financial"; Name=$bankingApp.DisplayName; Version=$bankingApp.DisplayVersion; Status="Installed"}
        }
    }
}

# Export results to CSV
$exportPath = ".\IT_Audit_Results_$(Get-Date -Format 'yyyyMMdd_HHmmss').csv"
$AuditResults | Export-Csv -Path $exportPath -NoTypeInformation
Write-Host "`n=== AUDIT COMPLETE ===" -ForegroundColor Green
Write-Host "Results exported to: $exportPath" -ForegroundColor Yellow

# Display summary
Write-Host "`n=== SUMMARY ===" -ForegroundColor Green
$totalApps = $AuditResults.Count
$installedApps = ($AuditResults | Where-Object {$_.Status -eq "Installed"}).Count
$notFoundApps = ($AuditResults | Where-Object {$_.Status -eq "Not Found"}).Count

Write-Host "Total items checked: $totalApps" -ForegroundColor White
Write-Host "Items found/installed: $installedApps" -ForegroundColor Green
Write-Host "Items not found: $notFoundApps" -ForegroundColor Red

Write-Host "`nPress any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")