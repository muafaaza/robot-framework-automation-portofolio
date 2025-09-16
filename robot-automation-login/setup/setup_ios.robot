*** Settings ***
Library           AppiumLibrary
Library           XML

*** Variables ***
${APPIUM_SERVER_URL}    http://127.0.0.1:4724
${PLATFORM_VERSION}     18.4
${DEVICE_NAME}          iphone
${WDA_PORT}             8101
${PLATFORM_NAME}        iOS
${AUTOMATION_NAME}      XCUITest
${APP_IDENTIFIER}       com.saucelabs.SwagLabsMobileApp

*** Keywords ***
Open Swag Labs Apps IOS
    Open Application    ${APPIUM_SERVER_URL}    platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    bundleId=${APP_IDENTIFIER}    automationName=${AUTOMATION_NAME}    noReset=true    wdaLocalPort=${WDA_PORT}
    Sleep    2s

Close Swag Labs Apps IOS
    Terminate Application    ${APP_IDENTIFIER}



## cek app package pake ini di terminal ' xcrun simctl listapps booted | grep CFBundleIdentifier '

## kalo mau runnning di lebih dari satu device (simulator / real device) 
## harus bikin 2 server appium dan 2 port yang berbeda buat web driver agentnya
# nyalain appiumnya 2
# ios : appium -p 4724
# android : appium -p 4723

