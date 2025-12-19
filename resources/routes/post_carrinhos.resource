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

Assert POST Carrinhos
    [Arguments]    ${response}    ${message}


    Should Be Equal    ${response.json()['message']}    ${message}

    IF    ${response.status_code} == ${201}
        Should Not Be Empty    ${response.json()['_id']}
    END


# {
#   "message": "Cadastro realizado com sucesso",
#   "_id": "jogfODIlXsqxNFS2"
# }


# {
#   "message": "Não é permitido possuir produto duplicado | Não é permitido ter mais de 1 carrinho | Produto não encontrado | Produto não possui quantidade suficiente"
# }