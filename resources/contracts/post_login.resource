*** Keywords ***
Contract Post Login
    [Arguments]    ${login_email}    ${login_password}

    ${body}  Create Dictionary
    ...  email=${login_email}
    ...  password=${login_password}
    
    RETURN  ${body}