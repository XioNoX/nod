import os
import sys
import codecs
import glob

datafile = codecs.open("tan_stops.txt",'w','utf-8')
for item in glob.glob(os.path.join(os.getcwd(), '*.sql')):
  print item
  f = codecs.open(item,'r','utf-8')
  datafile.write(f.read())

print 'done'