curl http://www.ndbc.noaa.gov/kml/marineobs_as_kml.php?sort=pgm -o "./stations_by_program.kml"
gpsbabel -w -r -t -i kml,lines,points,trackdata,labels -f ./stations_by_program.kml -o gpx -F ./stations_by_program.gpx
mv ./stations_by_program.gpx ../layers/ndbc.gpx
