*** Settings ***
Library    Browser
Resource   ../resource/locator/locator_web.robot
Variables  ../resource/variable/variable_web.py

*** Keywords ***
Enter Username
    Fill Text    ${TEXT_USERNAME}    ${username}

Enter Password
    Fill Text    ${TEXT_PASSWORD}    ${password}
    
Click Login
    Click    ${BUTTON_LOGIN}

Validate Login Success
    Wait For Elements State    ${MENU}    visible    timeout=5s   # optional buat validasi

Enter False Username
    Fill Text    ${TEXT_USERNAME}    ${username_false}

Enter False Password
    Fill Text    ${TEXT_PASSWORD}    ${password_false}
