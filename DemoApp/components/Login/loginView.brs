sub init()
    m.app = App()
    m.title = m.top.findNode("title")
    m.username = m.top.findNode("username")
    m.password = m.top.findNode("password")

    setInitialValues()
end sub

sub setInitialValues()
    m.title.font = m.app.fonts.extralarge

end sub