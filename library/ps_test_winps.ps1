#!powershell
# WANT_JSON
# POWERSHELL_COMMON

$params = Parse-Args $args;

$path = Get-Attr $params "path" -failifempty $true
$state = Get-Attr $params "state" "present"
$test_path = Get-Attr $params "test_path" -failifempty $true
$extra_args = Get-Attr $params "extra_args" ""
$script_path = "C:\\vagrant\\ansible\\library\\ps_test_winpy.py"
$python_path = "C:/ProgramData/Chocolatey/bin/python.exe"
Start-Process -FilePath "$python_path" -ArgumentList "$script_path" -wait -verb runas
Set-Attr $result "changed" $true;
Exit-Json $result;
