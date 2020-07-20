sub init()
    m.collapsedMenu = m.top.findNode("collapsedMenu")
    m.label = m.top.findNode("label")
end sub


function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if press then
        if key = "left" and not m.collapsedMenu.hasFocus() then
            m.collapsedMenu.callFunc("expandMenu")
            handled = true
        else if key = "right" and not m.label.hasFocus() then
            m.collapsedMenu.callFunc("collapseMenu")
            m.label.setFocus(true)
            handled = true
        end if
    end if

    return handled
end function