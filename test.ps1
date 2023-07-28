# Download FSLogix installation files
$fslogixInstallerUrl = "<fslogix_installer_url>"
$fslogixInstallerPath = "C:\Temp\FSLogixInstaller.exe" # Change to desired installation path
Invoke-WebRequest -Uri $fslogixInstallerUrl -OutFile $fslogixInstallerPath
cd c:\avd
mkdir ckumar
cd
if ( $ckumar -eq 10){

$Password = "test@123"#
# Install FSLogix
Start-Process -FilePath $fslogixInstallerPath -ArgumentList "/quiet" -Wait
cd c:\test\ckumar
# Enable FSLogix for all users on the session host
$fslogixRegPath = "HKLM:\SOFTWARE\FSLogix\Profiles"
$fslogixRegValue = "Enabled"
Set-ItemProperty -Path $fslogixRegPath -Name $fslogixRegValue -Value 1

# Add FSLogix to the RDS redirection settings
$rdpRegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$rdpRegValue = "FSLogixRedirection" 
$rdpRegData = "1"
Set-ItemProperty -Path $rdpRegPath -Name $rdpRegValue -Value $rdpRegData

# Restart the session host to apply changes
Restart-Computer -Force
