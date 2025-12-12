*** Settings ***
Resource    ../../resources/connections/session.resource
Resource    ../../resources/routes/post_carrinhos.resource
Resource    ../../resources/routes/post_login.resource
Test Setup    Run Keywords   
...    Create ServeRest Session
...    POST Login

*** Test Cases ***
Cenário: Criar Carrinho Com Um Item

    @{id_produto}  Create List  BeeJh5lz3k6kSIzA
    @{quantidade}    Create List    3

    ${response}  POST Carrinhos    
    ...    id_produto=${id_produto}
    ...    quantidade=${quantidade}

Cenário: Criar Carrinho Com Mais de Um Item

    @{id_produto}  Create List  BeeJh5lz3k6kSIzA    jsabjsfajbksakjb
    @{quantidade}    Create List    3    5

    ${response}  POST Carrinhos    
    ...    id_produto=${id_produto}
    ...    quantidade=${quantidade}