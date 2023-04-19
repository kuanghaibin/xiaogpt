#!/bin/bash -

home=$(cd $(dirname $0);pwd)
cd ${home}

ps ax | grep "xiaogpt.py" | grep -v grep

running=$(ps ax | grep "xiaogpt.py" | grep -v grep | wc -l)
if [[ ${running} -ge 1 ]];then
	echo "$(date) program is running, running_num:${running}"
	if [[ "$1" == "kill" || ${running} -gt 1 ]];then
		ps -ef | grep -w "xiaogpt.py" | grep -v grep  | gawk '{print $2}' | while read pid;do
			kill -9 $pid
		done
	else
		exit
	fi
fi


nohup python3 xiaogpt.py --config xiao_config.json >> data.log &
