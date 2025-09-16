*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${link}    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${browser}    chrome
${browser_head_less}    headlesschrome
    
*** Keywords ***
Open OrangeHRM Web
    Open Browser    ${link}    ${browser}

Open OrangeHRM Web chromeless
    Open Browser    ${link}    ${browser_head_less}

Close OrangeHRM Web
    Close Browser