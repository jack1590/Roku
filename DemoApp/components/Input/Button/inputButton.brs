sub init()
    m.label = m.top.findNode("label")
    m.poster = m.top.findNode("poster")
    m.selector = m.top.findNode("selector")
    m.top.observeField("focusedChild", "onFocusChanged")

    setInitialValues()
end sub

sub setInitialValues()
    m.selector.visible = false

    width = m.label.boundingRect().width
    height = m.label.boundingRect().height

    m.poster.width = width + 40
    m.poster.height = height + 20

    m.selector.width = m.poster.width
end sub

sub onFocusChanged()
    focus = m.top.isInFocusChain()
    m.selector.visible = focus
end sub