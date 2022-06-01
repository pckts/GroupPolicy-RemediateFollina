# Disables File Preview in Explorer and disables Remote Diagnostics tool
# This remediates the Follina vulnerability

#========#
# ^^^^^^ #
# README #
#========#

########################################################################################################################################################################################################################

#Checks if run as admin

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) -eq $false)
{
    cls
    write-host "Please run as admin..."
    sleep 1
    break
}

#Removes GPO if already existing, this allows re-runs if unexpected output
Remove-GPO -Name ITR-RemediateFollina

#Imports the GPOs and links them at domain root
$Partition = Get-ADDomainController | Select DefaultPartition
$GPOSource = "$home\desktop\GroupPolicy-RemediateFollina"
import-gpo -BackupId 030E7D76-994E-4B82-A30C-F465F106503B -TargetName ITR-RemediateFollina -path $GPOSource -CreateIfNeeded
Get-GPO -Name "ITR-RemediateFollina" | New-GPLink -Target $Partition.DefaultPartition

#Creates link on each OU with inheritance disabled
$Blocked = Get-ADOrganizationalUnit -Filter * | Get-GPInheritance | Where-Object {$_.GPOInheritanceBlocked} | select-object Path 
Foreach ($B in $Blocked) 
{
    New-GPLink -Name "ITR-RemediateFollina" -Target $B.Path
    Set-GPLink -Name "ITR-RemediateFollina" -Enforced Yes -Target $B.Path
}
pause