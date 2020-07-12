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
    axisX = ((m.app.uiResolution.width - m.rowList.boundingRect().width) / 2) + 50
    m.rowList.translation = [axisX, 500]
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
  handled = false
  if press then
    itemFocused = m.rowList.rowItemFocused[1]
    if key = "down" then
        handled = true
        m.isPosterSelected = false
        m.rowList.content.getChild(0).getChild(itemFocused).isPosterSelected = false
    else if key = "up" then
        handled = true
        m.isPosterSelected = true
        m.rowList.content.getChild(0).getChild(itemFocused).isPosterSelected = true
    end if
  end if
  return handled
end function

