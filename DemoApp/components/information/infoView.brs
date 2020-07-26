sub init()
    m.app = App()
    m.title = m.top.findNode("title")
    m.description = m.top.findNode("description")
    m.okButton = m.top.findNode("okButton")
    m.top.observeField("visible", "onVisibleChanged")

    setInitialValues()
end sub

sub setInitialValues()
    m.title.font = m.app.fonts.extralarge
    m.description.font = m.app.fonts.large
end sub

sub onVisibleChanged()
    m.okButton.setFocus(true)
end sub

