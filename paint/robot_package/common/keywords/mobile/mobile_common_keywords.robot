*** Settings ***
Documentation
...             Keywords:

Library    AppiumLibrary    run_on_failure=TWI Keyword Appium Capture Page Screenshot
Library    Screenshot
Library     ../../../libraries/robot_framework/CommLib.py
Library     ../../../libraries/robot_framework/AppiumAutomation/AppiumAutomation.py
Library    String
Resource    ../common_keywords.robot
Library    Process
*** Keywords ***
TWI Keyword Appium Wait To Finish Or Handle Error
    [Arguments]
    ...    ${expected_word}
    ...    ${expected_word_type}
    ...    ${error_message}
    ...    ${platform_name}
    ...    ${cancel_button_id}
    ...    ${try_again_button_id}
    ...    ${expected_word_action}=appear
    ...    ${action_on_error}=cancel
    ...    ${keyword_to_run_after_action_on_error}=${None}
    ...    ${number_of_tries}=0
    ...    ${int_timeout_sec}=240
    ...    ${wait_before_trying_again}=0

    TWI Keyword Log To Console       message=Wait for '${expected_word}' or handel error.
    ${float_timeout_sec}=    TWI Keyword Calculate Timeout Time    timeout_time_sec=${int_timeout_sec}
    ${try_again_counter}=    Set Variable    0
    WHILE    1    limit=NONE
        IF    '${expected_word_type}' == 'text'
            ${wait_for_any_result}=    TWI Keyword Appium Wait Until Any    first_word=${expected_word}
                                                                      ...    first_word_type=text
                                                                      ...    first_word_action=${expected_word_action}
                                                                      ...    second_word=${error_message}
                                                                      ...    second_word_type=text
                                                                      ...    int_timeout_sec=${int_timeout_sec}
                                                                      ...    platform_name=${platform_name}
        ELSE IF    '${expected_word_type}' == 'id'
            ${wait_for_any_result}=    TWI Keyword Appium Wait Until Any    first_word=${expected_word}
                                                                      ...    first_word_type=id
                                                                      ...    first_word_action=${expected_word_action}
                                                                      ...    second_word=${error_message}
                                                                      ...    second_word_type=text
                                                                      ...    int_timeout_sec=${int_timeout_sec}
                                                                      ...    platform_name=${platform_name}
        ELSE IF    '${expected_word_type}' == 'xpath'
            ${wait_for_any_result}=    TWI Keyword Appium Wait Until Any    first_word=${expected_word}
                                                                      ...    first_word_type=xpath
                                                                      ...    first_word_action=${expected_word_action}
                                                                      ...    second_word=${error_message}
                                                                      ...    second_word_type=text
                                                                      ...    int_timeout_sec=${int_timeout_sec}
                                                                      ...    platform_name=${platform_name}
        ELSE IF    '${expected_word_type}' == 'accessibility_id'
            ${wait_for_any_result}=    TWI Keyword Appium Wait Until Any    first_word=${expected_word}
                                                                      ...    first_word_type=accessibility_id
                                                                      ...    first_word_action=${expected_word_action}
                                                                      ...    second_word=${error_message}
                                                                      ...    second_word_type=text
                                                                      ...    int_timeout_sec=${int_timeout_sec}
                                                                      ...    platform_name=${platform_name}
        END
        IF    '${wait_for_any_result}' == '${expected_word}'
             RETURN
        ELSE IF    '${wait_for_any_result}' == '${error_message}'
        # break counter for each error
            TWI Keyword Sleep    time=${wait_before_trying_again}
            ${try_again_counter}=    TWI Keyword Appium Action On Error    action_on_error=${action_on_error}
                                                                    ...    number_of_tries=${number_of_tries}
                                                                    ...    try_again_counter=${try_again_counter}
                                                                    ...    cancel_button_id=${cancel_button_id}
                                                                    ...    try_again_button_id=${try_again_button_id}
                                                                    ...    keyword_to_run_after_action_on_error=${keyword_to_run_after_action_on_error}
        END
        ${current_time_sec}=    TWI Keyword Get Current Time
        IF    ${current_time_sec} > ${float_timeout_sec}
             TWI Keyword Fail    message=Timed out while scanning! didn't find the expected '${expected_word}' or the error identifier '${error_message}'.
        END
        TWI Keyword Sleep    1
    END
TWI Keyword Appium Wait Until Any
    [Arguments]    ${first_word}    ${first_word_type}    ${second_word}    ${second_word_type}    ${int_timeout_sec}    ${platform_name}    ${first_word_action}=appear     ${second_word_action}=appear
    TWI Keyword Log To Console       message=Wait Until Page Contain '${first_word}' or '${second_word}'.
    ${float_timeout_sec}=    TWI Keyword Calculate Timeout Time    timeout_time_sec=${int_timeout_sec}
    WHILE    1    limit=NONE
        IF  '${first_word_action}' == 'appear'
            IF    '${first_word_type}' == 'text'
                ${found_first_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Text    text=${first_word}    platform_name=${platform_name}
            ELSE IF    '${first_word_type}' == 'id'
                ${found_first_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=${first_word}
            ELSE IF    '${first_word_type}' == 'xpath'
                ${found_first_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=${first_word}
                                                                                                                  ...    locator_type=xpath
            ELSE IF    '${first_word_type}' == 'accessibility_id'
                ${found_first_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=${first_word}
                                                                                                                  ...    locator_type=accessibility_id
            END
        ELSE IF  '${first_word_action}' == 'disappear'
            IF    '${first_word_type}' == 'text'
                ${found_first_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Not Contain Text    text=${first_word}    platform_name=${platform_name}
            ELSE IF    '${first_word_type}' == 'id'
                ${found_first_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Not Contain Element    locator=${first_word}
            ELSE IF    '${first_word_type}' == 'xpath'
                ${found_first_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Not Contain Element    locator=${first_word}
                                                                                                                      ...    locator_type=xpath
            ELSE IF    '${first_word_type}' == 'accessibility_id'
                ${found_first_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Not Contain Element    locator=${first_word}
                                                                                                                      ...    locator_type=accessibility_id
            END
        END
        IF  '${second_word_action}' == 'appear'
            IF    '${second_word_type}' == 'text'
                ${found_second_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Text    text=${second_word}    platform_name=${platform_name}
            ELSE IF    '${second_word_type}' == 'id'
                ${found_second_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=${second_word}
            ELSE IF    '${second_word_type}' == 'xpath'
                ${found_second_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=${second_word}
                                                                                                           ...    locator_type=xpath
            ELSE IF    '${second_word_type}' == 'accessibility_id'
                ${found_second_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=${second_word}
                                                                                                           ...    locator_type=accessibility_id
            END
        ELSE IF  '${second_word_action}' == 'disappear'
            IF    '${second_word_type}' == 'text'
                ${found_second_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Text    text=${second_word}    platform_name=${platform_name}
            ELSE IF    '${second_word_type}' == 'id'
                ${found_second_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=${second_word}
            ELSE IF    '${second_word_type}' == 'xpath'
                ${found_second_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=${second_word}
                                                                                                                   ...    locator_type=xpath
            ELSE IF    '${second_word_type}' == 'accessibility_id'
                ${found_second_word}=  Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=${second_word}
                                                                                                                   ...    locator_type=accessibility_id
            END
        END
        IF    ${found_first_word} or ${found_second_word}
            IF    ${found_first_word}
                RETURN    ${first_word}
            ELSE IF    ${found_second_word}
                RETURN    ${second_word}
            END
        END
        ${current_time_sec}=    TWI Keyword Get Current Time
        IF    ${current_time_sec} > ${float_timeout_sec}
             TWI Keyword Fail    message=Timed out while scanning! didn't find the '${first_word}' or '${second_word}'.
        END
        TWI Keyword Sleep    1
    END
TWI Keyword Appium Wait Until Element Contains Any Text
    [Arguments]    ${element}    ${int_timeout_sec}=60
    TWI Keyword Log To Console       message=Wait until element '${element}' contains any Text.
    ${float_timeout_sec}=    TWI Keyword Calculate Timeout Time    timeout_time_sec=${int_timeout_sec}
    WHILE    1    limit=NONE
        ${text}=  TWI Keyword Appium Get Text    locator=${element}
        IF  not '${text}' == '${EMPTY}'
            TWI Keyword Log To Console       message=Found text is "${text}".
            RETURN
        END
        ${current_time_sec}=    TWI Keyword Get Current Time
        IF    ${current_time_sec} > ${float_timeout_sec}
            TWI Keyword Fail    message=Timed out while scanning! Element '${element}' didn't contain text.
        END
        TWI Keyword Sleep    1
    END
TWI Keyword Appium Wait Until Element Contains The Text
    [Arguments]    ${xpath}    ${text}    ${int_timeout_sec}=60
    TWI Keyword Log To Console       message=Wait Until Element '${xpath}' Contains Text.
    ${float_timeout_sec}=    TWI Keyword Calculate Timeout Time    timeout_time_sec=${int_timeout_sec}
    WHILE    1    limit=NONE
        ${current_text}=  AppiumLibrary.Get Text    xpath=${xpath}
        IF  '${current_text}' == '${text}'
            RETURN    ${True}
        END
        ${current_time_sec}=    TWI Keyword Get Current Time
        IF    ${current_time_sec} > ${float_timeout_sec}
            RETURN    ${False}
        END
        TWI Keyword Sleep    1
    END
TWI Keyword Appium Action On Error
    [Arguments]    ${cancel_button_id}    ${try_again_button_id}    ${keyword_to_run_after_action_on_error}=${None}    ${action_on_error}=cancel    ${number_of_tries}=0    ${try_again_counter}=0
    IF    '${action_on_error}' == 'try_again'
        TWI Keyword Log To Console       message=Action On Error '${action_on_error}'. ${number_of_tries} Tries.
        ${try_again_counter}=    Evaluate    ${try_again_counter}+1
        IF  ${try_again_counter} > ${number_of_tries}
            TWI Keyword Fail    message=Failed after ${number_of_tries} tries.
        END
        TWI Keyword Appium Wait For Element And Click    locator=${try_again_button_id}
        IF  '${keyword_to_run_after_action_on_error}' != '${None}'
             Run Keyword    ${keyword_to_run_after_action_on_error}
        END
        RETURN    ${try_again_counter}
    ELSE IF    '${action_on_error}' == 'cancel'
        TWI Keyword Log To Console       message=Action On Error '${action_on_error}'.
        TWI Keyword Appium Wait For Element And Click    locator=${cancel_button_id}
        IF  ${keyword_to_run_after_action_on_error} != ${None}
             Run Keyword    ${keyword_to_run_after_action_on_error}
        END
        RETURN    -1
    END
TWI Keyword Appium Swipe On Element
    [Arguments]    ${element_identifier}    ${swipe_direction}    ${margin}=10
    TWI Keyword Log To Console       message=Swipe ${swipe_direction} on element '${element_identifier}'.
    TWI Keyword Appium Wait Until Page Contains Element    ${element_identifier}

    ${location}=    Get Element Location    id=${element_identifier}
    ${size}=        Get Element Size        id=${element_identifier}
    ${x}=       Set Variable    ${location['x']}
    ${y}=       Set Variable    ${location['y']}
    ${width}=   Set Variable    ${size['width']}
    ${height}=  Set Variable    ${size['height']}
    IF  '${swipe_direction}' == 'right' or '${swipe_direction}' == 'left'
        IF    '${swipe_direction}' == 'left'
            ${x_start}=    Evaluate    (${x} + (${width} - ${margin}))
            ${x_end}=    Evaluate    (${x} + ${margin})
            ${y_start}=    Evaluate    (${y} + (${height}/2))
            ${y_end}=    Evaluate    (${y} + (${height}/2))
        ELSE IF  '${swipe_direction}' == 'right'
            ${x_start}=    Evaluate    (${x} + ${margin})
            ${x_end}=    Evaluate    (${x} + (${width} - ${margin}))
            ${y_start}=    Evaluate    (${y} + (${height}/2))
            ${y_end}=    Evaluate    (${y} + (${height}/2))
        END
    ELSE IF  '${swipe_direction}' == 'up' or '${swipe_direction}' == 'down'
        IF    '${swipe_direction}' == 'down'
            ${x_start}=    Evaluate    (${x} + (${width}/2))
            ${x_end}=    Evaluate    (${x} + (${width}/2))
            ${y_start}=    Evaluate    (${y} + ${margin})
            ${y_end}=    Evaluate    (${y} + (${height} - ${margin}))
        ELSE IF  '${swipe_direction}' == 'up'
            ${x_start}=    Evaluate    (${x} + (${width}/2))
            ${x_end}=    Evaluate    (${x} + (${width}/2))
            ${y_start}=    Evaluate    (${y} + (${height} - ${margin}))
            ${y_end}=    Evaluate    (${y} + ${margin})
        END
    END
    TWI Keyword Appium Swipe    ${x_start}    ${y_start}    ${x_end}    ${y_end}    duration=200
TWI Keyword Appium Wait Until Page Contains Element
    [Arguments]    ${locator}    ${locator_type}=id    ${timeout}=${None}
    TWI Keyword Log To Console       message=Wait Until Page Contains Element '${locator}'.
    AppiumLibrary.Wait Until Page Contains Element    ${locator_type}=${locator}    timeout=${timeout}
TWI Keyword Appium Wait Until Page Contains
    [Arguments]    ${text}    ${platform_name}    ${timeout}=${None}    ${contains}=1
    TWI Keyword Log To Console    message=Wait Until Page Contains '${text}'.
    IF  '${platform_name}' == 'Android'
        AppiumLibrary.Wait Until Page Contains    text=${text}    timeout=${timeout}
    ELSE IF  '${platform_name}' == 'IOS'
        IF  ${contains}
            AppiumLibrary.Wait Until Page Contains Element    xpath=//*[contains(@label,"${text}")]    timeout=${timeout}
        ELSE IF  not ${contains}
             AppiumLibrary.Wait Until Page Contains Element    xpath=//*[@label='${text}']    timeout=${timeout}
        END
    ELSE
        TWI Keyword Fail       message=No platform with the name '${platform_name}'.
    END
TWI Keyword Appium Wait Until Page Does Not Contain Element
    [Arguments]    ${locator}    ${locator_type}=id    ${timeout}=${None}
    TWI Keyword Log To Console       message=Wait Until Page Does Not Contain Element '${locator}'.
    AppiumLibrary.Wait Until Page Does Not Contain Element    ${locator_type}=${locator}    timeout=${timeout}
TWI Keyword Appium Wait Until Page Contain Element
    [Arguments]    ${locator}    ${locator_type}=id    ${timeout}=${None}
    TWI Keyword Log To Console       message=Wait Until Page Does Contain Element '${locator}'.
    AppiumLibrary.Wait Until Page Contains Element    ${locator_type}=${locator}    timeout=${timeout}
TWI Keyword Appium Page Should Contain Element
    [Arguments]    ${locator}    ${locator_type}=id
    TWI Keyword Log To Console       message=Page Should Contain Element '${locator}'.
    AppiumLibrary.Page Should Contain Element    ${locator_type}=${locator}
TWI Keyword Appium Page Should Not Contain Element
    [Arguments]    ${locator}    ${locator_type}=id
    TWI Keyword Log To Console       message=Page Should Contain Element '${locator}'.
    AppiumLibrary.Page Should Not Contain Element    ${locator_type}=${locator}
TWI Keyword Appium Page Should Contain Text
    [Arguments]    ${text}    ${platform_name}
    TWI Keyword Log To Console    message=Page Should Contain Text '${text}'.
    IF  '${platform_name}' == 'Android'
        AppiumLibrary.Page Should Contain Text    text=${text}
    ELSE IF  '${platform_name}' == 'IOS'
        AppiumLibrary.Page Should Contain Element    xpath=//*[contains(@label, "${text}")]
    ELSE
        TWI Keyword Fail       message=No platform with the name '${platform_name}'.
    END
TWI Keyword Appium Page Should Contain Text And Click
    [Arguments]    ${text}    ${platform_name}
    TWI Keyword Log To Console    message=Page Should Contain Text '${text}'.
    IF  '${platform_name}' == 'Android'
        AppiumLibrary.Page Should Contain Text    text=${text}
        TWI Keyword Appium Click Text    text=${text}    platform_name=${platform_name}
    ELSE IF  '${platform_name}' == 'IOS'
        AppiumLibrary.Page Should Contain Element    xpath=//*[contains(@label, "${text}")]
        TWI Keyword Appium Click Text    text=${text}    platform_name=${platform_name}
    ELSE
        TWI Keyword Fail       message=No platform with the name '${platform_name}'.
    END
TWI Keyword Appium Wait For Text And Click
    [Arguments]    ${text}    ${platform_name}    ${timeout}=5    ${contains}=1
    TWI Keyword Log To Console       message=Wait For Text '${text}' And Click it.
    IF  '${timeout}' != '0'
        TWI Keyword Appium Wait Until Page Contains    text=${text}    timeout=${timeout}    platform_name=${platform_name}
    END
    TWI Keyword Appium Click Text    text=${text}    platform_name=${platform_name}    contains=${contains}
TWI Keyword Appium Click Text
    [Arguments]    ${text}    ${platform_name}    ${contains}=1
    TWI Keyword Log To Console    message=Click text '${text}'.
    IF  '${platform_name}' == 'Android'
        AppiumLibrary.Click Text    text=${text}
    ELSE IF  '${platform_name}' == 'IOS'
        IF  ${contains}
            AppiumLibrary.Click Element    xpath=//*[contains(@label,"${text}")]
        ELSE IF  not ${contains}
             AppiumLibrary.Click Element    xpath=//*[@label='${text}']
        END
    ELSE
        TWI Keyword Fail       message=No platform with the name '${platform_name}'.
    END
TWI Keyword Appium Page Should Contain Element And Click
    [Arguments]    ${locator}    ${locator_type}=id
    TWI Keyword Log To Console       message=Page Should Contain '${locator}' And Click it.
    AppiumLibrary.Page Should Contain Element    ${locator_type}=${locator}
    AppiumLibrary.Click Element    ${locator_type}=${locator}
TWI Keyword Appium Wait For Element And Click
    [Arguments]    ${locator}    ${locator_type}=id    ${timeout}=5
    TWI Keyword Log To Console       message=Wait For Element '${locator}' And Click it.
    IF  '${timeout}' != '0'
        AppiumLibrary.Wait Until Page Contains Element    ${locator_type}=${locator}    timeout=${timeout}
    END
    AppiumLibrary.Click Element    ${locator_type}=${locator}
TWI Keyword Appium Click Element
    [Arguments]    ${locator}    ${locator_type}=id
    TWI Keyword Log To Console       message=Click Element '${locator}'.
    AppiumLibrary.Click Element    ${locator_type}=${locator}
TWI Keyword Appium Input Text
    [Arguments]    ${locator}    ${text}    ${locator_type}=id
    TWI Keyword Log To Console       message=Input Text in '${locator}'.
    AppiumLibrary.Input Text    ${locator_type}=${locator}    text=${text}
TWI Keyword Appium Long Press
    [Arguments]    ${locator}    ${locator_type}=id    ${duration}=1000
    TWI Keyword Log To Console       message=Long Press on '${locator}'.
    AppiumLibrary.Long Press    ${locator_type}=${locator}    duration=${duration}
TWI Keyword Appium Long Press On iOS
    [Arguments]    ${locator}    ${locator_type}=id    ${duration}=1000
    ${location}=    Get Element Location    ${locator_type}=${locator}
    TWI Keyword Log To Console    message=${location}
    ${x}    Evaluate    ${location['x']}+30
    ${y}    Evaluate    ${location['y']}+30
    @{location_list}=	    create list	      ${x}   ${y}
    TWI Keyword Log To Console    message=${location_list}
    @{location_lists}=	    create list	      ${location_list}
    TWI Keyword Log To Console    message=@{location_lists}
    AppiumLibrary.Tap with Positions	   ${duration}	   @{location_lists}
TWI Keyword Appium Swipe
    [Arguments]    ${x_start}    ${y_start}    ${x_end}    ${y_end}    ${duration}=1000
    AppiumLibrary.Swipe    ${x_start}    ${y_start}    ${x_end}    ${y_end}    duration=${duration}
TWI Keyword Appium Clear Text
    [Arguments]    ${locator}    ${locator_type}=id
    TWI Keyword Log To Console       message=Clear text from '${locator}'.
    AppiumLibrary.Clear Text    locator=${locator}
TWI Keyword Appium Element Should Contain Text
    [Arguments]    ${locator}    ${text}    ${locator_type}=id
    TWI Keyword Log To Console       message=Element '${locator}' should contain text '${text}'.
    AppiumLibrary.Element Should Contain Text    ${locator_type}=${locator}    expected=${text}
TWI Keyword Appium Click Element At Coordinates
    [Arguments]    ${x}    ${y}    ${duration}=500
    TWI Keyword Log To Console       message=Click at X=${x} and Y=${y}.
    @{firstFinger}	        create list	      ${x}	     ${y}
    @{fingerPositions}	    create list	      ${firstFinger}
#    TWI Keyword Sleep	1
    AppiumLibrary.Tap with Positions	   ${duration}	   @{fingerPositions}
TWI Keyword Appium Page Should Not Contain Text
    [Arguments]    ${text}    ${platform_name}
    TWI Keyword Log To Console    message=Page Should Not Contain Text '${text}'.
    IF  '${platform_name}' == 'Android'
        AppiumLibrary.Page Should Not Contain Text    text=${text}
    ELSE IF  '${platform_name}' == 'IOS'
        AppiumLibrary.Page Should Not Contain Element    xpath=//*[contains(@label,"${text}")]
    ELSE
        TWI Keyword Fail       message=No platform with the name '${platform_name}'.
    END
    AppiumLibrary.Page Should Not Contain Text    text=${text}
TWI Keyword Appium Get Element Size
    [Arguments]    ${locator}    ${locator_type}=id
    ${element_size}    AppiumLibrary.Get Element Size    ${locator_type}=${locator}
    RETURN    ${element_size}
TWI Keyword Appium Get Element Location
    [Arguments]    ${locator}    ${locator_type}=id
    ${element_location}    AppiumLibrary.Get Element Location    ${locator_type}=${locator}
    RETURN    ${element_location}
TWI Keyword Appium Get Element Coordinates
    [Arguments]    ${element_location}
    ${x}    ${y}    Get Element Coordinates    location=${element_location}
    RETURN    ${x}    ${y}
TWI Keyword Appium Get Element Dimensions
    [Arguments]    ${element_size}
    ${height}    ${width}    Get Element Size    id=${element_size}
    RETURN    ${height}    ${width}
TWI Keyword Appium Get Text
    [Arguments]    ${locator}    ${locator_type}=id
    TWI Keyword Log To Console       message=Get text from '${locator}'.
    ${text}    AppiumLibrary.Get Text    ${locator_type}=${locator}
    RETURN    ${text}
TWI Keyword Appium Capture Page Screenshot
    TWI Keyword Log To Console       message=Capture screenshot.
    AppiumLibrary.Capture Page Screenshot
TWI Keyword Appium Press Keycode
    [Arguments]    ${keycode}
    TWI Keyword Log To Console       message=Press keycode ${keycode}.
    AppiumLibrary.Press Keycode    keycode=${keycode}
TWI Keyword Appium Wait Until Page Does Not Contain
    [Arguments]    ${text}    ${platform_name}    ${timeout}=${None}
    TWI Keyword Log To Console    message=Wait Until Page Does Not Contain '${text}'.
    IF  '${platform_name}' == 'Android'
        AppiumLibrary.Wait Until Page Does Not Contain    text=${text}    timeout=${timeout}
    ELSE IF  '${platform_name}' == 'IOS'
        AppiumLibrary.Wait Until Page Does Not Contain Element    xpath=//*[contains(@label,"${text}")]     timeout=${timeout}
    ELSE
        TWI Keyword Fail       message=No platform with the name '${platform_name}'.
    END
TWI Keyword Open Application
    [Arguments]
    ...    ${connection_type}
    ...    ${device_name}
    ...    ${app_path}
    ...    ${app_package}
    ...    ${platform}
    ...    ${automator_name}
    ...    ${device_id}=${None}
    ...    ${auto_permissions}=true
    ...    ${no_reset}=true
    ...    ${auto_launch}=false
    ...    ${timeout}=9999
    ...    ${idle_timeout}=${100}
    ...    ${platformVersion}=${None}
    ...    ${xcodeOrgId}=${None}
    ...    ${xcodeSigningId}=${None}
    ...    ${useNewWDA}=false
    ...    ${usePrebuiltWDA}=false
    ...    ${waitForIdleTimeout}=${0}
    ...    ${derivedDataPath}=/Users/user/Library/Developer/Xcode/DerivedData/WebDriverAgent-eefnhsnbzqkaizbywdkxfgbhslib
    ...    ${wdaLocalPort}=8100
    ...    ${allow_os_alerts}=false
    IF    '${platform}' == 'Android'
         IF    '${connection_type}' == 'wifi'
             AppiumLibrary.Open Application    http://localhost:4723/wd/hub
                                        ...    uiautomator2ServerInstallTimeout=100000
                                        ...    automationName=${automator_name}
                                        ...    app=${app_path}
                                        ...    platformName=${platform}
                                        ...    appPackage=${app_package}
                                        ...    appActivity=${EMPTY}
                                        ...    deviceName=${device_name}
                                        ...    udid=${device_name}
                                        ...    deviceid=${device_id}
                                        ...    newCommandTimeout=${timeout}
                                        ...    autoGrantPermissions=${auto_permissions}
                                        ...    noReset=${no_reset}
                                        ...    autoLaunch=${auto_launch}
                                        ...    appium:settings[waitForIdleTimeout]=${idle_timeout}
        ELSE IF    '${connection_type}' == 'usb'
            AppiumLibrary.Open Application    http://localhost:4723/wd/hub
                                       ...    uiautomator2ServerInstallTimeout=100000
                                       ...    automationName=${automator_name}
                                       ...    app=${app_path}
                                       ...    platformName=${platform}
                                       ...    appPackage=${app_package}
                                       ...    appActivity=${EMPTY}
                                       ...    deviceName=${device_name}
                                       ...    udid=${device_name}
                                       ...    newCommandTimeout=${timeout}
                                       ...    autoGrantPermissions=${auto_permissions}
                                       ...    noReset=${no_reset}
                                       ...    autoLaunch=${auto_launch}
                                       ...    appium:settings[waitForIdleTimeout]=${idle_timeout}
                                       ...    appium:autoAcceptAlerts=${allow_os_alerts}
        END
    ELSE IF  '${platform}' == 'IOS'
        AppiumLibrary.Open Application	http://localhost:4723/wd/hub
                                   ...    platformName=${platform}
                                   ...    platformVersion=${platformVersion}
                                   ...    deviceName=${device_name}
                                   ...    app=${app_path}
                                   ...    udid=${device_name}
                                   ...    xcodeOrgId=${xcodeOrgId}
                                   ...    automationName=${automator_name}
                                   ...    xcodeSigningId=${xcodeSigningId}
                                   ...    useNewWDA=${useNewWDA}
                                   ...    usePrebuiltWDA=${usePrebuiltWDA}
                                   ...    waitForIdleTimeout=${waitForIdleTimeout}
                                   ...    derivedDataPath=${derivedDataPath}
                                   ...    wdaLocalPort=${wdaLocalPort}
                                   ...    appium:settings[waitForIdleTimeout]=${idle_timeout}
                                   ...    autoLaunch=${auto_launch}
                                   ...    noReset=${no_reset}
                                   ...    newCommandTimeout=${timeout}
                                   ...    appium:settings[waitForIdleTimeout]=${idle_timeout}
    END
TWI Keyword Close Application
    TWI Keyword Log To Console    message=Closing App
    AppiumLibrary.Close Application
TWI Keyword Launch Application
    AppiumLibrary.Launch Application
TWI Keyword Terminate Application
    [Arguments]    ${app_package}
    AppiumLibrary.Terminate Application    app_id=${app_package}
TWI Keyword Remove Application
    [Arguments]    ${app_package}
    AppiumLibrary.Remove Application    application_id=${app_package}
TWI Keyword Activate Application
    [Arguments]    ${app_package}
    AppiumLibrary.Activate Application    app_id=${app_package}
TWI Keyword Click Element And Try Again If Failed
    [Arguments]    ${element_locator}    ${element_locator_type}    ${expected_locator}    ${expected_locator_type}    ${platform_name}    ${number_of_tries}=2    ${time_before_trying_again}=5    ${timeout}=5
    ${number_of_tries_counter}    Set Variable    0
    WHILE    '${number_of_tries_counter}' < '${number_of_tries}'
        IF  '${element_locator_type}' == 'text'
            TWI Keyword Appium Wait For Text And Click    text=${element_locator}    platform_name=${PLATFORM_NAME}
        ELSE IF  '${element_locator_type}' == 'id'
            TWI Keyword Appium Wait For Element And Click    locator=${element_locator}    locator_type=${element_locator_type}
        ELSE IF  '${element_locator_type}' == 'xpath'
            TWI Keyword Appium Wait For Element And Click    locator=${element_locator}    locator_type=${element_locator_type}
        ELSE IF  '${element_locator_type}' == 'accessibility_id'
            TWI Keyword Appium Wait For Element And Click    locator=${element_locator}    locator_type=${element_locator_type}
        END
        IF  '${expected_locator_type}' == 'text'
        ${found_the_expected_element}     Run Keyword And Return Status    TWI Keyword Appium Wait Until Page Contains    text=${expected_locator}    timeout=${timeout}    platform_name=${platform_name}
        ELSE IF  '${expected_locator_type}' == 'id'
            ${found_the_expected_element}     Run Keyword And Return Status    TWI Keyword Appium Wait Until Page Contains Element    locator=${expected_locator}    locator_type=${expected_locator_type}    timeout=${timeout}
        ELSE IF  '${expected_locator_type}' == 'xpath'
            ${found_the_expected_element}     Run Keyword And Return Status    TWI Keyword Appium Wait Until Page Contains Element    locator=${expected_locator}    locator_type=${expected_locator_type}    timeout=${timeout}
        ELSE IF  '${expected_locator_type}' == 'accessibility_id'
            ${found_the_expected_element}     Run Keyword And Return Status    TWI Keyword Appium Wait Until Page Contains Element    locator=${expected_locator}    locator_type=${expected_locator_type}    timeout=${timeout}
        END
        IF  ${found_the_expected_element}
            RETURN
        ELSE
            ${number_of_tries_counter}=    Evaluate    ${number_of_tries_counter}+1
            IF  '${number_of_tries_counter}' == '${number_of_tries}'
                TWI Keyword Fail    message=Couldn't find the expexted "${expected_locator}" after ${number_of_tries} clicks on "${element_locator}".
            END
        END
        TWI Keyword Sleep    time=${time_before_trying_again}
    END
TWI Keyword Start Appium Server
    Run Keyword And Ignore Error    AppiumAutomation.Close Appium Server
    AppiumAutomation.Start Appium Server
TWI Keyword Close Appium Server
    AppiumAutomation.Close Appium Server
TWI Keyword Get Elements List Scroll Up Start And End Points
    [Arguments]    ${scroll_view_locator}    ${scroll_view_locator_type}    ${first_element_locator}    ${first_element_locator_type}    ${second_element_locator}=${None}    ${second_element_locator_type}=${None}    ${use_single_element}=${False}    ${scroll_direction}=up

    ${scroll_view_size}=    Get Element Size    ${scroll_view_locator_type}=${scroll_view_locator}
    ${scroll_view_height}    ${scroll_view_width}    Get Element Dimensions    ${scroll_view_size}

    ${scroll_view_location}=    Get Element Location    ${scroll_view_locator_type}=${scroll_view_locator}
    ${scroll_view_x}    ${scroll_view_y}    Get Element Coordinates    ${scroll_view_location}

    ${element_location}=    Get Element Location    ${first_element_locator_type}=${first_element_locator}
    ${first_element_x}    ${first_element_y}    Get Element Coordinates    ${element_location}

    IF  ${use_single_element} == ${False}
        ${second_element_location}=    Get Element Location    ${second_element_locator_type}=${second_element_locator}
        ${second_element_x}    ${second_element_y}    Get Element Coordinates    ${second_element_location}
    END

    ${first_element_size}=    Get Element Size    ${first_element_locator_type}=${first_element_locator}
    ${first_element_height}    ${first_element_width}    Get Element Dimensions    ${first_element_size}

    ${x_start}=    Evaluate    (${scroll_view_x}+${scroll_view_width})/2
    ${x_end}=    Evaluate    (${scroll_view_x}+${scroll_view_width})/2

    IF  ${use_single_element} == ${False}
        ${top_margin}=    Evaluate    ((${second_element_y}-${first_element_y}) - ${first_element_height})
    ELSE IF  ${use_single_element} == ${True}
        ${top_margin}=    Evaluate    (${first_element_y}-${scroll_view_y})
    ELSE
        TWI Keyword Fail    message=Invalid \${use_single_element} input!
    END

    IF  '${scroll_direction}' == 'up'
        ${y_start}=    Evaluate    (${scroll_view_y} + (${scroll_view_height}/2)) + ((${first_element_height}/2) + ${top_margin})
        ${y_end}=    Evaluate     (${scroll_view_y} + (${scroll_view_height}/2)) + ((${first_element_height}/2) + ${top_margin}) - (${first_element_height} + (${top_margin}*2))
    ELSE IF  '${scroll_direction}' == 'down'
        ${y_start}=    Evaluate     (${scroll_view_y} + (${scroll_view_height}/2)) + ((${first_element_height}/2) + ${top_margin}) - (${first_element_height} + (${top_margin}*2))
        ${y_end}=    Evaluate    (${scroll_view_y} + (${scroll_view_height}/2)) + ((${first_element_height}/2) + ${top_margin})
    ELSE
        TWI Keyword Fail    message=Invalid \${scroll_direction} input!
    END

    RETURN    ${x_start}    ${x_end}    ${y_start}    ${y_end}
TWI Keyword Uninstall IOS WebDriverAgent
    [Arguments]         ${IOS_WEB_DRIVER_APP_NAME}    ${PLATFORM_NAME}=IOS
    IF    '${PLATFORM_NAME}' == 'IOS'
        ${result}=      Run Process     ideviceinstaller  --uninstall      ${IOS_WEB_DRIVER_APP_NAME}
    END
