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
    sectionNode = content.createChild("ContentNode")
    sectionNode.setField("TITLE", "Profile")
    
    for each item in output.profile.items
        itemContent = sectionNode.createChild("ContentNode")
        itemContent.id = item.id
        itemContent.HDPosterUrl = item.poster
        itemContent.title = item.name
        itemContent.addField("isPosterSelected", "boolean", false)
        itemContent.setField("isPosterSelected", true)
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
