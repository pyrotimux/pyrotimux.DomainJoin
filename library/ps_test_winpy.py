#! Python

import json
import subprocess
import time
import os

path = 'C:\\vagrant\\ansible\\configs\\setup\\sql\\SETUP.EXE'
test_path = 'C:\Program Files (x86)\Microsoft SQL Server\120\Shared\dbghelp.dll'
extra_args = '/Q /ACTION=Install /IACCEPTSQLSERVERLICENSETERMS /ENU /FEATURES=SQL,Tools /INSTANCENAME=MSSQLSERVER'

#subprocess.check_call([path, extra_args], shell=True)
os.system(path + " "+ extra_args)
print(json.dumps({"hello" : "world", "changed": True}))
