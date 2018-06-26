import pymouse
import time

m = pymouse.Mouse()
x, y = m.getMouseLoc()
while True:
    m.stepMouseToPoint(x+200, y,100)
    time.sleep(2)
    m.stepMouseToPoint(x-200, y,100)
