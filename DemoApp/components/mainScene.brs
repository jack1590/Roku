sub init()
   m.app = App()
   m.loginView = m.top.findNode("loginView")
   m.busyspinner = m.top.findNode("busySpinner")
   m.busyspinner.poster.uri = m.app.design.images.spinner
   m.loginView.setFocus(true)

end sub

sub showSpinner(id)
   m[id].visible = false
   centerx = (m.app.uiResolution.width - m.busyspinner.poster.bitmapWidth) / 2
   centery = (m.app.uiResolution.height - m.busyspinner.poster.bitmapHeight) / 2
   m.busyspinner.translation = [ centerx, centery ]
   m.busyspinner.visible = true
end sub

sub hideSpinner()
   m.busyspinner.visible = false
end sub