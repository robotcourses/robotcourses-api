*** Settings ***
Resource    ../routes/post_usuarios.resource
Resource    ../routes/post_login.resource

*** Keywords ***
Execute Login With Usuario Fallback

    ${response}  POST Login
    ...  expected_status=any

    IF    ${response.status_code} == ${401}
        POST Usuarios
        POST Login
    ELSE IF    ${response.status_code} != ${401} and ${response.status_code} != ${200}
        Fail    Erro ao realizar autenticação do usuário
    END