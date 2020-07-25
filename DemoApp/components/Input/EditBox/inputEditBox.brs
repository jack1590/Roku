sub init()
    m.layoutGroup = m.top.findNode("layoutGroup")
    m.selector = m.top.findNode("selector")
    m.textEditBox = m.top.findNode("textEditBox")
    m.top.observeField("focusedChild", "onFocusChanged")

    setInitialValues()
end sub

sub setInitialValues()
    m.selector.visible = false
end sub

sub onFocusChanged()
    m.textEditBox.hintTextColor = "0xd9d9d9"
    m.textEditBox.textColor = "0xd9d9d9"
    focus = m.top.isInFocusChain() or m.top.selected
    m.selector.visible = focus
    if focus then 
        m.textEditBox.hintTextColor = -1
        m.textEditBox.textColor = -1
    end if
end sub