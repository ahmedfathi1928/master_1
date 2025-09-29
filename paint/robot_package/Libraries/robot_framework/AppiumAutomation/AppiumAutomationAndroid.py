import os
from robot.api.deco import keyword
from time import sleep
import win32con
import win32gui


@keyword
def start_appium_server():
    os.system('start appium -p 4723 --session-override --base-path /wd/hub')
    sleep(2)
    win32gui.ShowWindow(win32gui.GetForegroundWindow(), win32con.SW_MINIMIZE)
    sleep(8)


@keyword
def close_appium_server():
    os.system("taskkill /F /IM node.exe")
    os.system('start adb uninstall io.appium.uiautomator2.server')
    os.system('start adb uninstall io.appium.uiautomator2.server.test')
