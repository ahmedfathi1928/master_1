*** Settings ***
Resource    ../../../../../common/keywords/common_keywords.robot
Resource    ../component_source/ui_locators.robot
Resource    ../component_source/app_data.robot
Resource    ../../../../../common/keywords/mobile/phone_models/android/note_20_ultra/note_20_ultra_keywords.robot
Resource    ../../../../../protocols/arduino_controller_parser_composer/arduino_controller_parser_composer.robot
Resource    ../test_data/keyword_data.robot
Library     ../../../../../Libraries/robot_framework/AppiumAutomation/AppiumAutomationAndroid.py
Library     RequestsLibrary

*** Variables ***
${WEB_BLE_URL}                              https://thirdwayv.github.io/Cloud-VitaProtect-WebBLE-ClientApp/

${REF_DESIGN_BASE_DIR}                       ${CURDIR}/../..
${SHARED_FILE}                               ${REF_DESIGN_BASE_DIR}/resources/keywords/shared_file_for_flags.txt
${MOBILE_LOG_FILE_PATH}                      ${REF_DESIGN_BASE_DIR}/resources/keywords/mobile_logs
${MOBILE_LOG_FILE_PATH1}                     ${REF_DESIGN_BASE_DIR}/tests/smoke_test/test_reports
${RUN_START_TIMESTAMP}                       ${REF_DESIGN_BASE_DIR}/resources/test_data/timestamp.txt
${suite_setup_passed}                        0
${DIVIDER_LINE}                              ----------------------------------------------------------------------------------------------------------
${MODE_TYPE_LOCATOR}                         com.thirdwayv.vitaprotect:id/tv_mode_type
${NETWORK_PREV_STATUS}                       False

################ FILE NAMES ######################
${PUFF_TIMESTAMP_FILE_NAME}                 signal_logs/puff_signals_timestamp.txt
${NETWORK_STATUS_FILE_NAME}                 signal_logs/network_status.txt
${DISCONNECTION_COUNT_FILE_PATH}            disconnection_count.txt


*** Keywords ***

TWI Keyword IMBR Open App Without Reset
    [Arguments]         ${retry_limit}=3
    TWI Keyword Try To Run A Keyword    keyword=TWI Keyword IMBR Open App Without Reset Without Retry     number_of_tries=${retry_limit}
    TWI Keyword Activate Application    app_package=${APP_PACKAGE}

TWI Keyword IMBR Open App Without Reset Without Retry
    [Arguments]     ${no_reset}=true        ${timeout}=20
    TWI Keyword Open Application    automator_name=${AUTOMATION_NAME}
                             ...    app_path=${APP}
                             ...    platform=${PLATFORM_NAME}
                             ...    app_package=${APP_PACKAGE}
                             ...    device_name=${PHONE_UDID}
                             ...    timeout=9999
                             ...    connection_type=usb
                             ...    auto_permissions=true
                             ...    no_reset=${no_reset}
                             ...    auto_launch=false
                             ...    platformVersion=${PLATFORM_VERSION}
                             ...    allow_os_alerts=true

TWI Keyword IMBR Skip Instabug
    TWI Keyword Appium Wait Until Page Contain Element    locator=${INSTABUG_INIT_SCREEN_ID}    timeout=200
    TWI Keyword Appium Swipe On Element     element_identifier=${INSTABUG_INIT_SCREEN_ID}       swipe_direction=left    margin=20
    TWI Keyword Appium Wait Until Page Contain Element    locator=${INSTABUG_SECOND_SCREEN_ID}    timeout=20s
    TWI Keyword Appium Swipe On Element     element_identifier=${INSTABUG_SECOND_SCREEN_ID}       swipe_direction=left  margin=20
    TWI Keyword Appium Wait For Element And Click    locator=${INSTABUG_DONE_BTN_ID}    timeout=20s

TWI Keyword IMBR App Without Reset
    Run Keyword And Ignore Error    TWI Keyword Terminate Application    app_package=${APP_PACKAGE}
    TWI Keyword IMBR Open App Without Reset

TWI Keyword IMBR Close IMBR App
    Run Keyword And Ignore Error       TWI Keyword Terminate Application    app_package=${APP_PACKAGE}

TWI Keyword IMPR Activate App
    TWI Keyword Sleep    1
    TWI Keyword Activate Application    app_package=${APP_PACKAGE}

TWI Keyword IMBR Enter Confirm Password
    [Arguments]     ${password}        ${timeout}=20
    TWI Keyword Enter Password         password=${password}      locator=${SIGN_UP_CONFIRM_PASSWORD_FIELD}

TWI Keyword IMBR Fill Signup Form
    [Arguments]     ${username}        ${password}      ${timeout}=20
    TWI Keyword Log To Console       message=User name 2 is : ${username}.
    TWI Keyword IMBR Enter Email                    email=${username}          timeout=${timeout}
    TWI Keyword IMBR Enter Password                 password=${password}       timeout=${timeout}
    TWI Keyword IMBR Enter Confirm Password         password=${password}       timeout=${timeout}
    TWI Keyword Appium Wait For Element And Click   locator=${SIGN_UP_BUTTON}               timeout=${timeout}
    #    TWI Keyword IMBR Wait Until Loading Spinner Is Invisible            locator=${APP_LOADING_TEXT}
    TWI Keyword Sleep    3s

TWI Keyword IMBR Wait For Sign up Continue Button And Click It
    TWI Keyword Appium Wait For Element And Click         locator=${SIGN_UP_CONTINUE_BUTTON}    timeout=10

TWI Keyword IMBR Wait For Privacy Page And Click I Understand
    TWI Keyword Appium Wait For Element And Click         locator=${I_UNDERSTAND_BUTTON}    timeout=10

TWI Keyword IMBR Wait For Take a Selfie Page And Click Continue
    TWI Keyword Appium Wait For Element And Click         locator=${CONTINUE_BUTTON}    timeout=10
TWI Keyword IMBR Lock Phone
    [Arguments]    ${time}=2
    TWI Keyword Lock Phone         time=${time}

TWI Keyword IMBR Wait For Camera Page
    TWI Keyword Appium Wait Until Page Contain Element      locator=${SELFIE_PAGE}    timeout=100

TWI Keyword IMBR Convert Digit To Keycode
    [Arguments]    ${digit}
    ${map}=    Create Dictionary    0=7    1=8    2=9    3=10    4=11    5=12    6=13    7=14    8=15    9=16
    ${kc}=    Get From Dictionary    ${map}    ${digit}
    [Return]    ${kc}

TWI Keyword IMBR Entering Password
    [Arguments]    @{PIN}
    FOR    ${kc}    IN    @{PIN}
        Press Keycode    ${kc}
    END
    TWI Keyword Sleep    1

TWI Keyword IMPR Wait For Connect Button And Click It
    TWI Keyword Appium Wait For Element And Click        locator=${CONNECT_BUTTON}    locator_type=id    timeout=100
    TWI Keyword Appium Wait For Element And Click    locator=${CONNECT_MY_DEVICE}    locator_type=id   timeout=30

TWI Keyword IMP Wait For Pair Button And Click It
    TWI Keyword Appium Wait For Element And Click    locator=${PAIR_BUTTON}    locator_type=id   timeout=30

TWI Keyword IMP Wait For Return To HomePage And Click It
    TWI Keyword Appium Wait For Element And Click    locator=${HOME_PAGE}    locator_type=id   timeout=180

TWI Keyword IMP Wait For Go To HomePage And Click It
    TWI Keyword Appium Wait For Element And Click    locator=${GO_TO_HOME_PAGE}    locator_type=id   timeout=180

Verify That Nudge Button Is Visible
    TWI Keyword Sleep    1
    TWI Keyword Appium Wait Until Page Contain Element      locator=${NUDGE_BUTTON}     locator_type=id    timeout=100

TWI Keyword IMPR Checking Couldn't connect
    TWI Keyword Sleep    1
    TWI Keyword Appium Page Should Contain Text     text=We couldn’t connect.   platform_name=Android

TWI Keyword IMBR Connect With HW Device
    [Arguments]     ${check_connection}=1
    TWI Keyword Sleep    1
    TWI Keyword IMPR Activate App
    TWI Keyword IMPR Wait For Connect Button And Click It
    TWI Keyword IMP Wait For Pair Button And Click It
    TWI Keyword IMP Wait For Return To HomePage And Click It

TWI Keyword IMBR Wait Until Loading Spinner Is Invisible
    [Arguments]         ${locator}      ${timeout}=180
    TWI Keyword Sleep    1s
    Run Keyword And Ignore Error        TWI Keyword Appium Wait Until Page Contain Element        locator=${locator}    locator_type=id    timeout=5
    FOR    ${index}    IN RANGE    ${timeout}
        ${exec_status}=      Run Keyword And Return Status    TWI Keyword Get Element Attribute     id=${locator}      visible
        BuiltIn.Run Keyword If    ${exec_status} == 0    Exit For Loop
        TWI Keyword Sleep    1s
    END
    BuiltIn.Run Keyword If    ${exec_status} == 1    Fail    Spinner is still visible after ${timeout} seconds

TWI Keyword IMPR Wait Device Not Found
    TWI Keyword Sleep    11
#    TWI Keyword IMBR Wait Until Loading Spinner Is Invisible    locator=com.thirdwayv.vitaprotect:id/iv_device_cropped
    TWI Keyword Appium Page Should Contain Text     text=Device not found   platform_name=Android

TWI Keyword IMBR Nudge
    TWI Keyword Log To Console       message=Start Nudging.
    TWI Keyword Appium Wait For Element And Click        locator=${NUDGE_BUTTON}    locator_type=id    timeout=100

TWI Keyword IMBR Verify Device is Nudging
    TWI Keyword Sleep    1
    TWI Keyword Appium Wait Until Page Contain Element       locator=${NUDGE_STATE}    timeout=100
    ${is_nudging}    TWI Keyword Appium Get Text    locator=${NUDGE_STATE}    locator_type=id
    Run Keyword If    '${is_nudging}' != 'Stop'    Fail    Nudging check failed: expected "Stop" but got "${is_nudging}"

TWI Keyword IMBR Verify Device Stopped Nudging
    TWI Keyword Sleep    15
    TWI Keyword Appium Wait Until Page Contain Element       locator=${NUDGE_STATE}    timeout=100
    ${is_stop_nudging}    TWI Keyword Appium Get Text    locator=${NUDGE_STATE}    locator_type=id
    Run Keyword If    '${is_stop_nudging}' != '${NUDGE_LABEL}'    Fail    Nudging check failed: Device Still Nudging.

TWI Keyword IMBR Unpair
    TWI Keyword Log To Console       message=Start Unpairing Process.
    TWI Keyword Appium Wait For Element And Click        locator=${UNPAIR_BUTTON}    locator_type=id    timeout=100
    TWI Keyword Appium Wait For Element And Click        locator=${UNPAIR_CONFIRMATION_BUTTON}    locator_type=id    timeout=100

TWI Keyword IMBR Verify Unpairing
    TWI Keyword Sleep    1
    TWI Keyword Log To Console       message=Checking Successfully Unpaired.
    TWI Keyword Appium Wait Until Page Contain Element        locator=${CONNECT_BUTTON}    timeout=100

TWI Keyword IMBR Retry Start Appium Server
    [Arguments]    ${number_of_tries}=3
    TWI Keyword Try To Run A Keyword    keyword=TWI Keyword IMBR Start Appium Server    number_of_tries=${number_of_tries}

TWI Keyword IMBR Test Setup
    TWI Keyword IMBR Open App Without Reset Without Retry       no_reset=false
    TWI Keyword IMPR Activate App
    TWI Keyword IMBR Verify App At Checking Legal Age Screen

TWI Keyword IMBR Test Teardown
    [Arguments]    ${test_passed}
    Run Keyword If Test Failed    TWI Keyword Vita Protect Handle Pairing Error After Test Fails    ${test_passed}
    TWI Keyword Sleep          time=3

TWI Keyword IMBR Verify That Device Is Connected
    [Arguments]    ${timeout}=100
    TWI Keyword Log To Console       message=Checking Connection.
    TWI Keyword Sleep    6
    ${ble_is_on}    TWI Keyword Get Element Attribute    id=${BLE_STATE}    bounds
    TWI Keyword Log To Console       message=${ble_is_on}
    Run Keyword If    '${ble_is_on}' not in ['${BLE_ON_STATE}' , '${BLE_ON_STATE2}']    Fail    Device not connected.

TWI Keyword IMBR Verify That Device Is Disconnected
    [Arguments]    ${timeout}=100
    TWI Keyword Log To Console       message=Checking Connection.
    TWI Keyword Sleep    3
    ${ble_is_off}    TWI Keyword Get Element Attribute    id=${BLE_STATE}    bounds
    TWI Keyword Log To Console       message=${ble_is_off}
    Run Keyword If    '${ble_is_off}' not in ['${BLE_OFF_STATE}' , '${BLE_OFF_STATE2}']    Fail    Device Still connected.

TWI Keyword IMBR Click Lock Button
    [Arguments]    ${timeout}=100
    TWI Keyword Sleep    1
    TWI Keyword Appium Wait For Element And Click        locator=${LOCK_BUTTON}    locator_type=id    timeout=${timeout}

TWI Keyword IMBR Verify That Device Is Locked
    TWI Keyword Log To Console       message=Verify lock state.
    TWI Keyword Sleep    3
    ${locked_text}    TWI Keyword Appium Get Text    locator=${LOCK_STATE}    locator_type=id
    TWI Keyword Log To Console       message=${locked_text}.
    Run Keyword If    '${locked_text}' != '${LOCK_LABEL}'    Fail    Device is UnLocked.

TWI Keyword IMBR Verify That Device Is UnLocked
    TWI Keyword Log To Console       message=Verify Unlock state.
    TWI Keyword Sleep    3
    ${Unlocked_text}    TWI Keyword Appium Get Text    locator=${UNLOCK_STATE}    locator_type=id
    TWI Keyword Log To Console       message=${Unlocked_text}
    Run Keyword If    '${Unlocked_text}' != '${UNLOCK_LABEL}'    Fail    Device is Locked.

TWI Keyword IMBR Click Unlock Button
    TWI Keyword Sleep    1
    TWI Keyword Appium Wait For Element And Click        locator=${LOCK_BUTTON}    locator_type=id    timeout=100

TWI Keyword IMBR Click Logout Button
    TWI Keyword Appium Wait For Element And Click        locator=${PROFILE_BUTTON}    locator_type=xpath    timeout=100
    TWI Keyword Appium Wait For Element And Click        locator=${LOGOUT_BUTTON}     timeout=100
    TWI Keyword Appium Wait For Element And Click        locator=${LOGOUT_CONFIRMATION_BUTTON}     timeout=100

TWI Keyword IMBR Verify App At Checking Legal Age Screen
     TWI Keyword IMBR Skip Instabug
     TWI Keyword Appium Wait For Element And Click         locator=${LEGAL_AGE_BUTTON}    timeout=100

TWI Keyword IMBR Enter Email
    [Arguments]     ${email}        ${timeout}=20
    TWI Keyword Enter Email         email=${email}      locator=${SIGN_IN_EMAIL_FIELD}

TWI Keyword IMBR Enter Password
    [Arguments]     ${password}        ${timeout}=20
    TWI Keyword Enter Password         password=${password}      locator=${SIGN_IN_PASSWORD_FIELD}

TWI Keyword IMBR Fill Login Form
    [Arguments]     ${email}        ${password}        ${timeout}=20
    TWI Keyword IMBR Enter Email        email=${email}             timeout=${timeout}
    TWI Keyword IMBR Enter Password     password=${password}       timeout=${timeout}
    TWI Keyword Appium Wait For Element And Click        locator=${LOGIN_IN_LABEL}      locator_type=id    timeout=${timeout}

TWI Keyword IMBR Verify app Logedin
    TWI Keyword Appium Wait Until Page Contain Element       locator=${AGE_VERIFICATION}      timeout=300
    ${AGE_VERIFICATION_TEXT}    TWI Keyword Appium Get Text             locator=${AGE_VERIFICATION}    locator_type=id
    Run Keyword If    '${AGE_VERIFICATION_TEXT}' != '${AGE_VERIFICATION_LABEL}'    Fail    Failed to login.

TWI Keyword IMBR Login Steps
    TWI Keyword Appium Wait For Element And Click        locator=${CONTINUE_BUTTON}     timeout=10
    TWI Keyword Appium Wait Until Page Contain Element       locator=${ENABLE_CAMERA_BUTTON}  timeout=10

TWI Keyword IMBR Signup Steps
    [Arguments]             ${register_username}
    Tap With Positions    100    ${770, 2175}
    ${random_number}    TWI Keyword Generate Random Numbers         digit_count=8
    ${register_username}=       BuiltIn.Catenate        SEPARATOR=      ${register_username}        ${random_number}
    RETURN      ${register_username}

TWI Keyword IMBR Reject Camera Permission
    TWI Keyword Appium Wait For Element And Click        locator=${ENABLE_CAMERA_BUTTON}    timeout=10
    TWI Keyword Appium Wait For Element And Click        locator=${DONOT_ALLOW_CAMERA_BUTTON}
    TWI Keyword Appium Wait Until Page Contain Element       locator=${ERROR_REJECTION_CAMERA_PERMISSION}    timeout=5
    ${reject_camera_text}    TWI Keyword Appium Get Text             locator=${ERROR_REJECTION_CAMERA_PERMISSION}
    TWI Keyword Log To Console       message=${reject_camera_text}.
    Run Keyword If    '${reject_camera_text}' != '${ERROR_REJECTION_CAMERA_PERMISSION_TEXT}'    Fail    Rejection Camera Permission Failed.

TWI Keyword IMBR Check Location Error Message and Enable it
    TWI Keyword Appium Wait For Element And Click        locator=${ENABLE_BUTTON}
    ${location}    TWI Keyword Appium Get Text           locator=${LOCATION_STATUS}
    TWI Keyword Log To Console       message=Location Is ${location}.
    Run Keyword If    '${location}' != 'Off'    Fail    Location Is Already On.
    TWI Keyword Appium Press Keycode    4

TWI Keyword IMBR Verify Invalid Username And Password
    TWI Keyword Appium Wait Until Page Contain Element       locator=${INV_USERNAME}    timeout=5
    ${inv_username_text}    TWI Keyword Appium Get Text             locator=${INV_USERNAME}    locator_type=id
    TWI Keyword Log To Console       message=${inv_username_text}.
    Run Keyword If    '${inv_username_text}' != '${INV_USERNAME_LABEL}'    Fail    login Success (TC Failed).

TWI Keyword IMBR Verify Valid Username And Invalid Password
    TWI Keyword Appium Wait Until Page Contain Element       locator=${INV_PASS}    timeout=5
    ${inv_pass_text}    TWI Keyword Appium Get Text             locator=${INV_PASS}    locator_type=id
    TWI Keyword Log To Console       message=${inv_pass_text}.
    Run Keyword If    '${inv_pass_text}' != '${INV_PASS_LABEL}'    Fail    login Success (TC Failed).

TWI Keyword IMBR Check Profile username
    [Arguments]             ${username}
    TWI Keyword Appium Wait For Element And Click        locator=${PROFILE_BUTTON}    locator_type=xpath    timeout=100
    TWI Keyword Appium Wait Until Page Contain Element       locator=${PROFILE_USERNAME}    timeout=100
    ${Username_Found}    TWI Keyword Appium Get Text    locator=${PROFILE_USERNAME}
    Run Keyword If    '${Username_Found}' != '${username}'    Fail    Username isn't displayed or incorrect.

TWI Keyword IMBR Suite Setup
    Set Suite Variable    ${suite_setup_passed}    0
    TWI Keyword IMBR Start Appium Server
    TWI Keyword IMBR App Without Reset
    Set Suite Variable    ${suite_setup_passed}    1

TWI Keyword IMBR Smoke Test Suite Setup
    TWI Keyword IMBR Connect With HW Device
    TWI Keyword IMBR Verify That Device Is Connected

TWI Keyword IMBR Suite Teardown
    TWI Keyword IMBR Close IMBR App
    TWI Keyword IMBR Close Appium Server

TWI Keyword IMBR Smoke Test Teardown
    IF     '${TEST_STATUS}' == 'FAIL'
        ${exec_status}=      Run Keyword And Return Status    TWI Keyword IMBR Unpair
        TWI Keyword Sleep    1
        Run Keyword If    not ${exec_status}    TWI Keyword IMBR Close IMBR App
    END

TWI Keyword IMBR Login Suite Setup
    Set Suite Variable    ${suite_setup_passed}    0
    IF    ${SERIAL_ENABLED}
         TWI Keyword Open Arduino Port     arduino_port=${REF_DESIGN_HW_CONTROLLER_PORT}
    END
    TWI Keyword IMBR Start Appium Server
    TWI Keyword IMBR Open App Without Reset
    Set Suite Variable    ${suite_setup_passed}    1

TWI Keyword IMBR Start Appium Server
    close_appium_server
    start_appium_server

TWI Keyword IMBR Close Appium Server
    close_appium_server
