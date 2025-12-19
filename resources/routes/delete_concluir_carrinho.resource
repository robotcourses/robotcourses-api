*** Settings ***
Library    RequestsLibrary
Variables  ../connections/app_conn.yaml

*** Keywords ***
DELETE Concluir Compra
    [Arguments]    ${expected_status}=200
    
    ${response}  DELETE On Session
    ...  alias=${serve_rest.alias}
    ...  url=/carrinhos/concluir-compra
    ...  expected_status=${expected_status}
    
    RETURN    ${response}


Assert DELETE Concluir Compra
    [Arguments]    ${response}    ${message}

    Should Be Equal    ${response.json()['message']}    ${message}