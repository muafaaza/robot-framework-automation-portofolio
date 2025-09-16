*** Settings ***
Library    RequestsLibrary
Variables    ../resource/variable/variable_api.py
Library    ../function/GlobalReport.py

*** Variables ***
${BASE_URL}           https://reqres.in
${LOGIN_ENDPOINT}     /api/login
${REGISTER_ENDPOINT}     /api/register
${API_KEY}            reqres-free-v1
${APPLICATION}        application/json 

*** Keywords ***
Login
    Create Session    login    ${BASE_URL}
    
    &{headers}=    Create Dictionary    Content-Type=${APPLICATION}    x-api-key=${API_KEY}

    &{body}=    Create Dictionary    email=${username}    password=${password}

    # hit (post on session -> ini buat hit yg pasti berhasil (200))
    ${response}=    POST On Session    login    ${LOGIN_ENDPOINT}    json=${body}    headers=${headers}

    # validasi respon harus 200 (dari variable ${reason} cek respon cari status_code)
    TRY
        Should Be Equal As Integers    ${response.status_code}    200
        Status    5    PASSED
    EXCEPT
        Status    5    FAILED
        Pass Execution    status code: ${response.status_code}
    END

    # ambil token dari respon jadiin variable (dari variable ${reason} cek respon cari json()['token'])
    ${token}=    Set Variable    ${response.json()['token']}
    Set Suite Variable    ${token}

Login false username
    Create Session    login    ${BASE_URL}

    &{headers}=    Create Dictionary    Content-Type=${APPLICATION}    x-api-key=${API_KEY}
    
    &{body}=    Create Dictionary    email=${username_false}    password=${password}

    # hit (post request -> apapun responnya pasti passed (200,400,500))
    ${response}=    Post Request    login    ${LOGIN_ENDPOINT}    json=${body}    headers=${headers}

    TRY
        Should Be Equal As Integers    ${response.status_code}    400
        Status    6    PASSED
    EXCEPT
        Status    6    FAILED
        Pass Execution    status code: ${response.status_code}
    END    
