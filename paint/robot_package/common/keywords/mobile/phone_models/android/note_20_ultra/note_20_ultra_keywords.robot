*** Settings ***
Resource    ../../../mobile_common_keywords.robot
Resource    note_20_ultra_locators.robot
*** Variables ***
${PHONE_MODEL}    note_20_ultra
${USB_DEVICE_NAME}     R5CNA04SNCT
${PLATFORM_NAME}    Android
${AUTOMATION_NAME}    UIAutomator2
${WEBSITE_WWW}    www.
*** Keywords ***
TWI Keyword BLE Unpair Device From Phone
   [Arguments]    ${device_name}
   TWI Keyword Open Drop Down menu
   TWI Keyword Appium Long Press    locator=//android.view.ViewGroup[@content-desc="Bluetooth,On.,Button"]/android.widget.ImageView    locator_type=xpath
   ${device_is_paired}=    Run Keyword And Return Status    TWI Keyword Appium Wait Until Page Contains Element    locator=‎${device_name}‎, Device settings    locator_type=accessibility_id    timeout=10
   IF  ${device_is_paired}
       TWI Keyword Appium Wait For Element And Click    locator=‎${device_name}‎, Device settings    locator_type=accessibility_id
       TWI Keyword Appium Wait For Element And Click    locator=com.android.settings:id/unpair_button
   END
   TWI Keyword Appium Wait For Element And Click    locator=Navigate up    locator_type=accessibility_id
   TWI Keyword Appium Wait For Element And Click    locator=Navigate up    locator_type=accessibility_id
   TWI Keyword Appium Press Keycode    4
TWI Keyword Open Drop Down menu
    TWI Keyword Appium Swipe    500    0    0    1300    duration=200
    TWI Keyword Appium Swipe    500    0    0    1300    duration=200
    TWI Keyword Appium Swipe    500    0    0    1300    duration=200
    TWI Keyword Sleep    time=1
TWI Keyword Close Drop Down menu
    TWI Keyword Appium Press Keycode    keycode=4
    TWI Keyword Appium Wait Until Page Does Not Contain Element    locator=com.android.systemui:id/power_button
    TWI Keyword Appium Press Keycode    keycode=4
    TWI Keyword Appium Wait Until Page Does Not Contain Element    locator=com.android.systemui:id/qs_button_container
TWI Keyword Turn On BLE
   TWI Keyword Open Drop Down menu
   ${ble_was_off}=    Run Keyword And Return Status    TWI Keyword Appium Wait For Element And Click    locator=//android.view.ViewGroup[@content-desc="Bluetooth,Off.,Button"]/android.widget.ImageView    locator_type=xpath
   IF    ${ble_was_off}
        TWI Keyword Appium Wait For Element And Click    locator=android:id/button1
        TWI Keyword Appium Wait Until Page Does Not Contain Element    locator=com.android.systemui:id/qs_button_container
   ELSE
        TWI Keyword Close Drop Down menu
   END
TWI Keyword Turn Off BLE
   TWI Keyword Open Drop Down menu
   Run Keyword And Ignore Error    TWI Keyword Appium Wait For Element And Click    locator=//android.view.ViewGroup[@content-desc="Bluetooth,On.,Button"]/android.widget.ImageView    locator_type=xpath
   TWI Keyword Close Drop Down menu
TWI Keyword Turn On Location
   TWI Keyword Open Drop Down menu
   Run Keyword And Ignore Error    TWI Keyword Appium Wait For Element And Click    locator=//android.view.ViewGroup[@content-desc="Location,Off.,Button"]/android.widget.ImageView    locator_type=xpath
   TWI Keyword Close Drop Down menu
TWI Keyword Turn Off Location
   TWI Keyword Open Drop Down menu
   ${location_was_on}=    Run Keyword And Return Status    TWI Keyword Appium Wait For Element And Click    locator=//android.view.ViewGroup[@content-desc="Location,On.,Button"]/android.widget.ImageView    locator_type=xpath
   IF    ${location_was_on}
       ${confirm_msg_appeared}=    Run Keyword And Return Status    TWI Keyword Confirm Turnning Off Location
       IF    not ${confirm_msg_appeared}
           TWI Keyword Close Drop Down menu
       END
   END
TWI Keyword Turn On Mobile Data
   TWI Keyword Open Drop Down menu
   ${data_was_on}=    Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=//android.view.ViewGroup[@content-desc="Mobile,data,On.,Button"]/android.widget.ImageView    locator_type=xpath
   IF    ${data_was_on}
       TWI Keyword Close Drop Down menu
   ELSE
       TWI Keyword Appium Wait For Element And Click    locator=//android.view.ViewGroup[@content-desc="Mobile,data,Off.,Button"]/android.widget.ImageView    locator_type=xpath
       TWI Keyword Close Drop Down menu
   END
TWI Keyword Turn Off Mobile Data
   TWI Keyword Open Drop Down menu
   ${data_was_off}=    Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=//android.view.ViewGroup[@content-desc="Mobile,data,Off.,Button"]/android.widget.ImageView    locator_type=xpath
   IF    ${data_was_off}
       TWI Keyword Close Drop Down menu
   ELSE
       TWI Keyword Appium Wait For Element And Click    locator=//android.view.ViewGroup[@content-desc="Mobile,data,On.,Button"]/android.widget.ImageView    locator_type=xpath
       TWI Keyword Close Drop Down menu
   END
TWI Keyword Allow The App To Access Location While Using The App
    TWI Keyword Appium Wait For Element And Click    locator=com.android.permissioncontroller:id/permission_allow_foreground_only_button
TWI Keyword Allow The App To Access Location Only This Time
    TWI Keyword Appium Wait For Element And Click    locator=com.android.permissioncontroller:id/permission_allow_one_time_button
TWI Keyword Deny The App To Access Location
    TWI Keyword Appium Wait For Element And Click    locator=com.android.permissioncontroller:id/permission_deny_button
TWI Keyword Confirm Turnning Off Location
    TWI Keyword Appium Wait For Element And Click    locator=android:id/button2
TWI Keyword Turn On Airplane Mode
    TWI Keyword Open Drop Down menu
    Run Keyword And Ignore Error    TWI Keyword Appium Wait For Element And Click    locator=//android.view.ViewGroup[@content-desc="Airplane,mode,Off.,Button"]/android.widget.ImageView    locator_type=xpath
    TWI Keyword Close Drop Down menu
TWI Keyword Turn Off Airplane Mode
    TWI Keyword Open Drop Down menu
    Run Keyword And Ignore Error    TWI Keyword Appium Wait For Element And Click    locator=//android.view.ViewGroup[@content-desc="Airplane,mode,On.,Button"]/android.widget.ImageView    locator_type=xpath
    TWI Keyword Close Drop Down menu
TWI Keyword Turn On Power Saving Mode
    TWI Keyword Open Drop Down menu
    Run Keyword And Ignore Error    TWI Keyword Appium Wait For Element And Click    locator=//android.view.ViewGroup[@content-desc="Power,saving,Off.,Button"]/android.widget.ImageView    locator_type=xpath
    TWI Keyword Close Drop Down menu
TWI Keyword Turn Off Power Saving Mode
    TWI Keyword Open Drop Down menu
    Run Keyword And Ignore Error    TWI Keyword Appium Wait For Element And Click    locator=//android.view.ViewGroup[@content-desc="Power,saving,On.,Button"]/android.widget.ImageView    locator_type=xpath
    TWI Keyword Close Drop Down menu
TWI Keyword Turn On WIFI
    [Arguments]    ${network_name}
    TWI Keyword Open Drop Down menu
    ${wifi_is_off}    Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,Off.,,Button"]/android.widget.ImageView    locator_type=xpath
    IF  ${wifi_is_off}
        # We have to wait to see if it automatically connects to the desired network.
	    # We tried to directly connect to the desired network but it can miss the click with the nearby networks order changing.
        TWI Keyword Appium Click Element    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,Off.,,Button"]/android.widget.ImageView    locator_type=xpath
        ${connected_to_the_default_network}    Run Keyword And Return Status    TWI Keyword Appium Wait Until Page Contains Element    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,On.,${network_name},Button"]/android.widget.ImageView    locator_type=xpath    timeout=10
        IF  not ${connected_to_the_default_network}
            TWI Keyword Switch WIFI Network    new_network_name=${network_name}
            RETURN
        END
    ELSE
        ${connected_to_the_default_network}    Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element     locator=//android.view.ViewGroup[@content-desc="Wi-Fi,On.,${network_name},Button"]/android.widget.ImageView    locator_type=xpath
        IF  not ${connected_to_the_default_network}
            TWI Keyword Switch WIFI Network    new_network_name=${network_name}
            RETURN
        END
    END
    TWI Keyword Close Drop Down menu
TWI Keyword Turn Off WIFI
    [Arguments]    ${network_name}
    TWI Keyword Open Drop Down menu
    ${connected_to_network}    Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,On.,${network_name},Button"]/android.widget.ImageView    locator_type=xpath
    IF  ${connected_to_network}
        TWI Keyword Appium Wait For Element And Click    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,On.,${network_name},Button"]/android.widget.ImageView    locator_type=xpath
    ELSE
        ${wifi_on}    Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,On.,,Button"]/android.widget.ImageView    locator_type=xpath
        IF    ${wifi_on}
            TWI Keyword Appium Wait For Element And Click    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,On.,,Button"]/android.widget.ImageView    locator_type=xpath
        END
    END
    TWI Keyword Close Drop Down menu
TWI Keyword WIFI Should Be Off
    TWI Keyword Open Drop Down menu
    ${wifi_status}    Run Keyword And Return Status    TWI Keyword Appium Wait Until Page Contains Element    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,Off.,,Button"]/android.widget.ImageView    locator_type=xpath
    TWI Keyword Close Drop Down menu
    RETURN  ${wifi_status}
TWI Keyword BLE Should Be Off
    TWI Keyword Open Drop Down menu
    ${ble_status}    Run Keyword And Return Status    TWI Keyword Appium Wait Until Page Contains Element    locator=//android.view.ViewGroup[@content-desc="Bluetooth,Off.,Button"]/android.widget.ImageView   locator_type=xpath
    TWI Keyword Close Drop Down menu
    RETURN  ${ble_status}
TWI Keyword Turn On/Off Mobile Settings
    [Arguments]    ${BLE}    ${WIFI}    ${power_saving_mode}    ${airplane_mode}    ${location}    ${network_name}
    TWI Keyword Open Drop Down menu
    IF  '${BLE}' != '${None}'
        IF  '${BLE}' == 'on'
            ${ble_was_off}=    Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element And Click     locator=//android.view.ViewGroup[@content-desc="Bluetooth,Off.,Button"]/android.widget.ImageView    locator_type=xpath
            IF  ${ble_was_off}
                TWI Keyword Appium Wait For Element And Click    locator=android:id/button1
                TWI Keyword Appium Wait Until Page Does Not Contain Element    locator=com.android.systemui:id/qs_button_container
                TWI Keyword Open Drop Down menu
            END
        ELSE IF  '${BLE}' == 'off'
            Run Keyword And Ignore Error    TWI Keyword Appium Page Should Contain Element And Click     locator=//android.view.ViewGroup[@content-desc="Bluetooth,On.,Button"]/android.widget.ImageView    locator_type=xpath
        END
    END
    IF  '${WIFI}' != '${None}'
        IF  '${WIFI}' == 'on'
            ${wifi_is_off}    Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,Off.,,Button"]/android.widget.ImageView    locator_type=xpath
            IF  ${wifi_is_off}
                # We have to wait to see if it automatically connects to the desired network.
	            # We tried to directly connect to the desired network but it can miss the click with the nearby networks order changing.
                TWI Keyword Appium Click Element    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,Off.,,Button"]/android.widget.ImageView    locator_type=xpath
                ${connected_to_the_default_network}    Run Keyword And Return Status    TWI Keyword Appium Wait Until Page Contains Element    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,On.,${network_name},Button"]/android.widget.ImageView    locator_type=xpath    timeout=10
                IF  not ${connected_to_the_default_network}
                    TWI Keyword Switch WIFI Network    new_network_name=${network_name}
                    TWI Keyword Open Drop Down menu
                END
            ELSE
                ${connected_to_the_default_network}    Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element     locator=//android.view.ViewGroup[@content-desc="Wi-Fi,On.,${network_name},Button"]/android.widget.ImageView    locator_type=xpath
                IF  not ${connected_to_the_default_network}
                    TWI Keyword Switch WIFI Network    new_network_name=${network_name}
                    TWI Keyword Open Drop Down menu
                END
            END
        ELSE IF  '${WIFI}' == 'off'
            ${connected_to_network}    Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,On.,${network_name},Button"]/android.widget.ImageView    locator_type=xpath
            IF  ${connected_to_network}
                TWI Keyword Appium Page Should Contain Element And Click    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,On.,${network_name},Button"]/android.widget.ImageView    locator_type=xpath
            ELSE
                ${wifi_on}    Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,On.,,Button"]/android.widget.ImageView    locator_type=xpath
                IF    ${wifi_on}
                    TWI Keyword Appium Page Should Contain Element And Click     locator=//android.view.ViewGroup[@content-desc="Wi-Fi,On.,,Button"]/android.widget.ImageView    locator_type=xpath
                END
            END
        END
    END
    IF  '${power_saving_mode}' != '${None}'
        IF  '${power_saving_mode}' == 'on'
            Run Keyword And Ignore Error    TWI Keyword Appium Page Should Contain Element And Click     locator=//android.view.ViewGroup[@content-desc="Power,saving,Off.,Button"]/android.widget.ImageView    locator_type=xpath
        ELSE IF  '${power_saving_mode}' == 'off'
            Run Keyword And Ignore Error    TWI Keyword Appium Page Should Contain Element And Click     locator=//android.view.ViewGroup[@content-desc="Power,saving,On.,Button"]/android.widget.ImageView    locator_type=xpath
        END
    END
    IF  '${airplane_mode}' != '${None}'
        IF  '${airplane_mode}' == 'on'
            Run Keyword And Ignore Error    TWI Keyword Appium Page Should Contain Element And Click     locator=//android.view.ViewGroup[@content-desc="Airplane,mode,Off.,Button"]/android.widget.ImageView    locator_type=xpath
        ELSE IF  '${airplane_mode}' == 'off'
            Run Keyword And Ignore Error    TWI Keyword Appium Page Should Contain Element And Click     locator=//android.view.ViewGroup[@content-desc="Airplane,mode,On.,Button"]/android.widget.ImageView    locator_type=xpath
        END
    END
    IF  '${location}' != '${None}'
        IF  '${location}' == 'on'
            Run Keyword And Ignore Error    TWI Keyword Appium Page Should Contain Element And Click     locator=//android.view.ViewGroup[@content-desc="Location,Off.,Button"]/android.widget.ImageView    locator_type=xpath
        ELSE IF  '${location}' == 'off'
            ${location_was_on}=    Run Keyword And Return Status    TWI Keyword Appium Page Should Contain Element And Click     locator=//android.view.ViewGroup[@content-desc="Location,On.,Button"]/android.widget.ImageView    locator_type=xpath
            IF  ${location_was_on}
                ${confirm_msg_appeared}=    Run Keyword And Return Status    TWI Keyword Confirm Turnning Off Location
                 #Keep it commented unless this if condition changed to it's position from the last position
                 #IF  ${confirm_msg_appeared}
                 #    TWI Keyword Open Drop Down menu
                 #END
            END
        END
    END
    TWI Keyword Close Drop Down menu
TWI Keyword Device Should Be Paired
    [Arguments]    ${device_name}    ${phone_model}
    TWI Keyword Open Drop Down menu
    TWI Keyword Appium Long Press    locator=//android.view.ViewGroup[@content-desc="Bluetooth,On.,Button"]/android.widget.ImageView    locator_type=xpath
    ${device_is_paired}=    Run Keyword And Return Status    TWI Keyword Appium Wait Until Page Contains Element    locator=‎${device_name}‎, Device settings    locator_type=accessibility_id    timeout=10
    TWI Keyword Appium Wait For Element And Click    locator=Navigate up    locator_type=accessibility_id
    TWI Keyword Appium Wait For Element And Click    locator=Navigate up    locator_type=accessibility_id
    TWI Keyword Appium Press Keycode    4
    IF  not ${device_is_paired}
        TWI Keyword Fail    message=Device '${device_name}' is not paired to phone!
    END
TWI Keyword BLE Pair Device With Phone
    [Arguments]    ${device_name}
    TWI Keyword Open Drop Down menu
    TWI Keyword Appium Long Press    locator=//android.view.ViewGroup[@content-desc="Bluetooth,On.,Button"]/android.widget.ImageView    locator_type=xpath
    TWI Keyword Appium Wait For Text And Click    text=${device_name}    timeout=60    platform_name=${PLATFORM_NAME}
    TWI Keyword Appium Wait For Element And Click     locator=android:id/button1
    TWI Keyword Appium Press Keycode    4
TWI Keyword Clear All Apps From Background
    TWI Keyword Appium Press Keycode    187
    ${apps_opened}    Run Keyword And Return Status    TWI Keyword Appium Wait Until Page Contains Element    locator=com.sec.android.app.launcher:id/clear_all_button     timeout=10
    IF  ${apps_opened}
        TWI Keyword Appium Click Element    locator=com.sec.android.app.launcher:id/clear_all_button
        TWI Keyword Appium Wait Until Page Contains Element    locator=com.sec.android.app.launcher:id/page_indicator     timeout=10
    ELSE
        TWI Keyword Appium Press Keycode    187
    END
TWI Keyword Turn Off BLE From Opened Drop Down Menu
    Run Keyword And Ignore Error    TWI Keyword Appium Wait For Element And Click    locator=//android.view.ViewGroup[@content-desc="Bluetooth,On.,Button"]/android.widget.ImageView    locator_type=xpath
TWI Keyword Turn On Do Not Disturb Mode
    TWI Keyword Open Drop Down menu
    ${do_not_disturb_mode_off}=    Run Keyword And Return Status    TWI Keyword Appium Wait Until Page Contains Element    locator=//android.view.ViewGroup[@content-desc="Do not,disturb,Off.,Button"]/android.widget.ImageView    locator_type=xpath
    IF  ${do_not_disturb_mode_off}
        TWI Keyword Appium Click Element    locator=//android.view.ViewGroup[@content-desc="Do not,disturb,Off.,Button"]/android.widget.ImageView    locator_type=xpath
    END
    TWI Keyword Close Drop Down menu
TWI Keyword Turn Off Do Not Disturb Mode
    TWI Keyword Open Drop Down menu
    ${do_not_disturb_mode_on}=    Run Keyword And Return Status    TWI Keyword Appium Wait Until Page Contains Element    locator=//android.view.ViewGroup[@content-desc="Do not,disturb,On.,Button"]/android.widget.ImageView    locator_type=xpath
    IF  ${do_not_disturb_mode_on}
        TWI Keyword Appium Click Element    locator=//android.view.ViewGroup[@content-desc="Do not,disturb,On.,Button"]/android.widget.ImageView    locator_type=xpath
    END
    TWI Keyword Close Drop Down menu
TWI Keyword Open Drop down Menu During Notification
    TWI Keyword Fail    message=Keyword is not handeled for this phone!
TWI Keyword Simulate Home Button
    Appiumlibrary.Execute Script    mobile: pressKey     keycode=3
TWI Keyword Open Background App
    TWI Keyword Log To Console    message=Implement A keyword For This Function
TWI Keyword Click Enter Keycode
    TWI Keyword Appium Press Keycode    160
TWI Keyword Switch WIFI Network
    [Arguments]    ${new_network_name}
    TWI Keyword Open Drop Down menu
    ${connected_network_name}    TWI Keyword Get Connected Network Name
    TWI Keyword Appium Long Press    locator=//android.view.ViewGroup[@content-desc="Wi-Fi,On.,${connected_network_name},Button"]/android.widget.ImageView    locator_type=xpath
    TWI Keyword Appium Click Text    text=${new_network_name}    platform_name=${PLATFORM_NAME}
    TWI Keyword Appium Wait Until Page Contains    text=Connected    platform_name=${PLATFORM_NAME}    timeout=10
    TWI Keyword Appium Press Keycode    4
TWI Keyword Get Connected Network Name
    ${wifi_content_desc}    Get Element Attribute    xpath=//*[contains(@content-desc,"Wi-Fi,On")]    attribute=content-desc
    ${wifi_network_name}    Remove String    ${wifi_content_desc}    Wi-Fi,On.,
    RETURN    ${wifi_network_name}

TWI Keyword Click Back Keycode
    TWI Keyword Appium Press Keycode    4