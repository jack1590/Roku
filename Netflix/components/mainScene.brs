sub init()
    m.profileScreen = m.top.findNode("profileScreen")
    m.principalScreen = m.top.findNode("principalScreen")

    m.profileScreen.visible = true
    m.principalScreen.visible = false
    m.profileScreen.setFocus(true)
    m.profileScreen.observeField("focusedChild", "onProfileFocusChanged" )
end sub

sub onProfileFocusChanged()
    if not m.profileScreen.isInFocusChain() then
        m.profileScreen.visible = false
        m.principalScreen.selectedProfile = m.profileScreen.selectedProfile
        m.principalScreen.visible = true
        m.principalScreen.setFocus(true)
    end if
end sub