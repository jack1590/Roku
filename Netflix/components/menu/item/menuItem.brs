sub init()
    m.app = App()
    m.layoutGroup = m.top.findNode("layoutGroup")
    m.title = m.top.findNode("title")
    m.icon = m.top.findNode("icon")
    m.animation = m.top.findNode("animation")
    m.testTimer = m.top.findNode("testTimer")
    m.testTimer.ObserveField("fire","startAnimation")

    setInitialValues()
end sub

sub setInitialValues()
    m.title.font = m.app.fonts.medium
    m.title.translation = [-300, 0]
end sub

sub onItemContentChanged()
    m.item = m.top.itemContent
    m.title.text = m.item.title
    m.icon.uri = m.item.hdgridposterurl
    m.testTimer.duration = m.item.duration
end sub

sub onItemHasFocus()
end sub

sub onGridHasFocus()
    if m.top.gridHasFocus then
        m.icon.translation = [ 25, 0 ]
        m.testTimer.control = "start"
    else
        m.icon.translation = [ 10, 0 ]
        m.title.translation = [-300, 0]
    end if
end sub

sub startAnimation()
    m.animation.control = "start"
end sub