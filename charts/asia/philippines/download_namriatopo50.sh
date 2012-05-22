#!/bin/bash

rm *.jpg

LISTNAME='topo50list.html'

if [ -e ./${LISTNAME} ]; then
	CHART_LIST="`cat ./${LISTNAME}`"
else
	CHART_LIST="`curl http://www.namria.gov.ph/topo50Index.aspx`"
	echo "$CHART_LIST" > ${LISTNAME}
fi

LIST=$(echo "$CHART_LIST"  | grep '<area.*\/>' | sed 's/.*href="\([^"]*\)".*/http:\/\/www.namria.gov.ph\/Downloads\/topoMap50\/\1/g' | sed 's/ //g' | sed 's/<br>//g' | sed 's/>//g' | sed 's/\.html/\.jpg/g')

curl --remote-name-all -K $LIST

