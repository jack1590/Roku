function ProfileConfig() as object
    appProperties = App()
    numberProfiles = 5
    rowItemSizeWidth = 220
    rowItemSizeHeaight = 410
    rowItemSpacingX = 50

    rowWidth = (rowItemSizeWidth * numberProfiles) + (rowItemSpacingX * (numberProfiles - 1)) + 30
    return {
        itemSize: [rowWidth, rowItemSizeHeaight]
        rowItemSize: [[rowItemSizeWidth, rowItemSizeHeaight]],
        rowItemSpacing: [[rowItemSpacingX, 0]],
        axisY: 500,
        axisX: ((appProperties.uiResolution.width - rowWidth) / 2),
        item: {
            posterSize: rowItemSizeWidth,
            focusPosterSize: rowItemSizeWidth + 40,
            layoutTranslation: [rowItemSizeWidth/2 + 10, 10]
            layoutSpacings: [20, 50]
        }
    }
end function