# GroupPolicy-RemediateFollina
Powershell | Group Policy | Remediates Follina Vulnerability by disabling file preview and remote diagnostics tool

Howto (AD DS deployment):
1. RDP to DC
2. Download and unzip GroupPolicy-RemediateFollina.zip to desktop, such that the main folder GroupPolicy-RemediateFollina is on the desktop.
(Please ensure the folder isn't nested inside an indentical folder, this may happen with some unzipping tools, this will make it not work.)
3. Double click GroupPolicy-RemediateFollina.bat, which will automatically attempt to elevate to admin privileges, and run the GroupPolicy-RemediateFollina.ps1 script with said privileges.
3b. You can use the script without the .bat file, it's just there for ease of execution.
4. Done

Howto (Intune deployment):
1. Connect to Endpoint Manager (MEM) with sufficient privileges
2. Create a configuration profile of 'Settings Catalog' type
3. Select the 'Explorer Frame Pane' subcategory
4. Select the 'Turn off Previe Pane (User)' setting
5. Deploy to all users
6. Create/add a Script
7. Upload IntuneScript-RemediateFollina.ps1 for Script Location
8. Set 'Run script in 64 bit powershell Host' to Yes
9. Assign it to a group that contains all users/endpoints.
10. Done

Howto (Individual device deployment):
1. Download LocalScript-RemediateFollina.exe to the device
(LocalScript-RemediateFollina.ps1 is identical to the .exe. Use this if you're paranoid.)
2. Run it as admin
3. Done
