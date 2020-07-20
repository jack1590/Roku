sub init()
    m.app = App()
    m.config = m.app.profileConfig
    m.itemPoster = m.top.findNode("itemPoster")
    m.title = m.top.findNode("title")
    m.editImagePoster = m.top.findNode("editImagePoster")
    m.focusedBackground = m.top.findNode("focusedBackground")
    m.layoutGroup = m.top.findNode("infoGroup")

    setInitialValues()
end sub

sub setInitialValues()
    m.focusedBackground.uri = m.app.design.images.focusedProfile
    m.focusedBackground.width = m.config.item.posterSize + 40
    m.focusedBackground.height = m.config.item.posterSize + 40

    m.layoutGroup.translation = m.config.item.layoutTranslation
    m.layoutGroup.itemSpacings = m.config.item.layoutSpacings

    m.itemPoster.width = m.config.item.posterSize
    m.itemPoster.height = m.config.item.posterSize

    m.editImagePoster.width = 70
    m.editImagePoster.height = 70
    m.editImagePoster.uri = m.app.design.images.editProfile
    m.editImagePoster.visible = false
end sub

sub onItemContentChanged()
    m.item = m.top.itemContent
    m.title.text = m.item.title
    m.itemPoster.uri = m.item.HDPosterUrl
    m.item.observeField("isPosterSelected", "onItemHasFocus")
end sub

sub onItemHasFocus()
    if m.top.focusPercent > 0.5 then 
       focusCustomElement()
    else 
        m.focusedBackground.visible = false
        m.editImagePoster.visible = false
        m.item.isPosterSelected = true
    end if
end sub

'----------------------------------------------------------------------
' This function stablish if the image is the selected or the edit icon 
'----------------------------------------------------------------------
sub focusCustomElement()
    m.focusedBackground.visible = m.item.isPosterSelected
    m.editImagePoster.uri = m.app.design.images.editProfile
    if not m.item.isPosterSelected then m.editImagePoster.uri = m.app.design.images.editProfileActive
    m.editImagePoster.visible = true
end sub