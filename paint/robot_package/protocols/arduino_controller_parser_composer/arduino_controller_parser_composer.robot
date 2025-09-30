*** Settings ***
Resource    ../../Protocols/twi_serial_protocol/twi_serial_library.robot
Resource    ../../common/keywords/common_keywords.robot
*** Keywords ***
TWI Keyword Open Arduino Port
    [Arguments]    ${arduino_port}    ${encoding}=ascii    ${baud_rate}=115200    ${timeout}=10
    TWI Keyword Open Port    port_number=${arduino_port}    encoding=${encoding}    baud_rate=${baud_rate}    timeout=${timeout}
    TWI Keyword Sleep    5
TWI Keyword Close Arduino Port
    [Arguments]    ${arduino_port}
    TWI Keyword Close Port    port_number=${arduino_port}
TWI Keyword Set Arduino Pin
    [Arguments]    ${arduino_port}    ${pin}    ${value}
    TWI Keyword Write Byte    port_number=${arduino_port}    data=S${pin}=${value}    encoding=ascii
TWI Keyword Get Pin Arduino Status
    [Arguments]    ${arduino_port}    ${pin}   ${timeout}=60
    ${float_timeout_sec}=    TWI Keyword Calculate Timeout Time    timeout_time_sec=${timeout}
    WHILE    1    limit=NONE
        TWI Keyword Reset Buffers    port_number=${arduino_port}
        TWI Keyword Write Byte    port_number=${arduino_port}    data=G${pin}    encoding=ascii
        ${pin_status}    TWI Keyword Wait To Recieve Data    port_number=${arduino_port}    terminator=!
        IF  '${pin_status}[0:4]' == 'G${pin}='
            IF  '${pin_status}[4:5]' == '0'
                RETURN    ${pin_status}[4:5]
            ELSE IF  '${pin_status}[4:5]' == '1'
                RETURN    ${pin_status}[4:5]
            ELSE
                TWI Keyword Log To Console        message=Received an invalid pin state '${pin_status}[4:5]'!
            END
        ELSE
            TWI Keyword Log To Console        message=Received an invalid get message '${pin_status}'!
        END
        ${current_time_sec}=    TWI Keyword Get Current Time
        IF    ${current_time_sec} > ${float_timeout_sec}
             TWI Keyword Fail    message=Timed out while trying to get pin status!.
        END
    END
TWI Keyword Send I2C Buffer
    [Arguments]    ${arduino_port}    ${buffer}    ${wait_for_ack}=0   ${timeout}=60
    IF  '${wait_for_ack}' == '1'
        ${float_timeout_sec}=    TWI Keyword Calculate Timeout Time    timeout_time_sec=${timeout}
        WHILE    1    limit=NONE
            TWI Keyword Reset Buffers    port_number=${arduino_port}
            ${message}    Set Variable    ${None}
            TWI Keyword Write Byte    port_number=${arduino_port}    data=I1${buffer}    encoding=ascii
            TWI Keyword Log To Console    message=Waiting for ACk!
            ${message}    TWI Keyword Wait To Recieve Data    port_number=${arduino_port}    terminator=!
            IF  '${message}' == 'done!'
                RETURN
            ELSE IF  '${message}' != 'done!'
                 TWI Keyword Log To Console       message=UART Failure! Didn't receive 'done!' got '${None}' instead.
            END
            ${current_time_sec}=    TWI Keyword Get Current Time
            IF    ${current_time_sec} > ${float_timeout_sec}
                 TWI Keyword Fail    message=Timed out while trying to send I2C buffer!.
            END
        END
    ELSE
        TWI Keyword Write Byte    port_number=${arduino_port}    data=I0${buffer}    encoding=ascii
    END
#    TWI Keyword Write Byte    port_number=${arduino_port}    data=I0${buffer}    encoding=ascii
