sub init()
    m.top.functionName = "getContent"
end sub

sub getContent()
    content = createObject("roSGNode", "ContentNode")
    m.app = App()
    
    if m.app.isMockEnable = "true" then
        createContentMockData(content)
    else
        createContent(content)
    end if

    m.top.content = content
end sub

sub createContentMockData(content)
    output = parseJson(ReadAsciiFile("pkg:/mock/menu.json"))

    for each item in output
        itemcontent = content.createChild("ContentNode")
        itemcontent.hdgridposterurl = item.poster
        itemcontent.title = item.title
        itemcontent.addField("duration", "float", false)
        itemcontent.setField("duration", item.duration)
    end for
end sub

sub createContent(content)
    'TODO: 
end sub