sub init()
   m.app = App()
   m.loginView = m.top.findNode("loginView")
   m.homeView = m.top.findNode("homeView")
   m.busyspinner = m.top.findNode("busySpinner")
   m.infoView = m.top.findNode("infoView")

   m.busyspinner.poster.loadSync = true
   m.busyspinner.poster.uri = m.app.design.images.spinner

   m.loginView.setFocus(true)

   setInitialValues()
end sub

sub setInitialValues()
   centerx = (m.app.uiResolution.width - m.busyspinner.poster.bitmapWidth) / 2
   centery = (m.app.uiResolution.height - m.busyspinner.poster.bitmapHeight) / 2
   m.busyspinner.translation = [centerx, centery]

   registrySection = CreateObject("roRegistrySection", "Transient")
   token = registrySection.read("apiToken").toStr()
   if token <> invalid and token <> "" then
      m.global.addFields({token: token})
      showHomeView()
   end if
end sub

sub showSpinner(id)
   if id <> invalid then m[id].visible = false
   m.busyspinner.visible = true
end sub

sub showHomeView()
   m.loginView.visible = false
   m.homeView.visible = false
   m.busyspinner.visible = true

   m.requestApiTask = CreateObject("roSGNode", "RequestAPITask")
   m.requestApiTask.observeField("output", "onContentReady")
   m.requestApiTask.action = m.app.api.home.action
end sub

sub displayInfo(id as string, title as string, description as string)
   m.busyspinner.visible = false
   m.infoView.title = title
   m.infoView.description = description
   m.infoView.visible = true
   m.infoView.previousView = id
end sub

sub onContentReady()
   content = m.requestApiTask.output.content
   m.homeView.content = content
   m.loginView.visible = false
   m.homeView.visible = true
   m.busyspinner.visible = false
end sub

'-----------------------------
' Deep link implementation
'-----------------------------

sub handleDeeplink()
   ?"[Log Info] Handle deeplink: ";m.top.deeplink
    deeplink = m.top.deeplink
    seriesCategory = m.app.design.series.category 
    movieCategory = m.app.design.movies.category 

    if deeplink <> invalid then
        if deeplink.mediaType = seriesCategory or deeplink.mediaType = movieCategory then
            m.homeView.deeplink = deeplink
        else
            ?"[Log error] Deep link with media type ";deeplink.mediaType;" not supported yet!"
        end if
    end if
end sub

'-----------------------------
' Key handling
'-----------------------------

function onKeyEvent(key as string, press as boolean) as boolean
   handled = false
   if press then
      if key = "OK" and m.infoview.isInFocusChain() then
         handled = true
         id = m.infoView.previousView
         m.infoView.visible = false
         m[id].visible = true
      end if
   end if
   return handled
end function
