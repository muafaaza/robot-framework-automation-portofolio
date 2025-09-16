*** Settings ***
Library    RequestsLibrary
Resource    ../keywords/keyword_api.robot

*** Test Cases ***
User Login Api
    [Tags]    login-api
    Login

User Login (false username) Api
    [Tags]    login-false-username-api
    Login false username