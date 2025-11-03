*** Settings ***
Library    Browser
Resource    ../keywords/keywords_web.robot
Resource    ../setup/setup_web.robot

*** Test Cases ***
User Login Web
    [Tags]    login-web
    given Open OrangeHRM Web
    when Enter Username
    and Enter Password
    and Click Login
    then Validate Login Success
    and Close OrangeHRM Web

User Login (false username) Web
    [Tags]    login-false-username-web
    given Open OrangeHRM Web chromeless
    when Enter Password
    and Enter False Username
    and Click Login
    and Close OrangeHRM Web

User Login (false password) Web
    [Tags]    login-false-passsword-web
    given Open OrangeHRM Web chromeless
    when Enter Username
    and Enter False Password
    and Click Login
    and Close OrangeHRM Web
