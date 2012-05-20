mkdir images
cd images
for a in $(cat ../stations_by_program.kml |grep images| sort| uniq | sed 's/.*<href>\([^<]*\)<\/href>/\1/g'); do 
curl -O $a
done

