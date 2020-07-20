function App()
    m.app = m.global.app
    if m.app = invalid then 
        m.app = {}

        ' ## VARIABLES ##
        appInfo = CreateObject("roAppInfo")
        _host = appInfo.getValue("api_server")
        _isMockEnable = appInfo.getValue("is_mock_enable")
        m.app.isMockEnable = _isMockEnable

        ' ## FONTS ##
        m.app.fonts = {}
        m.app.fonts.large = createFont("Netflix-Semibold", 45)
        m.app.fonts.medium = createFont("Netflix-Regular", 25)
        m.app.fonts.small = createFont("Netflix-Light", 23)

        ' ## RESOLUTION ##
        m.app.uiResolution = {}
        m.app.uiResolution.width = getUIResolution().width
        m.app.uiResolution.height = getUIResolution().height

        ' ## DESIGN ##
        m.app.design = {}
        m.app.design.images = {}
        m.app.design.images.focusedProfile = "pkg:/images/focus_grid.9.png"
        m.app.design.images.editProfile = "pkg:/images/edit_icon.png"
        m.app.design.images.editProfileActive = "pkg:/images/edit_icon_active.png"

        m.app.design.icons = {}
        m.app.design.icons.calendar = "pkg:/images/icons/calendar.png"
        m.app.design.icons.home = "pkg:/images/icons/home.png"
        m.app.design.icons.monitor = "pkg:/images/icons/monitor.png"
        m.app.design.icons.movie = "pkg:/images/icons/movie.png"
        m.app.design.icons.play = "pkg:/images/icons/play.png"
        m.app.design.icons.plus = "pkg:/images/icons/plus.png"
        m.app.design.icons.search = "pkg:/images/icons/search.png"
        m.app.profileConfig = ProfileConfig() 

        m.global.addFields({app: m.app})
    end if

    return m.app
end function

function ProfileConfig() as object
    appProperties = m.app
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

function createFont(fontName, fontSize)
	font = CreateObject("roSGNode", "Font")
	font.uri = "pkg:/fonts/" + fontName + ".ttf"
	font.size = fontSize
	return font
end function

function getUIResolution() as object
    if m.uiResolution = invalid then         
        devInfo = createObject("roDeviceInfo")
        supportedResolutions = devInfo.getSupportedGraphicsResolutions()

        m.uiResolution = supportedResolutions[supportedResolutions.count() -1]
	end if
    
    return m.uiResolution
end function

