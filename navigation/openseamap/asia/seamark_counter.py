from imposm.parser import OSMParser

# simple class that handles the parsed OSM data.
class SeamarkCounter(object):
    seamarks = 0

    def ways(self, ways):
        # callback method for ways
        for osmid, tags, refs in ways:
            if 'seamark:type' in tags:
             	self.seamarks += 1

# instantiate counter and parser and start parsing
counter = SeamarkCounter()
p = OSMParser(concurrency=4, ways_callback=counter.ways)
p.parse('vietnam.osm.pbf')

# done
print counter.seamarks