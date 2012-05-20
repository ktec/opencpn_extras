#!/bin/bash

if [ -e ./list.html ]; then
	STATIONS="`cat ./list.html`"
else
	STATIONS="`curl http://www.ioc-sealevelmonitoring.org/service.php?server=gml&show=active&showgauges=t`"
	echo "$STATIONS" > list.gml
fi




#sed "s/IP/$IP/" nsupdate.txt | nsupdate
echo "$STATIONS"  #| grep '<tr.*station.php.*\/tr>'
