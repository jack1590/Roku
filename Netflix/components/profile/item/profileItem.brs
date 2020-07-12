sub init()
    m.app = App()
    m.itemPoster = m.top.findNode("itemPoster")
    m.title = m.top.findNode("title")
    m.editImagePoster = m.top.findNode("editImagePoster")
    m.focusedBackground = m.top.findNode("focusedBackground")

    m.focusedBackground.uri = m.app.design.images.focusedProfile
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
        if m.item.isPosterSelected then
            m.focusedBackground.visible = true
            m.editImagePoster.uri = m.app.design.images.editProfile
            m.editImagePoster.visible = true
        else
            m.focusedBackground.visible = false
            m.editImagePoster.uri = m.app.design.images.editProfileActive
            m.editImagePoster.visible = true
        end if
    else 
        m.focusedBackground.visible = false
        m.editImagePoster.visible = false
        m.item.isPosterSelected = true
    end if
end sub