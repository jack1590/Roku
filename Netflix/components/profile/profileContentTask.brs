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
    output = parseJson(ReadAsciiFile("pkg:/mock/profile.json"))
    
    for each item in output
        itemcontent = content.createChild("ContentNode")
        itemcontent.hdgridposterurl = item.poster
        itemcontent.shortdescriptionline1 = item.name
    end for
end sub

sub createContent(content)
    contentxml = createObject("roXMLElement")

    readInternet = createObject("roUrlTransfer")
    readInternet.setUrl("http://www.sdktestinglab.com/Tutorial/content/rendergridps.xml")
    contentxml.parse(readInternet.GetToString())

    if contentxml.getName()="Content"
    for each item in contentxml.GetNamedElements("item")
        itemcontent = content.createChild("ContentNode")
        itemcontent.setFields(item.getAttributes())
    end for
    end if
end sub
