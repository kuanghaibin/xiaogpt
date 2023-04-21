#!/bin/bash -

home=$(cd $(dirname $0);pwd)
cd ${home}

[[ $# -ne 2 ]] && { echo "please input config file"; exit; }

config="$1"

exec="xiaogpt.py"

running=$(ps -ef | grep -w "${exec}" | grep -w "${config}" | grep -v grep | wc -l)
if [[ ${running} -ge 1 ]];then
	echo "$(date) program is running, running_num:${running}"
	if [[ "$2" == "restart" || ${running} -gt 1 ]];then
		ps -ef | grep -w "${exec}" | grep -w "${config}" | grep -v grep  | gawk '{print $2}' | while read pid;do
			kill -9 $pid
		done
	else
		exit
	fi
fi


nohup python3 ${exec} --config ${config} >> log_${config} &
