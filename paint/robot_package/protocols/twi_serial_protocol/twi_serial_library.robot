*** Settings ***
Library    Collections
Library    SerialLibrary
Resource    ../../common/keywords/common_keywords.robot
*** Keywords ***
TWI Keyword Set Port Configurations
   [Documentation]      Sets configurations(port_number,baud_rate,Encoding) for the port
   ...                defualt values for port locator and encding is None
   ...                and default value for baud_rate is 9600
   ...                returns none
   ...
   #this keyword set configurations for specific port take arguments-> (port_number ,baud_rate and encoding type
   [Arguments]     ${port_number}  ${baud_rate}=${None}     ${encoding}=${None}
   Set Port Parameter    baudrate    ${baud_rate}   port locator=${port_number}
   Set Encoding    encoding=${encoding}
TWI Keyword Open Port
     [Documentation]     Sets configurations(port_number,baud_rate,encoding and Timeout)
    ...                  And Opens passed port
    ...
    ...
    ...                returns all Configurations for opened port
    ...
    [Arguments]     ${port_number}    ${encoding}    ${baud_rate}    ${timeout}
    ${value}=    Add Port    port_locator=${port_number}   timeout=${timeout}
    Port Should Be Open   ${port_number}
    Set Port Parameter    baudrate    ${baud_rate}   port_locator=${port_number}
    Set Encoding    encoding=${encoding}
    [Return]  ${value}
TWI Keyword Write Byte
     [Documentation]
    ...         TWI Keyword KeyWord ,It writes  ONE Byte on the serial port
    ...         paramaters: Data            -> paramarter will hold the data to be sent
    ...                     port_number     -> which port will write the data on
    ...                     encoding        -> encoding type (ascii,utf-8)
    ...                     Number of Bytes -> number of bytes will be send
    ...         Returns none

    [Arguments]     ${data}      ${port_number}        ${encoding}=${None}
    Write Data    data=${data}    encoding=${encoding}   port_locator=${port_number}
TWI Keyword Write Bytes
     [Documentation]
    ...         TWI Keyword KeyWord ,It writes Number of Bytes on the serial port
    ...         paramaters: Data            -> paramarter will hold the data to be sent
    ...                     port_number     -> which port will write the data on
    ...                     Number of Bytes -> number of bytes will be send
    ...                     encoding        -> encoding type (ascii,utf-8)
    ...         Returns none
    [Arguments]     @{list}      ${port_number}    ${number_of_bytes}       ${encoding}=${None}
    FOR    ${counter}    IN RANGE    0    ${number_of_bytes}
        ${listvalue}=    Get From List    list=@{list}    index=${counter}
        TWI Keyword Write Byte  Data= ${listvalue}  port_number=${port_number}      encoding=${encoding}
    END
    #FOR    ${robot}    IN    @{ROBOTS}
    #   TWI Keyword Write Byte  Data=${robot}    port_number=${port_number}      encoding=${encoding}
    #   Log To Console    robot=${robot}
    #END
TWI Keyword read Bytes
     [Documentation]    TWI Keyword KeyWord ,It reads Number of Bytes on the serial port untill detect passed terminator or passed size
    ...         paramaters: port_number     -> which port will write the data on
    ...                     size            -> number of bytes will be recieved
    ...                     encoding        -> encoding type (ascii,utf-8)
    ...                     terminator      -> reading is terminated when found in recieved bytes
    ...         returns readed data
    [Arguments]    ${port_number}   ${size}=${None}      ${encoding}=ascii     ${terminator}=${None}     ${terminator_encoding}=ascii    ${timeout}=${None}
    ${data} =    Read Until     terminator=${terminator}
                        ...    terminator_encoding=${terminator_encoding}
                        ...    port_locator=${port_number}
                        ...    size=${size}
                        ...    encoding=${encoding}
                        ...    timeout=${timeout}
    [Return]    ${data}
TWI Keyword Close Port
    [Documentation]   Deletes (Closes) passed port
    [Arguments]    ${port_number}
    Delete Port   ${port_number}
TWI Keyword Reset Buffers
    [Arguments]    ${port_number}
    TWI Keyword Flush Port    port_number=${port_number}
    TWI Keyword Reset Input Buffer    port_number=${port_number}
    TWI Keyword Reset Output Buffer    port_number=${port_number}
    TWI Keyword Read All data    port_number=${port_number}
TWI Keyword Flush Port
    [Arguments]    ${port_number}
    Flush Port    port_locator=${port_number}
TWI Keyword Wait To Recieve Data
    [Arguments]    ${port_number}    ${data_size}=${None}    ${terminator}=${None}   ${timeout}=60
    ${float_timeout_sec}=    TWI Keyword Calculate Timeout Time    timeout_time_sec=${timeout}
    ${message}    Set Variable    ${EMPTY}
    WHILE  '${message}' == '${EMPTY}'
        ${message}    TWI Keyword read Bytes   port_number=${port_number}    terminator=${terminator}    size=${data_size}
        ${current_time_sec}=    TWI Keyword Get Current Time
        IF    ${current_time_sec} > ${float_timeout_sec}
             TWI Keyword Fail    message=Timed out while waiting for UART message!.
        END
    END
    TWI Keyword Reset Buffers    port_number=${port_number}
    RETURN    ${message}
TWI Keyword Read All data
    [Arguments]    ${port_number}   ${encoding}=ascii
    ${all_data}    Read All Data    encoding=${encoding}    port_locator=${port_number}
    RETURN    ${all_data}
TWI Keyword Reset Input Buffer
    [Arguments]    ${port_number}
    Reset Input Buffer    port_locator=${port_number}
TWI Keyword Reset Output Buffer
    [Arguments]    ${port_number}
    Reset Output Buffer    port_locator=${port_number}