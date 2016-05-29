#!/bin/bash
EMAIL=your.email@address.here
HOSTNAME=$(hostname -f)
timestamp() {
	date +"%T"
}

function getip
{
curl icanhazip.com --connect-timeout 5 > newip.txt || exit 1
}

touch oldip.txt && touch newip.txt
getip
NEWIP=$(<newip.txt)
OLDIP=$(<oldip.txt)
if diff oldip.txt newip.txt >/dev/null; then
 echo Same
else
 echo Different
 echo -e "$HOSTNAME IP Address changed at $(timestamp)\nOld IP: $OLDIP\n New IP: $NEWIP" | mail -s "New IP: $NEWIP" $EMAIL && cat newip.txt > oldip.txt || exit 1
fi

unset -v OLDIP NEWIP
