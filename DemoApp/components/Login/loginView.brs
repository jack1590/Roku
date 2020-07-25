sub init()
    m.app = App()
    m.title = m.top.findNode("title")
    m.username = m.top.findNode("username")
    m.password = m.top.findNode("password")
    m.loginButton = m.top.findNode("loginButton")
    m.layoutGroup = m.top.findNode("layoutGroup")
    m.keyboard = m.top.findNode("keyboard")
    m.textEditSelected = invalid

    setInitialValues()
end sub

sub setInitialValues()
    m.title.font = m.app.fonts.extralarge
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press then
        if key = "down" then
            handled = true
            downEvent()
        else if key = "up" then
            handled = true
            upEvent()
        else if key = "OK" then
            handled = true
            handleSelection()
        else if key = "back" then
            handled = true
            handleBack()
        end if
    end if
    return handled
end function

sub downEvent()
    if m.userName.hasFocus() then
        m.password.setFocus(true)
    else if m.password.hasFocus() then
        m.loginButton.setFocus(true)
    end if
end sub

sub upEvent()
    if m.loginButton.hasFocus() then
        m.password.setFocus(true)
    else if m.password.hasFocus() then
        m.userName.setFocus(true)
    end if
end sub

sub handleSelection()
    if m.textEditSelected <> invalid then m.textEditSelected.selected = false

    if m.userName.hasFocus() then
        m.textEditSelected = m.userName
        m.username.selected = true
    else if m.password.hasFocus() then
        m.textEditSelected = m.password
        m.password.selected = true
    end if
    
    if not m.loginButton.hasFocus() then
        m.keyboard.textEditBox.observeField("text", "onTextTyped")
        m.keyboard.visible = true
        m.keyboard.setFocus(true)
    else
        m.top.getScene().callFunc("showSpinner", m.top.id)
    end if
end sub

sub onTextTyped()
    m.textEditSelected.text = m.keyboard.textEditBox.text
end sub

sub handleBack()
    m.keyboard.textEditBox.unobserveField("text")
    m.keyboard.visible = false
    m.keyboard.text = ""
    if m.textEditSelected <> invalid then
        m.textEditSelected.selected = false
        m.textEditSelected.setFocus(true)
    end if
end sub