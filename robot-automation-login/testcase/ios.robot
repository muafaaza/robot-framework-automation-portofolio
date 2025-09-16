*** Settings ***
Library    AppiumLibrary
Resource    ../keywords/keywords_ios.robot
Resource    ../setup/setup_ios.robot

*** Test Cases ***
User Login Ios
    [Tags]    login-ios
    given Open Swag Labs Apps IOS
    when Enter Username
    and Enter Password
    and Click Login
    then Validate Login Successs
    and Close Swag Labs Apps IOS

User Login (false username) Ios
    [Tags]    login-false-username-ios
    given Open Swag Labs Apps IOS
    when Enter False Username
    and Enter Password
    and Click Login
    then Close Swag Labs Apps IOS

User Login (false password) Ios
    [Tags]    login-false-passsword-ios
    given Open Swag Labs Apps IOS
    when Enter Username
    and Enter False Password
    and Click Login
    then Close Swag Labs Apps IOS