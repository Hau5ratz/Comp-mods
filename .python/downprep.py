import sys 

try:
    X = str(sys.argv[1])
    print X
    X=X[:X.index('list')]
    print X
except:
    pass
