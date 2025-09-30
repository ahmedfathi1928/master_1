*** Settings ***

*** Variables ***

#########################  APPLICATION VARIABLE ####################
# Variable Name
#           BLE_ADVERTISING_NAME
# Note
#          The name of the device that will be used for the test
${BLE_ADVERTISING_NAME}            IMBR-2128023237

# Variable Name
#           SERIAL_ENABLED
# Options
#           1    ----> Enable Serial Communication with ${REF_DESIGN_HW_CONTROLLER_PORT}
#           0    ----> Disable any Serial Communication
${SERIAL_ENABLED}                   1

# Variable Name
#           REF_DESIGN_HW_CONTROLLER_PORT
# Options
#         Run on terminal `ls /dev/tty/*`  --> Linux Based (MAC, Linux)
${REF_DESIGN_HW_CONTROLLER_PORT}    /dev/tty.usbmodem1411401

# Variable Name
#           HW_PUFFING
# Note
#          To Enable Auto Puff From Hardware the ${SERIAL_ENABLED} should be enabled
# Options
#           1    ----> Enable Hardware Puffing
#           0    ----> Disable Hardware Puffing
${HW_PUFFING}                       1

# Variable Name
#           HW_REPAIRING
# Note
#          To Enable Auto Repairing From Hardware the ${SERIAL_ENABLED} should be enabled
# Options
#           0    ----> Disable Hardware Repairing, Execution Will be Paused for Manual Repair
#           1    ----> Enable Hardware Repairing When No BLE Advertisement (HW By Default Advertise)
#           2    ----> Enable Hardware Repairing When No BLE Advertisement (HW By Default Not Advertise)
${HW_REPAIRING}                       2

# Variable Name
#           HW_CONTROL_POWER_SUPPLY
# Note
#          To Enable Control on Power Supply From Hardware the ${SERIAL_ENABLED} should be enabled
# Options
#           1    ----> Enable  Control Turn on/off Power Supply From Controller
#           0    ----> Disable Control Turn on/off Power Supply From Controller
${HW_CONTROL_POWER_SUPPLY}            1

# Variable Name
#           SIM_CARD_INSERTED
# Options
#           1    ----> SIM Card is Inserted
#           0    ----> No SIM Card Available
${SIM_CARD_INSERTED}                   0

#########################  PROJECT VARIABLE ####################
# Variable Name
#           PLATFORM_NAME
# OPTIONS
#          IOS, Android
${PLATFORM_NAME}        Android

# Variable Name
#           AUTOMATION_NAME
# OPTIONS
#          For IOS     --> XCUITest
#          For Android --> UiAutomator2
${AUTOMATION_NAME}    UiAutomator2
# Variable Name
#           PLATFORM_VERSION
# OPTIONS
#          For IOS (e.g. ios 17.1)     --> 17.1
#          For Android (Android 12)    --> 12
${PLATFORM_VERSION}    14

# Variable Name
#           PHONE_UDID
# Note
#          The UUID of the phone
${PHONE_UDID}           46211FDAS00054