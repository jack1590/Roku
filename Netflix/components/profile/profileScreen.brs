sub init()
    m.app = App()
    m.config = m.app.profileConfig
    m.label = m.top.findNode("questionLabel")
    m.rowList = m.top.findNode("rowlist")
    m.isPosterSelected = true
    m.rowList.observeField("rowItemSelected", "onRowItemSelected")

    requestProfileInformation()
    setInitialValues()
end sub

sub setInitialValues()
    m.label.font = m.app.fonts.large
    m.label.width = m.app.uiResolution.width

    m.rowList.translation = [m.config.axisX, m.config.axisY]
    m.rowList.itemSize = m.config.itemSize
    m.rowList.rowItemSize = m.config.rowItemSize
    m.rowList.rowItemSpacing = m.config.rowItemSpacing
end sub

sub requestProfileInformation()
    m.readPosterGridTask = createObject("roSGNode", "ProfileContentTask")
    m.readPosterGridTask.observeField("content", "showRowList")
    m.readPosterGridTask.control = "RUN"
end sub

sub showRowList()
    m.rowList.content = m.readPosterGridTask.content
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
  handled = false
  if press then
    if key = "down" or key = "up" then
        handled = true
        togleFocusElement()
    end if
  end if
  return handled
end function

'----------------------------------------------------------------------
' Toggle the focus between poster and icon
'----------------------------------------------------------------------
sub togleFocusElement()
    itemFocused = m.rowList.rowItemFocused[1]
    isPosterSelected = m.rowList.content.getChild(0).getChild(itemFocused).isPosterSelected
    m.rowList.content.getChild(0).getChild(itemFocused).isPosterSelected = not isPosterSelected
end sub


sub onRowItemSelected()
    itemSelected = m.rowList.rowItemSelected
    m.top.selectedProfile = m.rowList.content.getChild(itemSelected[0]).getChild(itemSelected[1])
    m.top.setFocus(false)
end sub