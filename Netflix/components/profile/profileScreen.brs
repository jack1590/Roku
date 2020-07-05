sub init()
    m.app = App()
    m.label = m.top.findNode("questionLabel")
    m.posterGrid = m.top.findNode("posterGrid")

    requestProfileInformation()
    setInitialValues()
end sub

sub setInitialValues()
    m.label.font = m.app.fonts.large
    m.label.width = m.app.uiResolution.width

    m.posterGrid.sectionDividerFont = m.app.fonts.medium
    m.posterGrid.setFocus(true)
end sub

sub requestProfileInformation()
    m.readPosterGridTask = createObject("roSGNode", "ProfileContentTask")
    m.readPosterGridTask.observeField("content", "showpostergrid")
    m.readPosterGridTask.control = "RUN"
end sub

sub showpostergrid()
    m.posterGrid.content = m.readPosterGridTask.content
    axisX = ((m.app.uiResolution.width - m.posterGrid.boundingRect().width) / 2) + 50
    m.posterGrid.translation = [axisX, 500]
end sub