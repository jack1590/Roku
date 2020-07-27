sub init()
    m.app = App()
    m.header = m.top.findNode("header")
    m.rowlist = m.top.findNode("rowlist")
    m.rowlist.observeField("rowItemSelected", "onRowItemSelected")

    setInitialValues()
end sub

sub setInitialValues()
    m.header.height = 125
    m.rowlist.setFocus(true)
    m.rowlist.update(GridConfig())
end sub

function GridConfig() as object
    translationX = 200
    translationY = 160
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
end sub

