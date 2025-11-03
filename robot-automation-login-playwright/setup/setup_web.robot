*** Settings ***
Library    Browser

*** Variables ***
${link}    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${browser}    chromium

*** Keywords ***
Open OrangeHRM Web
    New Browser    ${browser}    headless=False
    Set Browser Timeout    30s
    New Page       ${link}
    Wait Until Network Is Idle    timeout=10s
    
Open OrangeHRM Web chromeless
    New Browser    ${browser}    headless=True
    Set Browser Timeout    30s
    New Page       ${link}
    Wait Until Network Is Idle    timeout=10s

Close OrangeHRM Web
    Close Browser

