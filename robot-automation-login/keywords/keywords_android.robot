*** Settings ***
Library    AppiumLibrary
Resource    ../resource/locator/locator_android.robot
Variables    ../resource/variable/variable_mobile.py
Resource    ../function/GlobalMobile.robot

*** Keywords ***
Enter Username
    Update Status excel    ${TEXT_USERNAME}    10
    Wait Until Element Is Visible    ${TEXT_USERNAME}    timeout=100s
    Click Element    ${TEXT_USERNAME}
    Input Text    ${TEXT_USERNAME}    ${username}

Enter Password
    Update Status excel    ${TEXT_PASSWORD}    10
    Wait Until Element Is Visible    ${TEXT_PASSWORD}    timeout=100s
    Click Element    ${TEXT_PASSWORD}
    Input Text    ${TEXT_PASSWORD}    ${password}

Click Login
    Wait Until Element Is Visible    ${BUTTON_LOGIN}    timeout=100s
    Click Element    ${BUTTON_LOGIN}

Validate Login Successs
    Update Status excel    ${MENU}    10
    Wait Until Element Is Visible    ${MENU}    timeout=100s

Enter False Username
    Update Status excel    ${TEXT_USERNAME}    11
    Wait Until Element Is Visible    ${TEXT_USERNAME}    timeout=100s
    Click Element    ${TEXT_USERNAME}
    Input Text    ${TEXT_USERNAME}    ${username_false}

Enter False Password
    Update Status excel    ${TEXT_PASSWORD}    12
    Wait Until Element Is Visible    ${TEXT_PASSWORD}    timeout=100s
    Click Element    ${TEXT_PASSWORD}
    Input Text    ${TEXT_PASSWORD}    ${password_false}