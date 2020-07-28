sub init()
    m.label = m.top.findNode("label")
    m.poster = m.top.findNode("poster")
    m.selector = m.top.findNode("selector")
    m.selector.visible = false
    m.top.observeField("focusedChild", "onFocusChanged")
    m.label.observeField("text", "onTextChanged")
    m.config = Config()

    setInitialValues()
end sub

function Config()
    return {
        offsetWidth: 50,
        offsetHeight: 30,
        color: "0x468847",
        uri: "pkg:/images/buttonRounded.9.png"
    }
end function

sub setInitialValues()
    posterX = -(m.config.offsetWidth/2)
    posterY = -(m.config.offsetHeight/2)
    selectorX = posterX + 5
    selectorY = posterY - 10

    m.poster.translation = [ posterX, posterY ]
    m.poster.uri = m.config.uri
    m.selector.translation = [ selectorX, selectorY ]

    m.label.color = m.config.color
end sub

sub onFocusChanged()
    focus = m.top.isInFocusChain()
    m.selector.visible = focus
end sub

sub onTextChanged()
    width = m.label.boundingRect().width
    height = m.label.boundingRect().height

    m.poster.width = width + m.config.offsetWidth
    m.poster.height = height + m.config.offsetHeight

    m.selector.width = m.poster.width
end sub