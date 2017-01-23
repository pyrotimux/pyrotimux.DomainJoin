#!powershell
# (c) 2016, Phyo Shwe, and others
#
# This file is part of Ansible
#
# Ansible is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ansible is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ansible.  If not, see <http://www.gnu.org/licenses/>.

# WANT_JSON
# POWERSHELL_COMMON

$params = Parse-Args $args;

$path = Get-Attr $params "path" -failifempty $true
$state = Get-Attr $params "state" "present"
$test_path = Get-Attr $params "test_path" -failifempty $true
$extra_args = Get-Attr $params "extra_args" ""
$username = Get-Attr $params "user" -failifempty $true
$password = Get-Attr $params "pass" -failifempty $true


$result = New-Object psobject @{
    changed = $false
};

If (Test-Path $test_path)
{
    Exit-Json $result;
}

$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
 {
  Fail-Json (New-Object psobject) "This script needs to be run As Admin"
  Break
 }

# Start-Process -FilePath "$path" -ArgumentList "$extra_args" -Wait -Verb runas
$cmd = "$path $extra_args"
Invoke-Expression $cmd | Write-Verbose

Fail-Json (New-Object psobject) "$path $extra_args"

Set-Attr $result "changed" $true;
Exit-Json $result;
