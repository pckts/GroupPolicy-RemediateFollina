# Disables File Preview in Explorer and disables Remote Diagnostics support
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
Remove-GPO -Name RemediateFollina

#Imports the GPOs and links them at domain root, as well as enforces it
$Partition = Get-ADDomainController | Select DefaultPartition
$GPOSource = "$home\desktop\GroupPolicy-RemediateFollina"
import-gpo -BackupId 2B7ED803-C83D-4F74-8BD9-5690D0C0251F -TargetName RemediateFollina -path $GPOSource -CreateIfNeeded
Get-GPO -Name "RemediateFollina" | New-GPLink -Target $Partition.DefaultPartition
Set-GPLink -Name "RemediateFollina" -Enforced Yes -Target $Partition.DefaultPartition

#Creates link on each OU with inheritance disabled, as well as enforces it
$DisabledInheritances = Get-ADOrganizationalUnit -Filter * | Get-GPInheritance | Where-Object {$_.GPOInheritanceBlocked} | select-object Path 
Foreach ($DisabledInheritance in $DisabledInheritances) 
{
    New-GPLink -Name "RemediateFollina" -Target $DisabledInheritance.Path
    Set-GPLink -Name "RemediateFollina" -Enforced Yes -Target $DisabledInheritance.Path
}
