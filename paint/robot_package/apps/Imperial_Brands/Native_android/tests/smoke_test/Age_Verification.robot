*** Settings ***
Resource          ../../resources/keywords/native_imbr_android_keywords.resource

Suite Setup      TWI Keyword IMBR Suite Setup

Test Setup        TWI Keyword IMBR Test Setup

*** Variables ***

${REGISTER_USERNAME}    Test
${REGISTER_PASSWORD}    12345678
${VALID_USERNAME}       mahmoud
${VALID_PASSWORD}       12345678
${INVALID_USERNAME}     abcdefghi
${INVALID_PASSWORD}     123456999

*** Test Cases ***

TWI Test Verify Login Fails With Invalid Username And Invalid Password
    [Tags]      IT-TC-813
    TWI Keyword IMBR Fill Login Form        email=${INVALID_USERNAME}          password=${VALID_PASSWORD}
    TWI Keyword IMBR Verify Invalid Username And Password

TWI Test Verify Login Fails With Valid Username And Invalid Password
    [Tags]      IT-TC-814
    TWI Keyword IMBR Fill Login Form        email=${VALID_USERNAME}          password=${INVALID_PASSWORD}
    TWI Keyword IMBR Verify Valid Username And Invalid Password

TWI Test Verify Registration Works Correctly
    [Tags]      IT-TC-826   IT-TC-827
    TWI Keyword IMBR Fill Login Form        email=${VALID_USERNAME}          password=${VALID_PASSWORD}
    TWI Keyword IMBR Verify app Logedin

TWI Test Reject Camera Permission Then Try Again
    [Tags]      IT-TC-759
    TWI Keyword IMBR Fill Login Form        email=${VALID_USERNAME}          password=${VALID_PASSWORD}
    TWI Keyword IMBR Login Steps
    TWI Keyword IMBR Reject Camera Permission

TWI Test Age Verification Functionality successfully
    [Tags]      IT-TC-758
    ${register_name}=   TWI Keyword IMBR Signup Steps       ${REGISTER_USERNAME}
    TWI Keyword IMBR Fill Signup Form       username=${register_name}      password=${REGISTER_PASSWORD}        timeout=25
    TWI Keyword IMBR Wait For Sign up Continue Button And Click It
    TWI Keyword IMBR Fill Login Form     email=${register_name}      password=${REGISTER_PASSWORD}
    TWI Keyword IMBR Wait For Privacy Page And Click I Understand
    TWI Keyword IMBR Wait For Take a Selfie Page And Click Continue
    TWI Keyword IMBR Wait For Camera Page
