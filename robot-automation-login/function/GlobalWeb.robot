*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    GlobalReport.py

*** Keywords ***
Update Status excel
    [Arguments]    ${element_visible}    ${row}
    ${page_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${element_visible}    timeout=50s
    IF    ${page_visible}
        ${a}=    Set Variable    PASSED
        Status    ${row}    ${a}

    ELSE
        ${a}=    Set Variable    FAILED
        Status    ${row}    ${a}

    END