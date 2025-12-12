*** Settings ***
Library    RequestsLibrary
Variables  app_conn.yaml

*** Variables ***
${ENVIRONMENT}    dev

*** Keywords ***
Create ServeRest Session

    Create Session    
    ...    alias=${serve_rest.alias}
    ...    url=${serve_rest.${ENVIRONMENT}.url}
    ...    disable_warnings=${True}