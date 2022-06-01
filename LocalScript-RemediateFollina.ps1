New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoReadingPane" -Value ”1” -PropertyType "DWORD"
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows" -Name "ScriptedDiagnostics" –Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\ScriptedDiagnostics" -Name "EnableDiagnostics" -Value ”0” -PropertyType "DWORD"
