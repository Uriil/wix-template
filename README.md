# Wix Template
Simple template to automate MSI creation.

# Example
```powershell
PS:> .\createInstaller.ps1 -DirectoryToCollect Data -ApplicationName "Test App" -InstallationFile "install.ps1"
```

**DirectoryToCollect[Mandatory]**: path to folder to collect files

**ApplicationName[Mandatory]**: installer and application name

**InstallationFile[Optional]**: powershell file to be run after installation
