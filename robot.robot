*** Settings ***
Library    SeleniumLibrary
Suite Setup    Open Browser    https://test.k6.io/browser.php    chrome
Suite Teardown    Close Browser

*** Variables ***
${CHECKBOX_ID}    checkbox1
${TEXT_INPUT_ID}    text1
${COUNTER_BUTTON}    counter-button
${SELECT_BOX_ID}    numbers-options
${SCREENSHOT_BEFORE}    before.png
${SCREENSHOT_AFTER}    after.png

*** Test Cases ***
Test Checkbox Interaction
    [Documentation]    Verify checkbox interactions
    Verify No Interaction On Checkbox
    Check Checkbox
    Uncheck Checkbox

Test Increment Counter
    [Documentation]    Verify counter increment
    Capture Page Screenshot    ${SCREENSHOT_BEFORE}
    Click Button    ${COUNTER_BUTTON}
    Log    Clicked Increment Button
    Sleep    1s  # หน่วงเวลา 1 วินาทีก่อนอ่านค่าเคาน์เตอร์
    Verify Counter Increment
    Capture Page Screenshot    ${SCREENSHOT_AFTER}

Test Input Text Field
    [Documentation]    Verify input text interactions
    Verify No Interaction On Input Text
    Focus On Input Text Field
    Enter Text In Input Field
    Verify Text After Input
    Clear Input Field
    Verify Text After Clear

Test Select Box Interaction
    [Documentation]    Verify select box interactions
    Verify No Selection In Select Box
    Select Zero In Select Box
    Verify Selection In Select Box

*** Keywords ***
Verify No Interaction On Checkbox
    ${text} =    Get Text    //p[@id='checkbox-info-display']
    Log    Checkbox info display text: ${text}  # Log for debugging
    Should Be Equal    ${text}    No interaction

Check Checkbox
    Click Element    //input[@id='${CHECKBOX_ID}']
    ${text} =    Get Text    //p[@id='checkbox-info-display']
    Log    Checkbox info display text after check: ${text}  # Log for debugging
    Should Be Equal    ${text}    Thanks for checking the box

Uncheck Checkbox
    Click Element    //input[@id='${CHECKBOX_ID}']
    ${text} =    Get Text    //p[@id='checkbox-info-display']
    Log    Checkbox info display text after uncheck: ${text}  # Log for debugging
    Should Be Equal    ${text}    You've just unchecked the box

Capture Page Screenshot
    [Arguments]    ${filename}
    Capture Page Screenshot    ${filename}

Verify Counter Increment
    ${counter_text} =    Get Text    //p[@id='counter-info-display']
    Log    Counter text: ${counter_text}  # Log for debugging
    Should Match Regexp    ${counter_text}    Counter: \d+  # Ensure it matches Counter: <number>

Verify No Interaction On Input Text
    ${text} =    Get Text    //p[@id='text-info-display']
    Log    Input text info display: ${text}  # Log for debugging
    Should Be Equal    ${text}    No interaction

Focus On Input Text Field
    Execute JavaScript    document.getElementById('${TEXT_INPUT_ID}').focus();
    ${text} =    Get Text    //p[@id='text-info-display']
    Log    Input text info display after focus: ${text}  # Log for debugging
    Should Be Equal    ${text}    focused on input text field

Enter Text In Input Field
    Input Text    //input[@id='${TEXT_INPUT_ID}']    Hello World
    ${text} =    Get Text    //p[@id='text-info-display']
    Log    Input text info display after entering text: ${text}  # Log for debugging
    Should Be Equal    ${text}    Thanks for filling in the input text field

Verify Text After Input
    ${text} =    Get Text    //p[@id='text-info-display']
    Log    Verifying text after input: ${text}  # Log for debugging
    Should Be Equal    ${text}    Thanks for filling in the input text field

Clear Input Field
    Input Text    //input[@id='${TEXT_INPUT_ID}']    ""
    Sleep    1s  # หน่วงเวลา 1 วินาทีก่อนอ่านค่าจาก UI
    ${text} =    Get Text    //p[@id='text-info-display']
    Log    Input text info display after clearing: ${text}  # Log for debugging
    Should Be Equal    ${text}    You've just removed everything from the input text field

Verify Text After Clear
    ${text} =    Get Text    //p[@id='text-info-display']
    Log    Verifying text after clear: ${text}  # Log for debugging
    Should Be Equal    ${text}    You've just removed everything from the input text field

Verify No Selection In Select Box
    ${text} =    Get Text    //p[@id='select-multiple-info-display']
    Log    Select box info display: ${text}  # Log for debugging
    Should Be Equal    ${text}    Nothing selected

Select Zero In Select Box
    Select From List By Value    ${SELECT_BOX_ID}    zero

Verify Selection In Select Box
    ${text} =    Get Text    //p[@id='select-multiple-info-display']
    Log    Verifying selection in select box: ${text}  # Log for debugging
    Should Be Equal    ${text}    Selected: zero
