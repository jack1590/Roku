function App()
    m.app = m.global.app
    if m.app = invalid then 
        m.app = {}

        ' ## APP PARAMS ##
        appInfo = CreateObject("roAppInfo")
        _host = appInfo.getValue("api_server")
        m.appInfo.api = {}
        m.app.api.host = _host

        ' ## FONTS ##
        m.app.fonts = {}
        m.app.fonts.large = createFont("Demo-Semibold", 45)
        m.app.fonts.medium = createFont("Demo-Regular", 25)
        m.app.fonts.small = createFont("Demo-Light", 23)

        ' ## RESOLUTION ##
        m.app.uiResolution = {}
        m.app.uiResolution.width = getUIResolution().width
        m.app.uiResolution.height = getUIResolution().height

        ' ## DESIGN ##
        m.app.design = {}
        m.app.design.images = {}
        m.app.design.images.focusedGrid = "pkg:/images/focus_grid.9.png"

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
