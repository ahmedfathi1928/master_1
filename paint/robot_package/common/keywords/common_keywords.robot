*** Settings ***
Documentation
...             Keywords:
...  | TWI Keyword Log To Console
...  | TWI Keyword Sleep

Library    ../../libraries/robot_framework/CustomDialogs.py
Library    Dialogs
#Library    PyWindowsGuiLibrary
Library    pyautogui
Library    OperatingSystem
Library    Screenshot
Library    ScreenCapLibrary
Library     ../../libraries/robot_framework/CommLib.py
Library    String
Resource    ../../apps/crypto_guard/resources/test_data/project_data.robot
*** Keywords ***
TWI Keyword Log To Console
    [Documentation]     Logs will writen to the report
    [Arguments]     ${message}    ${log_in_console}=${LOGS_ENABLE}    ${text_color}=blue    ${sleep_time_sec}=0
    IF    '${log_in_console}' == 'true'
        ${color}=    TWI Keyword Get Color    color=${text_color}
        ${color}=    Evaluate  ${color}
        Log To Console    message=${\n}${color}${message}
        IF    ${sleep_time_sec} != 0
            TWI Keyword Sleep    time=${sleep_time_sec}
        END
    ELSE IF  '${log_in_console}' == 'false'
        Log    message=${message}
    END
TWI Keyword Sleep
    [Documentation]
    ...            """Pauses the test executed for the given time.
    ...
    ...        ``time`` may be either a number or a time string. Time strings are in
    ...        a format such as ``1 day 2 hours 3 minutes 4 seconds 5milliseconds`` or
    ...        ``1d 2h 3m 4s 5ms``, and they are fully explained in an appendix of
    ...        Robot Framework User Guide. Optional `reason` can be used to explain why
    ...        sleeping is necessary. Both the time slept and the reason are logged.
    ...
    ...        Examples:
    ...        | Sleep | 42                   |
    ...        | Sleep | 1.5                  |
    ...        | Sleep | 2 minutes 10 seconds |
    ...        | Sleep | 10s                  | Wait for a reply |
    ...        """
    [Arguments]     ${time}
    Log To Console    message="${\n}Sleep for ${time} seconds"
    BuiltIn.Sleep    ${time}
TWI Keyword Get Current Time
    ${current_time}    Get Current Time
    RETURN    ${current_time}
TWI Keyword Calculate Timeout Time
    [Arguments]    ${timeout_time_sec}
    ${timeout_time}    Calculate Timeout Time    timeout_time_sec=${timeout_time_sec}
    RETURN    ${timeout_time}
TWI Keyword Pause Execution
    [Arguments]    ${message}
    Pause Execution    message=${message}
TWI Keyword Execute Manual Step
    [Arguments]    ${message}
    Execute Manual Step    message=${message}
TWI Keyword Get Color
    [Arguments]    ${color}=blue
    IF  '${color}' == 'blue'
        RETURN    "\\033[34m"
    ELSE IF  '${color}' == 'white'
        RETURN    "\\033[7m"
    ELSE IF  '${color}' == 'gray'
        RETURN    "\\033[5m"
    ELSE IF  '${color}' == 'red'
        RETURN    "\\033[31m"
    ELSE IF  '${color}' == 'green'
        RETURN    "\\033[32m"
    ELSE IF  '${color}' == 'yellow'
        RETURN    "\\033[33m"
    ELSE IF  '${color}' == 'pink'
        RETURN    "\\033[35m"
    END
TWI Keyword Windows Click On Search Bar To Type The Path
    TWI Keyword Sleep    1
    pyautogui.Hotkey   ctrl   l
    TWI Keyword Sleep    1
TWI Keyword Click Paste
    pyautogui.Hotkey   ctrl   v
TWI Keyword Write Text
    [Arguments]    ${text}
    PyWindowsGuiLibrary.Text Writer    string=${text}
TWI Keyword Wait Until Keyword Succeeds
    [Arguments]    ${retry}    ${retry_interval}    ${keyword_name}
    Wait Until Keyword Succeeds    ${retry}     ${retry_interval}       ${keyword_name}
TWI Keyword Fail
    [Arguments]    ${message}
    BuiltIn.Fail    msg=${message}
TWI Keyword Compare Two Variables Are Not Equale
    [Arguments]     ${first_variable}    ${second_variable}
    IF   '${first_variable}' == '${second_variable}'
          TWI Keyword Fail   message=Variables are equal first variable '${first_variable}' doesn't equal second variable '${second_variable}'
    END
TWI Keyword Compare Two Variables Are Equale
    [Arguments]     ${first_variable}    ${second_variable}
    IF   '${first_variable}' != '${second_variable}'
          TWI Keyword Fail   message=Variables aren't equal first variable '${first_variable}' doesn't equal second variable '${second_variable}'
    END
TWI Keyword Compare Two Variables Have Lists Are Equale
    [Arguments]     ${first_variable}    ${second_variable}
    IF   ${first_variable} != ${second_variable}
          TWI Keyword Fail   message=Variables Are Not Equale
    END
TWI Keyword Item Should Be Found In The List
    [Arguments]     ${list}     ${item}
    ${item_index}   Set Variable    0
    ${list_length}    Get Length    ${list}
    WHILE  ${item_index} < ${list_length}
        IF  '${list}[${item_index}][0]' == '${item}[0]'
            IF  '${list}[${item_index}][1]' == '${item}[1]'
                RETURN
            ELSE
                ${item_index}   Evaluate   ${item_index} + 1
                IF  ${item_index} == ${list_length}
                    TWI Keyword Fail    message=Item "${item}" not found in the list "${list}".
                END
            END
        ELSE
            ${item_index}   Evaluate   ${item_index} + 1
            IF  ${item_index} == ${list_length}
                TWI Keyword Fail    message=Item "${item}" not found in the list "${list}".
            END
        END
    END
TWI Keyword Item Should Not Be Found In The List
    [Arguments]     ${list}     ${item}
    ${item_index}   Set Variable    0
    ${list_length}    Get Length    ${list}
    WHILE  ${item_index} < ${list_length}
        IF  '${list}[${item_index}][0]' == '${item}[0]'
            IF  '${list}[${item_index}][1]' == '${item}[1]'
                 IF  '${list}[${item_index}][2]' == '${item}[2]'
                    TWI Keyword Fail    message=Item "${item}" found in the list "${list}".
                ELSE
                    ${item_index}   Evaluate   ${item_index} + 1
                END
            ELSE
                ${item_index}   Evaluate   ${item_index} + 1
            END
        ELSE
            ${item_index}   Evaluate   ${item_index} + 1
        END
    END
TWI Keyword Skip If Equals
    [Arguments]    ${first_variable}    ${second_variable}     ${msg}=${None}
    Skip If   '${first_variable}' == '${second_variable}'    msg=${msg}
TWI Keyword Test Case Teardown
    [Arguments]    ${keyword}    ${teardown_failed}
    IF  ${teardown_failed} == 0
        ${keyword_passed}    Run keyword and return status    ${keyword}
        IF  not ${keyword_passed}
            TWI Keyword Teardown Failed
        END
    END
TWI Keyword Test Case Setup
    [Arguments]    ${keyword}    ${teardown_failed}
    IF  ${teardown_failed} == 1
        ${keyword_passed}    Run keyword and return status    ${keyword}
        IF  ${keyword_passed}
            TWI Keyword Teardown Passed
        ELSE
            TWI Keyword Test Case Setup Failed After Teardown Fail
        END
    ELSE IF  ${teardown_failed} == 2
        Builtin.Skip
    END
TWI Keyword Start Video Recording
    [Arguments]    ${monitor}    ${name}=${SUITE_NAME}
    # '${SUITE_NAME}' is a variable that returns the current suite name.
    # It replaces the '_' in the name with space and converts the first letter in each word to upper case.
    # The Video recording name always saves with a '1' at the end of it. This is an index incases there is multiple recordings in the same path with the same name.

    # This is to replace the sapces in the name with '_'. For example: If the suite name is 'Accounts Suite 1' it converts it to 'Accounts_Suite_1'.
    ${name}    Replace String    ${name}    ${SPACE}    _
    Run Keyword And Ignore Error    TWI Keyword Stop Video Recording
    ScreenCapLibrary.Start Video Recording    embed=${False}    monitor=${monitor}    name=${name}
    TWI Keyword Sleep    time=1
TWI Keyword Stop Video Recording
    TWI Keyword Sleep    time=1
    ScreenCapLibrary.Stop Video Recording
TWI Keyword Try To Run A Keyword
    [Arguments]    ${keyword}    ${number_of_tries}=3    ${keyword_before_retry}=${None}
    ${number_of_tries_counter}    Set Variable    0
    ${keyword_passed}    Set Variable    ${False}
    WHILE  '${number_of_tries_counter}' < '${number_of_tries}'
         ${keyword_passed}=    Run Keyword And Return Status    ${keyword}
         IF  ${keyword_passed}
             RETURN
         ELSE
             ${number_of_tries_counter}=    Evaluate    ${number_of_tries_counter}+1
             IF  '${number_of_tries_counter}' >= '${number_of_tries}'
                 TWI Keyword Fail    message=The keyword '${keyword}' didn't pass after ${number_of_tries} tries.
             END
        END
        IF  '${keyword_before_retry}' != '${None}'
            Run Keyword    ${keyword_before_retry}
        END
    END
TWI Keyword Delete File
    [Arguments]    ${file_path}
    CommLib.Delete File    file_path=${file_path}
TWI Keyword Wait Until File Is In The Path
    [Arguments]    ${file_path}    ${int_timeout_sec}=60
    TWI Keyword Log To Console       message=Wait Until File Is In The Path '${file_path}'.
    ${float_timeout_sec}=    TWI Keyword Calculate Timeout Time    timeout_time_sec=${int_timeout_sec}
    ${file_exist}    Set Variable    ${False}
    WHILE  not ${file_exist}
        ${file_exist}    Check If File Exists    file_path=${file_path}
        IF  ${file_exist}
            RETURN
        END
        ${current_time_sec}=    TWI Keyword Get Current Time
        IF  ${current_time_sec} > ${float_timeout_sec}
            TWI Keyword Fail    message=File didn't appear in the path '${file_path}' in ${int_timeout_sec} seconds!
        END
        TWI Keyword Sleep    1
    END
TWI Keyword Press Keys
    [Arguments]    ${key}    ${press_count}=1    ${interval}=0
    TWI Keyword Log To Console       message=Press Key ${key} ${press_count} times.
    PyWindowsGuiLibrary.Press Keys    keys=${key}    press_count=${press_count}    interval=${interval}
TWI Keyword Get User Name
    ${user_name}    Get User Name
    ${user_name_length}    Get Length    ${user_name}
    ${last_char_index}    Evaluate    ${user_name_length}-2
    RETURN    ${user_name}[0:${last_char_index}]
TWI Keyword Check If Keyword Status Does Not Change During A Given Time
    [Arguments]    ${keyword}    ${value_to_compare_to}    ${time_without_change}
    IF  '${value_to_compare_to}' == '1'
        ${ready_to_check}    Set Variable    0
    ELSE IF  '${value_to_compare_to}' == '0'
        ${ready_to_check}    Set Variable    1
    END
    ${float_timeout_sec}=    TWI Keyword Calculate Timeout Time    timeout_time_sec=${time_without_change}
    WHILE  '${ready_to_check}' != '${value_to_compare_to}'    limit=NONE
        ${ready_to_check}    Run Keyword    ${keyword}
        IF  '${ready_to_check}' == '${value_to_compare_to}'
            ${current_time}    Get Current Time
            ${finished_writing_time}    Evaluate    ${current_time} + ${float_timeout_sec}
            WHILE  '${ready_to_check}' == '${value_to_compare_to}'
                TWI Keyword Log To Console    message=Waiting
                ${ready_to_check}    Run Keyword    ${keyword}
                ${current_time}    Get Current Time
                IF  ${current_time} > ${float_timeout_sec}
                     TWI Keyword Log To Console    message=RETURN True
                     RETURN    ${True}    ${None}
                END
            END
            TWI Keyword Log To Console    message=RETURN False
            ${no_change_time}    Evaluate    ${time_without_change}-(${float_timeout_sec}-${current_time})
#            ${no_change_time}    Convert To Integer    ${no_change_time}
            RETURN    ${False}    ${no_change_time}
        END
    END
TWI Keyword Find Index Of Item In List
    [Arguments]    ${element}    @{items}
    ${index} =    Set Variable    ${0}
    FOR    ${item}    IN    @{items}
        Run Keyword If    '${item}' == '${element}'    Return From Keyword    ${index}
        ${index} =    Set Variable    ${index + 1}
    END
Remove The First Character Of Text If It Was Space
    [Arguments]    ${text}
    ${first_character} =    Get Substring    ${text}    0    1
    IF    '${first_character}' == ' ' or '${first_character}' =='‎'
         ${text}    Get Substring    ${text}     1
    END
    RETURN  ${text}
TWI Keyword CMD Window Run
    [Arguments]    ${command}
    ${return}    OperatingSystem.Run    command=${command}
    RETURN    ${return}
TWI Keyword Ask Yes Or No Question
    [Arguments]    ${question}
    ${return}    Ask Yes Or No Question   message=${question}
    RETURN    ${return}

TWI Keyword Generate Random Numbers
    [Arguments]    ${digit_count}=8
    ${number} =  Generate Random String  ${digit_count}  [NUMBERS]
    [Return]    ${number}

TWI Keyword Enter Email
    [Arguments]     ${email}        ${locator}      ${timeout}=20
    TWI Keyword Log To Console       message=${email}.
    AppiumLibrary.Wait Until Page Contains Element     locator=${locator}       timeout=${timeout}
    AppiumLibrary.Click Element                        locator=${locator}
    AppiumLibrary.Clear Text                           locator=${locator}
    AppiumLibrary.Input Text                           locator=${locator}       text=${email}
    Run Keyword And Ignore Error    TWI Keyword Hide Keyboard

TWI Keyword Enter Password
    [Arguments]     ${password}        ${locator}      ${timeout}=20
    AppiumLibrary.Wait Until Page Contains Element     locator=${locator}       timeout=${timeout}
    AppiumLibrary.Click Element                        locator=${locator}
    AppiumLibrary.Clear Text                           locator=${locator}
    AppiumLibrary.Input Text                           locator=${locator}       text=${password}
    Run Keyword And Ignore Error    TWI Keyword Hide Keyboard

TWI Keyword Get Element Attribute
    [Arguments]     ${locator}        ${attribute}
    ${Element_attribute}    Appiumlibrary.Get Element Attribute     locator=${locator}        attribute=${attribute}
    RETURN  ${Element_attribute}

TWI Keyword Lock Phone
    [Arguments]     ${time}
    Appiumlibrary.Lock         seconds=${time}