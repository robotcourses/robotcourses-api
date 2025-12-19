*** Settings ***
Resource    ../../resources/connections/session.resource
Resource    ../../resources/routes/post_carrinhos.resource
Resource    ../../resources/routes/delete_concluir_carrinho.resource
Resource    ../../resources/utils/utils.resource
Test Setup    Run Keywords   
...    Create ServeRest Session
...    Execute Login With Usuario Fallback

*** Test Cases ***
Cenário: Criar Carrinho Com Um Item

    @{id_produto}  Create List  BeeJh5lz3k6kSIzA
    @{quantidade}    Create List    3

    ${resp_post_carrinhos}  POST Carrinhos    
    ...    id_produto=${id_produto}
    ...    quantidade=${quantidade}

    Assert POST Carrinhos    ${resp_post_carrinhos}    Cadastro realizado com sucesso

    ${resp_del_concluir_compra}  DELETE Concluir Compra

    Assert DELETE Concluir Compra    ${resp_del_concluir_compra}    Registro excluído com sucesso

Cenário: Criar Carrinho Com Mais de Um Item

    @{id_produto}  Create List  BeeJh5lz3k6kSIzA    171CULHEIyWR2Hre
    @{quantidade}    Create List    3    5

    ${resp_post_carrinhos}  POST Carrinhos    
    ...    id_produto=${id_produto}
    ...    quantidade=${quantidade}
    
    Assert POST Carrinhos    ${resp_post_carrinhos}    Cadastro realizado com sucesso

    ${resp_del_concluir_compra}  DELETE Concluir Compra

    Assert DELETE Concluir Compra    ${resp_del_concluir_compra}    Registro excluído com sucesso