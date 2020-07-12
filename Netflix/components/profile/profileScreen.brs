sub init()
    m.app = App()
    m.label = m.top.findNode("questionLabel")
    m.rowList = m.top.findNode("rowlist")
    m.isPosterSelected = true

    requestProfileInformation()
    setInitialValues()
end sub

sub setInitialValues()
    m.label.font = m.app.fonts.large
    m.label.width = m.app.uiResolution.width
   
    m.rowList.setFocus(true)
end sub

sub requestProfileInformation()
    m.readPosterGridTask = createObject("roSGNode", "ProfileContentTask")
    m.readPosterGridTask.observeField("content", "showRowList")
    m.readPosterGridTask.control = "RUN"
end sub

sub showRowList()
    m.rowList.content = m.readPosterGridTask.content
    ' calculate the space between ( left margin < - > rowlist < - >right margin)
    axisX = ((m.app.uiResolution.width - 1300) / 2)
    m.rowList.translation = [axisX, 500]
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
    m.isPosterSelected = not m.isPosterSelected
    m.rowList.content.getChild(0).getChild(itemFocused).isPosterSelected = m.isPosterSelected
end sub

