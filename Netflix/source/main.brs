sub main()
    setApplicationTheme()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    scene.backgroundUri = "pkg:/images/DeepSpace.jpg"

    screen.show()
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub

Sub setApplicationTheme()
    app = CreateObject("roAppManager")
    theme = CreateObject("roAssociativeArray")
    theme.BackgroundColor = "#FF00FF"
    app.SetTheme(theme)
End Sub