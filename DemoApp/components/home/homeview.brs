sub init()
    m.app = App()
    m.header = m.top.findNode("header")
    m.detailView = m.top.findNode("detailView")
    m.rowlist = m.top.findNode("rowlist")
    m.rowlist.observeField("rowItemSelected", "onRowItemSelected")
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
    movieConfig = MoviesConfig()
    seriesConfig = SeriesConfig()
    itemSizeWidth = m.app.uiResolution.width - (translationX * 2)

    return {
        focusBitmapUri: m.app.design.images.focusedGrid,
        rowItemSize: [[movieConfig.width, movieConfig.height], [seriesConfig.width, seriesConfig.height]],
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