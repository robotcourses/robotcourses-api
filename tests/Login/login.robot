*** Settings ***
Resource    ../../resources/connections/session.resource
Resource    ../../resources/routes/post_login.resource
Resource    ../../resources/data/user_data.resource

*** Test Cases ***
Cenário: Realizar Login com Sucesso

    Create ServeRest Session
    ${response}  POST Login    
    ...    login_email=${user_email}
    ...    login_password=${user_password}
    
    Assert POST Login    ${response}    Login realizado com sucesso

Cenário: Realizar Login Com Email Inválido

    Create ServeRest Session
    ${response}  POST Login    
    ...    login_email=teste@teste.com.br
    ...    login_password=${user_password}
    ...    expected_status=401
    
    Assert POST Login    ${response}    Email e/ou senha inválidos
    
Cenário: Realizar Login Com Password Inválido

    Create ServeRest Session
    ${response}  POST Login    
    ...    login_email=${user_email}
    ...    login_password=123456789
    ...    expected_status=401
    
    Assert POST Login    ${response}    Email e/ou senha inválidos