*** Settings ***
Library     RequestsLibrary
Library     ../contracts/
Library    Collections
Variables   ../connections/app_conn.yaml

*** Keywords ***
POST Carrinhos
    [Arguments]    ${id_produto}    ${quantidade}    ${expected_status}=201

    ${body}  Contract Post Carrinhos    
    ...    id_produto=${id_produto}
    ...    quantidade=${quantidade}
    
    ${response}  POST On Session
    ...  alias=${serve_rest.alias}
    ...  url=/carrinhos
    ...  json=${body}
    ...  expected_status=${expected_status}
    
    RETURN    ${response}
