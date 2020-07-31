sub init()
    m.app = App()
    m.markupGrid = m.top.findNode("markupGrid")
    m.perfilGroup = m.top.findNode("perfilGroup")
    m.profileImage = m.top.findNode("profileImage")

    requestMenuInformation()
end sub

sub requestMenuInformation()
    m.readMarkupGridTask = createObject("roSGNode", "MenuContentTask")
    m.readMarkupGridTask.observeField("content", "showMarkupGrid")
    m.readMarkupGridTask.control = "RUN"
end sub

sub showMarkupGrid()
    m.markupGrid.content = m.readMarkupGridTask.content
    m.markupGrid.jumpToItem = 1
end sub


sub expandMenu()
    m.markupGrid.itemSize = [ 300, 30 ]
    m.markupGrid.setFocus(true)
    m.profileImage.visible = true
end sub

sub collapseMenu()
    m.markupGrid.itemSize = [ 55, 30 ]
    m.markupGrid.setFocus(false)
    m.profileImage.visible = false
end sub

sub onProfileChanged()
    profile = m.top.profile
    m.profileImage.uri = profile.HDPosterUrl
end sub