*** Settings ***
Resource    ../../resources/routes/post_usuarios.resource
Resource    ../../resources/connections/session.resource
Test Setup    Create ServeRest Session

*** Test Cases ***
Cenário: Cadastrar Usuário

    ${response}  POST Usuarios
    Assert POST Usuarios    ${response}    Cadastro realizado com sucesso

Cenário: Cadastrar Usuário com Email Já Utilizado

    POST Usuarios
    ...    nome=Vini Robot 1
    ...    email=vini_robot@teste.com.br
    ...    password=123@teste
    ...    administrador=false

    ${response}    POST Usuarios
    ...    nome=Vini Robot 1
    ...    email=vini_robot@teste.com.br
    ...    password=123@teste
    ...    administrador=false
    ...    expected_status=400

    Assert POST Usuarios    ${response}    Este email já está sendo usado