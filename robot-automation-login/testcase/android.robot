*** Settings ***
Library    AppiumLibrary
Resource    ../keywords/keywords_android.robot
Resource    ../setup/setup_android.robot

*** Test Cases ***
User Login Android
    [Tags]    login-android
    given Open Swag Labs Apps Android
    when Enter Username
    and Enter Password
    and Click Login
    then Validate Login Successs
    and Close Swag Labs Apps Android

User Login (false username) Android
    [Tags]    login-false-username-android
    given Open Swag Labs Apps Android
    when Enter False Username
    and Enter Password
    and Click Login
    then Close Swag Labs Apps Android

User Login (false password) Android
    [Tags]    login-false-passsword-android
    given Open Swag Labs Apps Android
    when Enter Username
    and Enter False Password
    and Click Login
    then Close Swag Labs Apps Android