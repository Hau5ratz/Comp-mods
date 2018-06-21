
ss() {
  filename=$1'.sh'
  echo '#!/bin/bash' > $filename 
  subl $filename
  }
pys() {
  filename=$1'.py'
  printf '#!/usr/bin/python3.6\n__author__ = "Nicholas Rademaker"\n__copyright__ = "Me I will fight you"\n__credits__ = ["Nicholas Rademaker"]\n__license__ = "None"\n__version__ = "0"\n__maintainer__ = "Nicholas Rademaker"\n__email__ = "nrademaker@gm.slc.edu"\n__status__ = "Developing"' > $filename 
  subl $filename
  }
fpath() {
  path=$@
  echo
  echo "Your formated path is the following:"
  echo "${path// /\\ }"  
  }
