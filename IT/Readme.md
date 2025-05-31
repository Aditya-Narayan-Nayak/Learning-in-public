# IT-Audit-VersionChecker.ps1

I've created a comprehensive PowerShell script for IT audit purposes that checks versions of applications and runtimes commonly found on banking PCs. Here's what the script does:

## Key Features:

* **Operating System Information:** Windows version, build number, and edition
* **Runtime Environments:**
    * .NET Framework (all versions)
    * .NET Core/.NET 5+ runtimes
    * Java (all versions including OpenJDK)
    * PowerShell version
* **Web Browsers:**
    * Google Chrome
    * Mozilla Firefox
    * Microsoft Edge
    * Internet Explorer
* **Microsoft Office Suite:**
    * Office 365/Microsoft 365
    * Office 2019/2016/2013/2010
    * Individual Office applications (Word, Excel, PowerPoint, Outlook)
* **Adobe Products:**
    * Adobe Acrobat/Reader
    * Adobe Flash (legacy)
* **Security Software:** Checks for major antivirus/security solutions
* **Banking/Financial Software:** Citrix, VMware, TeamViewer, VPN clients, RSA tokens, etc.

## Script Capabilities:

* **Multi-source Registry Scanning:** Checks both 32-bit and 64-bit program installations
* **Detailed Information:** Shows version, publisher, and install date where available
* **Color-coded Output:** Easy-to-read console output with status indicators
* **CSV Export:** Automatically exports results to a timestamped CSV file
* **Summary Report:** Provides overview of total items checked vs. found
* **Error Handling:** Gracefully handles missing applications or registry access issues

## Usage Instructions:

1.  Save the script as `IT-Audit-VersionChecker.ps1`
2.  Run PowerShell as **Administrator** (recommended for complete system access)
3.  Execute: `.\IT-Audit-VersionChecker.ps1`
4.  Review the console output and find the exported CSV file in the same directory

---

The script is designed to be safe for banking environments and only reads system information without making any changes. It's perfect for compliance audits, security assessments, and inventory management.