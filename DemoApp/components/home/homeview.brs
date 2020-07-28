sub init()
    m.app = App()
    m.header = m.top.findNode("header")
    m.detailView = m.top.findNode("detailView")
    m.rowlist = m.top.findNode("rowlist")
    m.rowlist.observeField("rowItemSelected", "onRowItemSelected")
    m.movieConfig = MoviesConfig()
    m.serieConfig = SeriesConfig()
    m.gridConfig = GridConfig()

    setInitialValues()
end sub

sub setInitialValues()
    m.header.height = 125
    m.rowlist.setFocus(true)
    m.rowlist.update(m.gridConfig)
    m.detailView.width = m.gridConfig.itemSize[0]
end sub

function GridConfig() as object
    translationX = m.app.design.home.translationX
    translationY = m.app.design.home.translationY
    itemSizeHeight = 464
    itemSizeWidth = m.app.uiResolution.width - (translationX * 2)

    return {
        focusBitmapUri: m.app.design.images.focusedGrid,
        rowItemSize: [[m.movieConfig.width, m.movieConfig.height], [m.serieConfig.width, m.serieConfig.height]],
        rowLabelFont: m.app.fonts.small,
        translation: [translationX, translationY],
        itemSize: [itemSizeWidth, itemSizeHeight],
        numRows: 2,
        itemSpacing: [30, 40],
        rowHeights: [550],
        rowItemSpacing: [[10, 120]],
        rowSpacings: [0, 100],
        showRowLabel: [true],
        showRowCounter: [true],
        rowLabelOffset: [[0, 20]]
    }
end function

function MoviesConfig() as object
    return {
        category: "movie",
        section: "Movies",
        intType: m.app.design.movies.intType,
        width: m.app.design.movies.width,
        height: m.app.design.movies.height
    }
end function

function SeriesConfig() as object
    return {
        category: "series",
        section: "Series",
        intType: m.app.design.series.intType,
        width: m.app.design.series.width,
        height: m.app.design.series.height
    }
end function

sub onRowItemSelected()
    rowIndex = m.rowlist.rowItemSelected[0]
    itemIndex = m.rowlist.rowItemSelected[1]
    itemContent = findDetailContent(rowIndex, itemIndex)
    showDetailView(itemContent)
end sub

function findDetailContent(rowIndex, itemIndex)
    content = m.rowlist.content.getChild(rowIndex).getChild(itemIndex)
    return content
end function

sub showDetailView(itemContent)
    m.detailView.itemContent = itemContent
    m.detailView.setFocus(true)
    m.detailView.visible = true
    m.rowList.visible = false
end sub

sub executeDeeplink()
    deeplink = m.top.deeplink
    section = m.serieConfig.section
    isDeepLink = true
    if deeplink.mediaType = m.app.design.movies.category then
        section = m.movieConfig.section
    end if

    if m.rowlist.content <> invalid then
        content = getContentById(deeplink.contentId, section)
        if content <> invalid then
            showDetailView(content)
        else
            ?"[Log error] Content with id ";deeplink.contentId;" not found!"
        end if

        if isDeepLink then m.detailView.isDeepLink = true
        m.pendingDeeplink = false
        
    else
        m.rowlist.observeField("content", "onRowlistContentUpdated")
        m.pendingDeeplink = true
    end if
end sub

function getContentById(contentId as string, sectionTitle as string) as object
    rowlistContent = m.rowlist.content
    if rowlistContent <> invalid then
        for i = 0 to rowlistContent.getChildCount() - 1
            section = rowlistContent.getChild(i)
            if section.title = sectionTitle then
                for j = 0 to section.getChildCount() - 1
                    item = section.getChild(j)
                    if item.id = contentId then
                        updateDetailItemIndexes(i, j)
                        return item
                    end if
                end for
            end if
        end for
    end if

    return invalid
end function

sub updateDetailItemIndexes(rowIndex, itemIndex)
    m.detailItemIndexes = [rowIndex, itemIndex]
    m.rowlist.jumpToItem = itemIndex
end sub

sub onRowlistContentUpdated()
    if m.pendingDeeplink then executeDeeplink()
    m.rowlist.unobserveField("content")
end sub

'-----------------------------
' Key handling
'-----------------------------

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false

    if press then
        if key = "back" and m.detailView.visible then
            m.detailView.visible = false
            m.rowList.visible = true
            m.rowlist.setFocus(true)
            handled = true
        end if
    end if
    return handled
end function