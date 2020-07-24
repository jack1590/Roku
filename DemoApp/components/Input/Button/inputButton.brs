sub init()
    m.label = m.top.findNode("label")
    m.poster = m.top.findNode("poster")
    m.selector = m.top.findNode("selector")

    setInitialValues()
end sub

sub setInitialValues()
    width = m.label.boundingRect().width
    height = m.label.boundingRect().height

    m.poster.width = width + 40
    m.poster.height = height + 20

    m.selector.width = m.poster.width
end sub
