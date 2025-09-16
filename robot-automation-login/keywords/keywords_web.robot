*** Settings ***
Library    SeleniumLibrary
Resource    ../resource/locator/locator_web.robot
Variables    ../resource/variable/variable_web.py
Resource    ../function/GlobalWeb.robot

*** Keywords ***
Enter Username
    Update Status excel    ${TEXT_USERNAME}    2
    Wait Until Element Is Visible    ${TEXT_USERNAME}    timeout=100s
    Input Text    ${TEXT_USERNAME}    ${username}

Enter Password
    Update Status excel    ${TEXT_PASSWORD}    2
    Wait Until Element Is Visible    ${TEXT_PASSWORD}    timeout=100s
    Input Text    ${TEXT_PASSWORD}    ${password}
    
Click Login
    Update Status excel    ${BUTTON_LOGIN}    2
    Wait Until Element Is Visible    ${BUTTON_LOGIN}    timeout=100s
    Click Element    ${BUTTON_LOGIN}

Validate Login Successs
    Update Status excel    ${MENU}    2
    Wait Until Element Is Visible    ${MENU}    timeout=5s

Enter False Username
    Update Status excel    ${TEXT_USERNAME}    3
    Wait Until Element Is Visible    ${TEXT_USERNAME}    timeout=100s
    Input Text    ${TEXT_USERNAME}    ${username_false}

Enter False Password
    Update Status excel    ${TEXT_PASSWORD}    4
    Wait Until Element Is Visible    ${TEXT_PASSWORD}    timeout=100s
    Input Text    ${TEXT_PASSWORD}    ${password_false}