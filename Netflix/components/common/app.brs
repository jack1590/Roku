function App()
    m.app = m.global.app
    if m.app = invalid then 
        m.app = {}
        appInfo = CreateObject("roAppInfo")
        _host = appInfo.getValue("api_server")
        _isMockEnable = appInfo.getValue("is_mock_enable")

        m.app.isMockEnable = _isMockEnable

        m.app.fonts = {}
        m.app.fonts.large = createFont("Netflix-Semibold", 45)
        m.app.fonts.medium = createFont("Netflix-Regular", 25)
        m.app.fonts.small = createFont("Netflix-Light", 23)

        m.app.uiResolution = {}
        m.app.uiResolution.width = getUIResolution().width
        m.app.uiResolution.height = getUIResolution().height

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