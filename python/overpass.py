
import json
import urllib2


def get_buildings( min_la, min_ln, max_la, max_ln ):
	""" Calls the Overpass API asking for buildings within the given min and max lat and long. """
	
	latlon = ','.join( [ str(min_la), str(min_ln), str(max_la), str(max_ln) ] )

	url = ''.join( ['http://overpass-api.de/api/interpreter?data=[out:json];(way["building"](', 
		latlon, ');node(w);way["building:part"="yes"](', latlon, ');node(w);relation["building"](', latlon, 
		');way(r);node(w););out;'])
	request = urllib2.Request( url )
	
	try:
		response = urllib2.urlopen( request )
		resp_msg = response.read()
		return json.loads( resp_msg )
	
	except urllib2.HTTPError as e:
		raise
		return False


def collect_all_bldgs( min_la, min_ln, max_la, max_ln ):
	""" Gathers info about all buildings within the area described by the min and max. """
	data = get_buildings( min_la, min_ln, max_la, max_ln )
	with open('overpass_exp.json', 'w') as f:
		f.write( json.dumps( data ) )


if __name__=="__main__":
	collect_all_bldgs( 22.32, 114.24, 22.3275, 114.255 )
	