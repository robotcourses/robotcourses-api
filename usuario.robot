*** Settings ***
Library    RequestsLibrary

*** Test Cases ***
Cenário: Cadastrar Usuário

    ${body}    Create Dictionary    
    ...    nome=Vinicius
    ...    email=vinicius.trindade@teste.com.br
    ...    password=123@teste
    ...    administrador=false
    
    ${response}    POST    
    ...    url=https://serverest.dev/usuarios
    ...    json=${body}
    ...    expected_status=201

    Should Be Equal    ${response.json()['message']}    Cadastro realizado com sucesso
    Should Not Be Empty    ${response.json()['_id']}

Cenário: Cadastrar Usuário com Email Já Utilizado

    ${body}    Create Dictionary
    ...    nome=Robot Framework 4
    ...    email=teste_rf_3@teste.com.br
    ...    password=123@teste
    ...    administrador=false
    
    ${response}    POST
    ...    url=https://serverest.dev/usuarios
    ...    json=${body}
    ...    expected_status=400

    Should Be Equal    ${response.json()['message']}    Este email já está sendo usado

Cenário: Buscar Usuário

    ${body}  Create Dictionary
    ...  nome=Robot Courses Test 6
    ...  email=rc_test_6@teste.com.br
    ...  password=teste@123
    ...  administrador=false
    
    ${response_post_usuario}  POST
    ...  url=https://serverest.dev/usuarios
    ...  json=${body}
    ...  expected_status=201
    
    ${response_get_usuario}  GET
    ...  url=https://serverest.dev/usuarios/${response_post_usuario.json()["_id"]}
    ...  expected_status=200

    Should Be Equal    ${body["nome"]}    ${response_get_usuario.json()["nome"]}
    Should Be Equal    ${body["email"]}    ${response_get_usuario.json()["email"]}
    Should Be Equal    ${body["password"]}    ${response_get_usuario.json()["password"]}
    Should Be Equal    ${body["administrador"]}    ${response_get_usuario.json()["administrador"]}
    Should Be Equal    ${response_post_usuario.json()["_id"]}    ${response_get_usuario.json()["_id"]}

Cenário: Realizar busca por usuário com id inexistente

    ${response}    GET
    ...  url=https://serverest.dev/usuarios/7w2Us0iyG7eIDzBm
    ...  expected_status=400

    Should Be Equal    ${response.json()["message"]}    Usuário não encontrado

Cenário: Realizar busca por usuário com id com mais de 16 caracteres

    ${response}    GET
    ...  url=https://serverest.dev/usuarios/7w2Us0iyG7eIDzBmjd
    ...  expected_status=400

    Should Be Equal    ${response.json()["id"]}    id deve ter exatamente 16 caracteres alfanuméricos

Cenário: Excluir Usuário

    ${body}  Create Dictionary
    ...  nome=Robot Courses Test 7
    ...  email=rc_test_7@teste.com.br
    ...  password=teste@123
    ...  administrador=false
    
    ${response_post_usuario}  POST
    ...  url=https://serverest.dev/usuarios
    ...  json=${body}
    ...  expected_status=201
    
    ${response_delete_usuario}    DELETE
    ...  url=https://serverest.dev/usuarios/${response_post_usuario.json()["_id"]}
    ...  expected_status=200
    
    Should Be Equal    ${response_delete_usuario.json()["message"]}    Registro excluído com sucesso

Cenário: Excluir Usuário Inexistente
    
    ${response_delete_usuario}    DELETE
    ...  url=https://serverest.dev/usuarios/1415674635
    ...  expected_status=200
    
    Should Be Equal    ${response_delete_usuario.json()["message"]}    Nenhum registro excluído

Cenário: Atualizar Dados do Usuário

    ${post_body}  Create Dictionary
    ...  nome=Robot Courses Test 9
    ...  email=rc_test_9@teste.com.br
    ...  password=teste@123
    ...  administrador=false
    
    ${response_post_usuario}  POST
    ...  url=https://serverest.dev/usuarios
    ...  json=${post_body}
    ...  expected_status=201
    
    ${put_body}  Create Dictionary
    ...  nome=Robot Courses Test 10
    ...  email=rc_test_10@teste.com.br
    ...  password=teste@123
    ...  administrador=false

    ${response_put_usuario}    PUT
    ...  url=https://serverest.dev/usuarios/${response_post_usuario.json()["_id"]}
    ...  json=${put_body}
    ...  expected_status=200

Cenário: Atualizar Dados do Usuário Inexistente
    
    ${put_body}  Create Dictionary
    ...  nome=Robot Courses Test 12
    ...  email=rc_test_12@teste.com.br
    ...  password=teste@123
    ...  administrador=false

    ${response}    PUT
    ...  url=https://serverest.dev/usuarios/qG6AkrFsJM3G1ei4
    ...  json=${put_body}
    ...  expected_status=201

    Should Be Equal    ${response.json()['message']}    Cadastro realizado com sucesso
    Should Not Be Empty    ${response.json()['_id']}

Cenário: Atualizar Dados do Usuário Com Email Existente
    
    ${put_body}  Create Dictionary
    ...  nome=Robot Courses Test 11
    ...  email=rc_test_10@teste.com.br
    ...  password=teste@123
    ...  administrador=false

    ${response}    PUT
    ...  url=https://serverest.dev/usuarios/qG6AkrFsJM3G1ei4
    ...  json=${put_body}
    ...  expected_status=400

    Should Be Equal    ${response.json()['message']}    Este email já está sendo usado

Cenário: Realizar listagem de usuário

    ${params}    Create Dictionary
    ...  _id=1PYryuVUK34rdZgp
    ...  administrador=false

    ${response}    GET
    ...  url=https://serverest.dev/usuarios
    ...  params=${params}
    ...  expected_status=200
    
    Log To Console    ${response.json()["usuarios"][0]["nome"]}
    