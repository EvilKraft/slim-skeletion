#!/bin/sh

PROCESSORS=1;
x=0

while [ "$x" -lt "$PROCESSORS" ];
do
        PROCESS_COUNT=`pgrep -f ./mailerWorker.php | wc -l`
        if [ $PROCESS_COUNT -ge $PROCESSORS ]; then
                exit 0
        fi
        x=`expr $x + 1`
        php -f ./mailerWorker.php &
done
exit 0