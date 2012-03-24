import codecs
import os
import sys

try:
    import xml.etree.cElementTree as ET
    import re
except ImportError:
    import xml.etree.ElementTree as ET

def parse_xml_files_of(directory):
  directory_name = 'parser_result'
  if not os.path.exists(directory_name):
      os.makedirs(directory_name)
  for xmlfile in os.listdir(directory):
     create_filedata_for_stations(directory+'/'+xmlfile,directory_name)
     print 'File : '+xmlfile+" done..."


    
def create_filedata_for_stations(xml_filename, directory_name):
  # Get the number of tan line
  m = re.search('(?<=_TAN)\w+',xml_filename)
  linenumber = m.group(0)
  datafile = codecs.open(directory_name+'/data_'+linenumber+'.sql','w','utf-8')
  datafile.write('# line to insert in database for table \'tan_arrets\' has the following structure : line number - station name - longitude - latitude')
  datafile.write('\n\n')
  tree = ET.ElementTree(file=xml_filename)
  root = tree.getroot()
  ancient_station_name =''
  for elem in tree.iter(tag='StopPoint'):
    station_name = elem.findtext('name')
    station_longitude = elem.findtext('longitude')
    station_latitude = elem.findtext('latitude')
    if ancient_station_name != station_name:
      datafile.write('INSERT INTO `tan_stops`(`stop_number_of_line`, `stop_name_stop`, `stop_longitude`, `stop_latitude`) VALUES ('+linenumber+',"'+station_name+'",'+station_longitude+','+station_latitude+');\n')
    ancient_station_name = station_name
    
    
if __name__ == '__main__':
  if len(sys.argv) <2:
     print 'Usage : python tan_xml_file_parser directory containing xml files'
  elif len(sys.argv)==2:
    parse_xml_files_of(sys.argv[1])
      
  
  
  
