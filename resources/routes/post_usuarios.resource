*** Settings ***
Library     RequestsLibrary
Library     ../contracts/
Resource    ../data/user_data.resource
Variables   ../connections/app_conn.yaml

*** Keywords ***
POST Usuarios
    [Arguments]    
    ...  ${nome}=${user_name}  
    ...  ${email}=${user_email}  
    ...  ${password}=${user_password}  
    ...  ${administrador}=${user_adminstrador}  
    ...  ${expected_status}=201

    ${body}    Contract Post Usuarios    
    ...    ${nome}     
    ...    ${email}    
    ...    ${password}    
    ...    ${administrador}

    ${response}  POST On Session
    ...  alias=${serve_rest.alias}
    ...  url=/usuarios
    ...  json=${body}
    ...  expected_status=${expected_status}
    
    RETURN    ${response}

Assert POST Usuarios
    [Arguments]    ${response}    ${message}

    IF    ${response.status_code} == ${201}
        Should Be Equal    ${response.json()['message']}    ${message}
        Should Not Be Empty    ${response.json()['_id']}
    ELSE IF    ${response.status_code} == ${400}
        Should Be Equal    ${response.json()['message']}    ${message}
    END