*** Settings ***
Library    RequestsLibrary

*** Keywords ***
Create ServeRest Session

    Create Session    
    ...    alias=serve_rest
    ...    url=https://serverest.dev
    ...    disable_warnings=${True}
