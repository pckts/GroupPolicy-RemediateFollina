# GroupPolicy-RemediateFollina
Powershell | Group Policy | Remediates Follina Vulnerability by disabling file preview in explorer and Troubleshooting Wizards

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
4. Select the 'Turn off Preview Pane (User)' setting
5. Select the 'Scripted Diagnostics' subcategory
6. Select the 'Troubleshooting: Allow users to access and run Troubleshooting Wizards' setting
7. Set 'Turn off preview pane' to Enabled
8. Set 'Troubleshooting: Allow users (...)' to Disabled
9. Deploy to all users and devices
10. Create
11. Done

Howto (Individual device deployment):
1. Download LocalScript-RemediateFollina.exe to the device
(LocalScript-RemediateFollina.ps1 is identical to the .exe. Use this if you're paranoid.)
2. Run it as admin
3. Done
