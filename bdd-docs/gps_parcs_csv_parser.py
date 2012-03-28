# -*- encoding: utf-8 -*-
import os
import sys
import codecs

#------------------------------------------------------------------------------------#
#Methods should be more generic to make the user able to insert gps information for any csv file
#TODO : By giving the position on the line of the interesting values (longitude, latitude, city, zip) as
#parameters of the parse_file_csv method, we could adapt this method to any csv file 
#-------------------------------------------------------------------------------------#


def parse_file_csv(filename,delimiter='\n', separator=';'):
  print "Creation of SQL file for insertion for file : "+filename+"..."
  f = codecs.open(filename,'r','iso-8859-1')
  lines = f.readlines()
  datafile = codecs.open('gps_positions_from_'+filename.split('.')[0]+'.sql','w','utf-8')
  datafile.write('# line to insert in database for table \'gps\' has the following structure : gps_id(AI) - gps_longitude - gps latitude - gps_address - gps_zip (44000) - gps_city(Nantes)')
  datafile.write('\n\n')
  i=1
  for line in lines:
    if i!=1:
      aline = line.split(';')
      datafile.write('INSERT INTO `gps`(`gps_longitude`, `gps_latitude`, `gps_address`, `gps_zip`, `gps_city`) VALUES ('+aline[3]+','+aline[4]+',"'+aline[2]+'",44000,"Nantes");\n')
      datafile.write('INSERT INTO `point_of_interest`(`poi_label`, `poi_description`,`poi_gps_id`, `poi_type`, `poi_type_id_in_table`) VALUES ("'+aline[1]+'","'+(aline[17].rstrip()).replace('"',"'")+'",'+str(i-1)+',"parks",'+str(i-1)+');\n')
      datafile.write('INSERT INTO `parks`(`park_games`) VALUES (0);\n')
    i+=1
  print "done"



if __name__ == '__main__':
  if len(sys.argv) <2:
     print 'Usage : python gps_parcs_csv_parser.py csv_file'
  elif len(sys.argv)==2:
    # Works only with 'jardin_parc.csv 
    parse_file_csv(sys.argv[1])
  