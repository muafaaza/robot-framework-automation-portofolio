*** Settings ***
Library           AppiumLibrary
Library           XML

*** Variables ***
${APPIUM_SERVER_URL}           http://127.0.0.1:4723
${PLATFORM_NAME}               Android
${DEVICE_NAME}                 emulator-5554
${AUTOMATION_NAME}             UiAutomator2
${APP_PACKAGE}                 com.swaglabsmobileapp
${APP_ACTIVITY}                .MainActivity
${WDA_PORT}                    8100


*** Keywords ***
Open Swag Labs Apps Android
    Open Application    ${APPIUM_SERVER_URL}    platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    automationName=${AUTOMATION_NAME}    appActivity=${APP_ACTIVITY}    noReset=true    wdaLocalPort=${WDA_PORT}
    Sleep    2s

Close Swag Labs Apps Android
    Terminate Application    ${APP_PACKAGE}


## cek app package & app activity pake ini di terminal ' adb shell dumpsys window | grep mCurrentFocus '
## cek device android name pake ini di terminal ' adb devices '
