#!/bin/bash

if [ -e ./list.html ]; then
	CHART_LIST="`cat ./topo50list.html`"
else
	CHART_LIST="`curl http://www.namria.gov.ph/topo50Index.aspx`"
	echo "$CHART_LIST" > topo50list.html
fi

echo "$CHART_LIST"  | grep '<area.*\/>' | sed 's/.*href="\([^"]*\)".*/\1/g'
