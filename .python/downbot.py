import requests
from bs4 import BeautifulSoup
import sys
import os
import shutil

def download_file(url, x):
    local_filename = str(x) + raw_input('Suffix?: ')
    # NOTE the stream=True parameter
    r = requests.get(url, stream=True)
    with open(local_filename, 'wb') as f:
        for chunk in r.iter_content(chunk_size=1024): 
            if chunk: # filter out keep-alive new chunks
                f.write(chunk)
    return local_filename

Base = 'https://www.watchcartoononline.io/'

url = sys.argv[1] if len(sys.argv) >= 2 else Sample


r = requests.get(url)
soup = BeautifulSoup(r.content, 'html.parser')
Imgs = soup.find_all('img')
idy = [x['src'] for x in Imgs if 'jpg' in x['src'] and not 'thumb' in x['src']][-1].split('/')[-2]

Pagenum = int(input('how many page numbers?: '))

D = str(raw_input('Foldername?: '))
os.makedirs(D)
os.chdir(D)
for x in range(1, Pagenum+1):
    F = Base%(idy, x)
    download_file(F, x)
    print 'Downloaded %s out of %s'%(x, Pagenum)
os.chdir('..')
shutil.move(D,'../Pictures')
  
 

