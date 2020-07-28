sub main(args as dynamic)
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    scene.backgroundUri = "pkg:/images/DeepSpace.jpg"
    screen.show()

    if (args.mediaType <> invalid) and (args.contentId <> invalid) then
        deeplink = {
            mediaType: args.mediaType,
            contentId: args.contentId
        }

        scene.deeplink = deeplink
    end if

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub
