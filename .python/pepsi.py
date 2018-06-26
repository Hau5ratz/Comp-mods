import sys
if not sys.version_info[0] < 3:
    from __future__ import print_function
import pip
import os

class Pepsi():
    def __init__(self):
        self.reqp = []
        
    def initialize(self):
        if os.path.isfile('~/.pypackages.txt'):
            with open('~/.pypackages.tx', 'r') as file:
                self.reqp = file.read()
            self.reqp = self.reqp.split('\n')
            for x in self.reqp:
                self.install(x)
        else:
            print('File of packages not found')
            
    def install(self, package):
        pip.main(['install', package])

if __name__ == '__main__':
    Pepsi().initialize()
