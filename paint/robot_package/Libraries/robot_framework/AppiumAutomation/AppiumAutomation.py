import os
import time
from robot.api.deco import keyword
from AppKit import NSApplication, NSApp, NSWorkspace
from Quartz import kCGWindowListOptionOnScreenOnly, kCGNullWindowID, CGWindowListCopyWindowInfo
from applescript import tell


#set what command you want to run here
#start appium ios
startAppiumCommand = 'appium -p 4723'


@keyword
def start_appium_server():
    workspace = NSWorkspace.sharedWorkspace()
    activeApps = workspace.runningApplications()
    tell.app('Terminal', 'do script "' + startAppiumCommand + '"')
    time.sleep(2)
    for app in activeApps:
        if app.isActive():
            options = kCGWindowListOptionOnScreenOnly
            windowList = CGWindowListCopyWindowInfo(options,
                                                    kCGNullWindowID)
            for window in windowList:
                if window['kCGWindowOwnerName'] == app.localizedName():
                    print(window.getKeys_)
                    # app.hide()
                    break
            break
    time.sleep(8)


@keyword
def close_appium_server():
    # os.system("killall Terminal")
    os.system("osascript -e 'tell application \"Terminal\" to quit'")
