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
      datafile.write('INSERT INTO `gps`(`longitude`, `latitude`, `address`, `zip`, `city`) VALUES ('+aline[4]+','+aline[3]+',"'+aline[2]+'",44000,"Nantes");\n')
      datafile.write('INSERT INTO `points_of_interest`(`label`, `description`,`gps_id`, `type`, `type_id_in_table`) VALUES ("'+aline[1]+'","'+(aline[17].rstrip()).replace('"',"'")+'",'+str(i-1)+',"parks",'+str(i-1)+');\n')
      datafile.write('INSERT INTO `parks`(`games`) VALUES (0);\n')
    i+=1
  print "done"
  

def parse_file_equipement_culture_csv(filename,delimiter='\n', separator=';'):
  print "Creation of SQL file for insertion for file : "+filename+"..."
  f = codecs.open(filename,'r','iso-8859-1')
  lines = f.readlines()
  datafile = codecs.open('data_from_'+filename.split('.')[0]+'.sql','w','utf-8')
  datafile.write('# line to insert in database for table \'gps\' has the following structure : gps_id(AI) - gps_longitude - gps latitude - gps_address - gps_zip (44000) - gps_city(Nantes)')
  datafile.write('\n\n')
  i=1
  id_contact = 1
  for line in lines:
    if i!=1:
      aline = line.split(';')
      datafile.write('INSERT INTO `culture_places`(`indoor`) VALUES (1);\n')
      datafile.write('INSERT INTO `gps`(`longitude`, `latitude`, `address`, `zip`, `city`) VALUES ('+aline[14].replace(',','.')+','+aline[15].replace(',','.').rstrip()+',"'+aline[10]+'",'+aline[13]+',"'+aline[9]+'");\n')
      
      if len(aline[11]) > 0 and len(aline[12]) > 0:
	datafile.write('INSERT INTO `points_of_interest`(`label`, `description`,`gps_id`, `type`, `type_id_in_table`, `contact_id`) VALUES ("'+aline[1]+'","'+aline[7]+'",'+str(90+i-1)+',"culture_places",'+str(i-1)+','+str(id_contact)+');\n')
	datafile.write('INSERT INTO `contacts`(`phone`,`website`) VALUES ('+aline[11].replace(" ","")+',"'+aline[12]+'");\n')
	id_contact+=1
      elif len(aline[11]) > 0 and len(aline[12]) == 0:
	datafile.write('INSERT INTO `points_of_interest`(`label`, `description`,`gps_id`, `type`, `type_id_in_table`, `contact_id`) VALUES ("'+aline[1]+'","'+aline[7]+'",'+str(90+i-1)+',"culture_places",'+str(i-1)+','+str(id_contact)+');\n')
	datafile.write('INSERT INTO `contacts`(`phone`) VALUES ('+aline[11].replace(" ","")+');\n')
	id_contact+=1
      elif len(aline[12]) > 0 and len(aline[11]) == 0:
	datafile.write('INSERT INTO `points_of_interest`(`label`, `description`,`gps_id`, `type`, `type_id_in_table`, `contact_id`) VALUES ("'+aline[1]+'","'+aline[7]+'",'+str(90+i-1)+',"culture_places",'+str(i-1)+','+str(id_contact)+');\n')
	datafile.write('INSERT INTO `contacts`(`website`) VALUES ("'+aline[12]+'");\n')
	id_contact+=1
      else:
	# We have to insert the gps positions from parcs.csv before (if we want to manage easily the gps_id for the poi)
	datafile.write('INSERT INTO `points_of_interest`(`label`, `description`,`gps_id`, `type`, `type_id_in_table`) VALUES ("'+aline[1]+'","'+aline[7]+'",'+str(90+i-1)+',"culture_places",'+str(i-1)+');\n')
    i+=1
  print "done"



if __name__ == '__main__':
  if len(sys.argv) <2:
     print 'Usage : python insertion_script_creator.py csv_file'
  elif len(sys.argv)==2:
    print '------------------------------------------------------'
    print 'BRACE YOURSELVES, CHOICES ARE COMING...'
    print '------------------------------------------------------'
    print '(1) - Generate sql insertion file from jardin_parc.csv'
    print '(2) - Generate sql insertion file from equipement_publics_culture.csv'
    choice = raw_input("Choose the function you want to use? (indicate the number corresponding to the function to execute)\n")
    if choice == '1':
      parse_file_csv(sys.argv[1])
    elif choice=='2':
      parse_file_equipement_culture_csv(sys.argv[1])
