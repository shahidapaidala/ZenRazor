*** Settings ***
Documentation     A test suite with a single test for valid home page.
Library           Selenium2Library  
Library           robot.libraries.DateTime
Library           OperatingSystem
Library           XvfbRobot

*** Variables ***
${BROWSER}        chrome
${SERVER}         zenrazor.azurewebsites.net
${DELAY}          0
${HOME URL}       http://${SERVER}/
${TASKS PAGE URL}         http://${SERVER}/ZenTasks
${ABOUT PAGE URL}         http://${SERVER}/About
${CONTACT PAGE URL}         http://${SERVER}/Contact

${date}=  Convert Date date_format=%d/%m/%Y %H:%M
&{TASK 1}       title=RobotTest1    created=${date}  who=Robot1 details=robot test  duedate=${date}  person=""Mr.Robot" effort=2

*** Test Cases ***
Home Page
    Start Virtual Display    1920    1080
    Open Browser    ${HOME URL}    ${BROWSER}
    Set Window Size    1920    1080
    Set Selenium Speed    ${DELAY}
    Title Should Be    Home page - ZenRazor
    Page Should contain    Application uses
    Page Should contain    How to
    Page Should contain    Overview
    Page Should contain    Run & Deploy
    Page Should contain    Sample Map
    Click Link    xpath=//a[@href="/ZenTasks"]
    Title Should Be    Index - ZenRazor
    Click Link    xpath=//a[@href="/About"]
    Title Should Be    About - ZenRazor
    Click Link    xpath=//a[@href="/Contact"]
    Title Should Be    Contact - ZenRazor
    [Teardown]    Close Browser

Task Page
    Start Virtual Display    1920    1080
    Open Browser    ${TASKS PAGE URL}    ${BROWSER}
    Set Window Size    1920    1080
    Set Selenium Speed    ${DELAY}
    Title Should Be    Index - ZenRazor
    Page Should contain    Index
    Element Text Should Be    //p//a  Create New
    [Teardown]    Close Browser

Create Task
    [Tags]  wip
    Start Virtual Display    1920    1080
    Open Browser    ${TASKS PAGE URL}    ${BROWSER}
    Set Window Size    1920    1080
    Set Selenium Speed    ${DELAY}
    Title Should Be    Index - ZenRazor
    Click Link    xpath=//a[@href="/ZenTasks/Create"]
    Input Text  id:ZenTask_Title  ${TASK 1.title}
    Input Text  id:ZenTask_CreatedDate  ${TASK 1.created}
    Input Text  id:ZenTask_Who  ${TASK 1.who}
    Input Text  id:ZenTask_Details  ${TASK 1.details}
    Input Text  id:ZenTask_DueDate  ${TASK 1.duedate}
    Input Text  id:ZenTask_AssignedPerson  ${TASK 1.duedate}
    Input Text  id:ZenTask_WorkEffort  ${TASK 1.effort}
    [Teardown]    Close Browser
    
About Page
    Start Virtual Display    1920    1080
    Open Browser    ${ABOUT PAGE URL}    ${BROWSER}
    Set Window Size    1920    1080
    Set Selenium Speed    ${DELAY}
    Title Should Be    About - ZenRazor
    Page Should contain    About
    Element Should contain    //h3  Your application description page.
    Element Should contain    //footer//p  © 2018 - FourCloud
    [Teardown]    Close Browser
 
Contact Page
    Start Virtual Display    1920    1080
    Open Browser    ${CONTACT PAGE URL}    ${BROWSER}
    Set Window Size    1920    1080
    Set Selenium Speed    ${DELAY}
    Title Should Be    Contact - ZenRazor
    Page Should contain    Contact
    Element Should contain    //h3  Your contact page.
    Click Link    xpath=//a[@href="mailto:Support@example.com"]
    Click Link    xpath=//a[@href="mailto:Marketing@example.com"]
    Element Should contain    //footer//p  © 2018 - FourCloud
    [Teardown]    Close Browser