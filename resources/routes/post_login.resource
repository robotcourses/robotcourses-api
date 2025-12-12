*** Settings ***
Library    RequestsLibrary
Library     ../contracts/
Resource    ../data/user_data.resource
Variables   ../connections/app_conn.yaml

*** Keywords ***
POST Login
    [Arguments]    ${login_email}=${user_email}    ${login_password}=${user_password}    ${expected_status}=200

    ${body}  Contract Post Login    ${login_email}    ${login_password}

    ${response}  POST On Session
    ...  alias=${serve_rest.alias}
    ...  url=/login
    ...  json=${body}
    ...  expected_status=${expected_status}
    
    IF    ${response.status_code} == ${200}
        ${header}  Create Dictionary   Authorization=${response.json()['authorization']}

        Update Session    ${serve_rest.alias}
        ...  headers=${header} 
    END

    RETURN  ${response}

Assert POST Login
    [Arguments]    ${response}    ${message}

    Should Be Equal    ${response.json()['message']}    ${message}

    IF    ${response.status_code} == ${200}
        Should Not Be Empty    ${response.json()['authorization']}
    END