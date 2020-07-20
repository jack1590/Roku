sub init()
    m.app = App()
    m.markupGrid = m.top.findNode("markupGrid")
    m.markupGrid.observeField("itemFocused", "onItemChanged")
    requestMenuInformation()
end sub

sub requestMenuInformation()
    m.readMarkupGridTask = createObject("roSGNode", "MenuContentTask")
    m.readMarkupGridTask.observeField("content", "showMarkupGrid")
    m.readMarkupGridTask.control = "RUN"
end sub

sub showMarkupGrid()
    m.markupGrid.content = m.readMarkupGridTask.content

end sub

sub onItemChanged()
    ?"######## ENTRO";m.markupGrid.itemFocused
end sub

sub expandMenu()
    m.markupGrid.itemSize = [ 300, 30 ]
    m.markupGrid.setFocus(true)
end sub

sub collapseMenu()
    m.markupGrid.itemSize = [ 55, 30 ]
    m.markupGrid.setFocus(false)
end sub