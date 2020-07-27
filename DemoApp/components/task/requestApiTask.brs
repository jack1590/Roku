sub onActionChanged()
    m.app = App()
    if m.top.action <> invalid then m.top.functionName = m.top.action
    m.top.control = "RUN"
end sub

sub getVod()
    content = createObject("roSGNode", "ContentNode")
    moviesSection = createSectionNode(content, "Movies")
    seriesSection = createSectionNode(content, "Series")
    url = m.app.api.host + m.app.api.home.resource
    output = getAPI(url)

    for each item in output
        if item.body.titles <> invalid then
            if item.body.contentType = "SERIES" then
                createItemContentNode(seriesSection, item)
            else
                createItemContentNode(moviesSection, item)
            end if
        end if
    end for

    m.top.output = content
end sub

function createSectionNode(parent, title)
    sectionNode = parent.createChild("ContentNode")
    sectionNode.setField("TITLE", title)
    return sectionNode
end function

sub createItemContentNode(parent, item)
    baseUrl = item.body.images.tile
    width = m.app.design.[parent.title].width
    height = m.app.design.[parent.title].height
    size = width.toStr() + "x" + height.toStr()
    posterUrl = createPosterUrl(baseUrl, size)

    itemContent = parent.createChild("ContentNode")
    itemContent.addHeader("Authorization", m.global.token)
    itemContent.setCertificatesFile("common:/certs/ca-bundle.crt")
    itemContent.initClientCertificates()
    itemContent.id = item.id
    itemContent.title = item.body.titles.full
    itemContent.description = item.body.shortSummary
    itemContent.HDPosterUrl = posterUrl
    itemContent.addField("size", "string", false)
    itemContent.setField("size", size) 
    if item.body.contentType = "SERIES" then
        itemContent.contentType = m.app.design.series.category
    else
        itemContent.contentType = m.app.design.movies.category
    end if
end sub

function createPosterUrl(baseUrl, size) as string
    compression = "low"
    protection = false
    scaleDownToFit = true

    baseUrl = baseUrl.replace("{{size}}", size)
    baseUrl = baseUrl.replace("{{compression}}", compression)
    baseUrl = baseUrl.replace("{{protection}}", protection.toStr())
    return baseUrl.replace("{{scaleDownToFit}}", scaleDownToFit.toStr())
end function

'*****************************************
' Requests
'*****************************************


'Core functionality that makes get request
'and returns the remote data
function getAPI(url) as object
    request = CreateObject("roUrlTransfer")
    request.setURL(url)
    request.setCertificatesFile("common:/certs/ca-bundle.crt")
    request.initClientCertificates()

    if m.app.api.apiToken <> "" then
        request.addHeader("Authorization", m.global.token)
    end if

    return parseJson(request.getToString())
end function