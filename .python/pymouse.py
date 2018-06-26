import time, os
from objc import NULL
from Quartz.CoreGraphics import CGEventCreate, CGEventCreateMouseEvent, \
    CGEventGetLocation, CGEventPost, CGEventSetFlags, CGEventSetIntegerValueField,   \
    CGEventSourceCreate, CGPointMake, kCGEventFlagMaskAlternate,                     \
    kCGEventFlagMaskCommand, kCGEventFlagMaskControl, kCGEventFlagMaskShift,         \
    kCGEventLeftMouseDown, kCGEventLeftMouseUp, kCGEventMouseMoved,                  \
    kCGEventRightMouseDown, kCGEventRightMouseUp, kCGEventSourceStateHIDSystemState, \
    kCGHIDEventTap, kCGMouseEventClickState
from AppKit import NSEvent, NSScreen, NSPointInRect

PYMAC_SOURCE_REF = CGEventSourceCreate(kCGEventSourceStateHIDSystemState)

class Mouse():
    '''
    Mouse control class
    '''
    def __init__(self):
        pass

    def getMouseLoc(self):
        mouseEvent = CGEventCreate(NULL)
        mouseLoc = CGEventGetLocation(mouseEvent)
        return mouseLoc

    def mouseEvent(self, eventVal, mouseLocation = False):
        if (mouseLocation == False): mouseLocation = self.getMouseLoc()
        return CGEventCreateMouseEvent(PYMAC_SOURCE_REF, eventVal, mouseLocation, 0)

    def doEvent(self, eventObj):
        CGEventPost(kCGHIDEventTap, eventObj)

    # mouse clicks

    def performLeftClick(self, modKeys = 0):
        mLoc = self.getMouseLoc()
        clickMouse = mouseEvent(kCGEventLeftMouseDown, mLoc)
        if (modKeys != 0): CGEventSetFlags(clickMouse, modKeys)
        self.doEvent(clickMouse)
        self.doEvent(mouseEvent(kCGEventLeftMouseUp, mLoc))

    def performRightClick(self):
        mLoc = self.getMouseLoc()
        self.doEvent(mouseEvent(kCGEventRightMouseDown, mLoc))
        self.doEvent(mouseEvent(kCGEventRightMouseUp, mLoc))

    def performDoubleLeftClick(self):
        mLoc = self.getMouseLoc()
        # left click once to bring to foreground
        clickMouse = mouseEvent(kCGEventLeftMouseDown, mLoc)
        CGEventSetIntegerValueField(clickMouse, kCGMouseEventClickState, 1)
        self.doEvent(clickMouse)
        releaseMouse = mouseEvent(kCGEventLeftMouseUp, mLoc)
        CGEventSetIntegerValueField(releaseMouse, kCGMouseEventClickState, 1)
        self.doEvent(releaseMouse)
        # perform actual double click
        clickMouse2 = mouseEvent(kCGEventLeftMouseDown, mLoc)
        CGEventSetIntegerValueField(clickMouse2, kCGMouseEventClickState, 2)
        self.doEvent(clickMouse2)
        releaseMouse2 = mouseEvent(kCGEventLeftMouseUp, mLoc)
        CGEventSetIntegerValueField(releaseMouse2, kCGMouseEventClickState, 1)
        self.doEvent(releaseMouse2)

    def getModKeysValue(self, doShiftDown = False, doCommandDown = False, doOptionDown = False, doControlDown = False):
        modKeys = 0
        if (doShiftDown):   modKeys |= kCGEventFlagMaskShift
        if (doCommandDown): modKeys |= kCGEventFlagMaskCommand
        if (doOptionDown):  modKeys |= kCGEventFlagMaskAlternate
        if (doControlDown): modKeys |= kCGEventFlagMaskControl
        return modKeys

    def allModifiersUp(self):
        try: os.system('/usr/bin/osascript -e "tell application \\"System Events\\" to key up {shift, command, option, control}"')
        finally: return

    # move mouse

    def moveMouseToPoint(self, x, y):
        xFloat,yFloat = (0. + x), (0. + y)
        self.doEvent(self.mouseEvent(kCGEventMouseMoved, mouseLocation=CGPointMake(xFloat, yFloat)))

    def stepMouseToPoint(self, x, y, numSteps=1):
        currentLoc = self.getMouseLoc()
        xFloat,yFloat = (0. + x), (0. + y)
        if (numSteps < 1): numSteps = 1
        xIncrement = (xFloat - currentLoc.x) / numSteps
        yIncrement = (yFloat - currentLoc.y) / numSteps
        xPrevious,yPrevious = (0. + currentLoc.x), (0. + currentLoc.y)
        for i in range(numSteps):
            xNew,yNew = (xPrevious + xIncrement), (yPrevious + yIncrement)
            self.moveMouseToPoint(xNew,yNew)
            xPrevious,yPrevious = xNew,yNew
            time.sleep(0.0008)
        self.moveMouseToPoint(x,y)

    def mouseLocation(self, isTopCoordinates = True):
        if (isTopCoordinates):
            mLoc = self.getMouseLoc()
            return (mLoc.x,mLoc.y)
        else:
            mLoc = NSEvent.mouseLocation()
            return (mLoc.x,mLoc.y)

    # helpers

    def isPointOnAScreen(self, point):
        screens = NSScreen.screens()
        count = screens.count()
        for i in range(count):
            if (NSPointInRect(point, screens[i].frame())): return screens[i]
        return None
