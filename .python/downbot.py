import requests
from bs4 import BeautifulSoup
import sys
import os
import shutil


class Downloader():
    '''
    Downloader utility class
    if passed a url name pair it will download it
    if passed a list of url name pair will download all of them
    '''

    def __init__(self, *args):
        self.rurl = r'''^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$'''
        self.rsuf = r'''^.*\.\w+$'''
        self.test_pass(args)

    def test_pass(self, obj):
        if isinstance(obj, tuple):
            self.download_file(*obj)
        elif isinstance(obj, list):
            for x in obj:
                self.download_file(*x)
        else:
            assert False, 'Incorrect arguement formate'

    def test(self, obj):
        '''
        Tests object to make sure it conforms to standard
        '''
        d = ''
        if len(obj) == 3:
            d = os.listdir()
            if not obj[2] in d:
                print 'directory does not exist, making now..'
                os.mkdir(obj[2])
                print 'directory made'
                d = obj[2]
            else:
                d = obj[2]
        assert all([isinstance(x, str)
                    for x in args]), 'all arguements must be string'
        assert re.match(
            self.rurl, args[0]), '1st arguement must be valid URL'
        assert re.match(
            self.rsuf, args[1]), '2nd arguement must be a valid filename'

    def download_file(self, url, x, d=''):
        '''
        Takes a file URL and name as arguement and downloads and writes it
        '''
        self.test(url, x, d)
        local_filename = str(x)
        # NOTE the stream=True parameter
        r = requests.get(url, stream=True)
        with open('/' + d + '/' + local_filename, 'wb') as f:
            for chunk in r.iter_content(chunk_size=1024):
                if chunk:  # filter out keep-alive new chunks
                    f.write(chunk)
        return local_filename

if __name__ == '__main__':
    Downloader(sys.argv[1:])
