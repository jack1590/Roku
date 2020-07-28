function App()
    m.app = m.global.app
    if m.app = invalid then 
        m.app = {}

        ' ## APP PARAMS ##
        appInfo = CreateObject("roAppInfo")
        _host = appInfo.getValue("api_server")
        m.app.api = {}
        m.app.api.host = _host
        m.app.api.login = "login"
        m.app.api.home = {
            action: "getVod",
            resource: "home"
        }
        m.app.api.video = {
            action: "getVideo",
            resource: "video/"
        }

        ' ## FONTS ##
        m.app.fonts = {}
        m.app.fonts.extralarge = createFont("Demo-Semibold", 90)
        m.app.fonts.large = createFont("Demo-Semibold", 45)
        m.app.fonts.medium = createFont("Demo-Regular", 25)
        m.app.fonts.small = createFont("Demo-Light", 23)

        ' ## RESOLUTION ##
        m.app.uiResolution = {}
        m.app.uiResolution.width = getUIResolution().width
        m.app.uiResolution.height = getUIResolution().height

        ' ## DESIGN ##
        m.app.design = {}

        m.app.design.movies = {}
        m.app.design.movies.width = 700
        m.app.design.movies.height = 464
        m.app.design.movies.intType = 1
        m.app.design.movies.category = "movie"

        m.app.design.series = {}
        m.app.design.series.width = 400
        m.app.design.series.height = 250
        m.app.design.series.intType = 2
        m.app.design.series.category = "series"

        m.app.design.home = {}
        m.app.design.home.translationX = 200
        m.app.design.home.translationY = 160

        m.app.design.images = {}
        m.app.design.images.focusedGrid = "pkg:/images/focus_grid.9.png"
        m.app.design.images.spinner = "pkg:/images/busyspinner_hd.png"
        m.app.design.images.gradient = "pkg:/images/bottomGradient.png"
        m.app.design.images.play = "pkg:/images/play.png"

        ' ## MESSAGES ##
        m.app.messages = {}
        m.app.messages.loginFailed = "Incorrect/Missing Values"
        m.app.messages.playFailed = "Content unavailable"
        m.app.messages.playFailedMessage = "Sorry! We are having trouble playing this title right now."

        m.global.addFields({app: m.app})
    end if

    return m.app
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
