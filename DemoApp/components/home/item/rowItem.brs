sub init()
    m.app = App()
    m.imagePoster = m.top.findNode("imagePoster")
    m.gradientPoster = m.top.findNode("gradientPoster")
    m.infoGroup = m.top.findNode("infoGroup")
    m.title = m.top.findNode("title")
end sub

sub onItemContentChanged()
    itemContent = m.top.itemContent
    m.imagePoster.uri = itemContent.HDPosterUrl

    createPoster(m.gradientPoster, m.app.design.images.gradient, itemContent.contentType)
    setLabelsProperties(itemContent.title)
end sub

sub createPoster(poster, uri, contentType)
    if contentType = m.app.design.movies.intType then
        poster.width = m.app.design.movies.width
        poster.height = m.app.design.movies.height
    else
        poster.width = m.app.design.series.width
        poster.height = m.app.design.series.height 
    end if
    poster.uri = uri
end sub

sub setLabelsProperties(title)
    itemMargin = 20
    m.title.text = title
    m.title.maxWidth = m.gradientPoster.width - (itemMargin * 2)
    bottomHeight = m.infoGroup.boundingRect().height + itemMargin
    y = m.gradientPoster.height - bottomHeight
    m.infoGroup.translation = [itemMargin, y]
    m.gradientPoster.translation = [0, y - (itemMargin * 4)]
    m.gradientPoster.height = bottomHeight + (itemMargin * 4)

    ' Fonts
    m.title.font = m.app.fonts.medium
end sub