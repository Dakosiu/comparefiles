#!/bin/bash

# script to run the automatic server again in case of crash
echo "Starting Evotronus"

cd /home/ubuntu/EvotronAutoUpdate/Server/
mkdir -p logs

# config mysql
usersql="user"
servername="Evotron"
sqlpassword="lucas2132"

date=`date "+%d-%m-%y-%H-%M-%S"`
filename="${servername}-${date}"
databasefile="${filename}.sql"

#necessary configurations for Anti-rollback
ulimit -c unlimited
set -o pipefail

while true        
do
     #the antirollback_config file must be in the tfs folder
    gdb --batch -return-child-result --command=antirollback_config --args ./tfsd 2>&1 | awk '{ print strftime("%F %T - "), $0; fflush(); }' | tee "logs/$(date +"%F %H-%M-%S.log")"
   
    if [ $? -eq 0 ]; then
        echo "Exit code 0, waiting 3 minutes..."
        sleep 180    #3 minutos
    else
        echo "Crash !! Restarting the server in 5 seconds (The log file is saved in the logs folder)"
        echo "If you want to shut down the server, press CTRL + C ..."
        sleep 5
    fi
done;