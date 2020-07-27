sub init()
    m.app = App()
    m.poster = m.top.findNode("poster")
    m.playButton = m.top.findNode("playButton")
    m.layoutGroup = m.top.findNode("layoutGroup")
    m.title = m.top.findNode("title")
    m.description = m.top.findNode("description")
    m.videoPlayer = m.top.findNode("videoPlayer")
    m.videoPlayer.notificationInterval = 5
    m.videoPlayer.observeField("position", "onPositionChanged")
    m.errorDialog = m.top.findNode("errorDialog")
    m.timer = m.top.findNode("timer")
    m.config = Config()

    setInitialValues()
end sub

function Config() as object
    return {
        title: "Detail"
        posterHeight: 600,
        topMargin: 450,
        iconWidth: 128,
        iconHeight: 96,
        videoPlayerColor: "0xE9FF70",
        translation: [m.app.design.home.translationX, m.app.design.home.translationY]
    }
end function

sub setInitialValues()
    m.layoutGroup.translation = m.Config.translation
    m.poster.height = m.config.posterHeight

    m.videoPlayer.width = m.app.uiResolution.width
    m.videoPlayer.height = m.app.uiResolution.height
    m.videoPlayer.trickPlayBar.filledBarBlendColor = m.config.videoPlayerColor
    m.videoPlayer.bufferingBar.filledBarBlendColor = m.config.videoPlayerColor
    m.videoPlayer.retrievingBar.filledBarBlendColor = m.config.videoPlayerColor

    ' Fonts
    m.title.font = m.app.fonts.large
    m.description.font = m.app.fonts.medium
    m.errorDialog.titleFont = m.app.fonts.large
    m.errorDialog.messageFont = m.app.fonts.medium
end sub

sub onItemContentChanged()
    itemContent = m.top.itemContent
    newDimension = m.poster.width.toStr() + "x" + m.poster.height.toStr()
    baseUri = itemContent.HDPosterUrl
    baseUri = baseUri.toStr().replace(itemContent.size,  newDimension)

    if itemContent <> invalid then
        m.poster.uri = baseUri
        m.title.text = itemContent.title
        description = itemContent.description
        if description <> invalid and description <> "" then m.description.text = description

        showPlayButton()
    end if
end sub

sub showPlayButton()
    m.playButton.uri = m.app.design.images.play
    m.playButton.width = m.config.iconWidth
    m.playButton.height = m.config.iconHeight

    x = (m.poster.width / 2) - (m.playButton.width / 2)
    y = (m.poster.height / 2) - (m.playButton.height / 2)
    m.playButton.translation = [x, y]

    m.playButton.visible = true
    m.playButton.setFocus(true)
end sub

sub playContent()
    itemContent = m.top.itemContent
    if itemContent <> invalid then
        m.requetsApiTask = CreateObject("roSGNode", "RequestApiTask")
        m.requetsApiTask.observeField("output", "onStreamContentReady")
        m.requetsApiTask.input = itemContent.id
        m.requetsApiTask.action = m.app.api.video.action
    end if
end sub

sub onStreamContentReady()
    m.requetsApiTask.unobserveField("output")
    streamInfo = m.requetsApiTask.output
    streamInfo.id = m.requetsApiTask.input

    if streamInfo <> invalid then
        setContentToVideoPlayer(streamInfo)
    end if

    m.channelsApiTask = invalid
end sub

sub setContentToVideoPlayer(streamInfo)
    contentNode = createObject("roSGNode", "contentNode")
    contentNode.streamFormat = streamInfo.videoType
    contentNode.url = streamInfo.videoUrl
    contentNode.id = streamInfo.id
    playbackPosition = getPlaybackPosition(streamInfo.id)

    m.videoPlayer.content = contentNode
    if playbackPosition <> invalid then m.videoPlayer.seek = playbackPosition
    m.videoPlayer.control = "play"
    m.videoPlayer.visible = true
    m.videoPlayer.setFocus(true)

    m.videoPlayer.observeField("state", "onVideoStateChanged")
end sub

sub onVideoStateChanged()
    videoState = m.videoPlayer.state
    if videoState = "finished" or (videoState = "playing" and m.videoPlayer.errorCode = 0) then
        m.videoPlayer.unobserveField("state")
    else if videoState = "error" then
        stopAndHideVideo()
        showErrorDialog()
    end if
end sub

sub showErrorDialog()
    m.errorDialog.title = m.app.messages.playFailed
    m.errorDialog.message = m.app.messages.playFailedMessage
    m.errorDialog.visible = true
    m.timer.observeField("fire", "dismissDialog")
    m.timer.control = "start"
end sub

sub dismissDialog()
    m.errorDialog.visible = false
    m.timer.unobserveField("fire")
    m.top.setFocus(true)
end sub

sub onPositionChanged()
    savePlaybackPosition()
end sub


sub savePlaybackPosition()
    positionPlaybackRS = CreateObject("roRegistrySection", "PostionPlayback")
    positionPlaybackRS.Write(m.videoPlayer.content.id, m.videoPlayer.position.toStr())
    positionPlaybackRS.Flush()
end sub

function getPlaybackPosition(contentId as string) as integer
    positionPlaybackRS = CreateObject("roRegistrySection", "PostionPlayback")
    return positionPlaybackRS.read(contentId).toInt()
end function

sub stopAndHideVideo()
    m.videoPlayer.setFocus(false)
    m.videoPlayer.visible = false
    m.videoPlayer.control = "stop"
end sub

'-----------------------------
' Key handling
'-----------------------------

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false

    if press then
        if key = "OK" or key = "play" then
            playContent()
        else if key = "back" and m.videoPlayer.hasFocus() then
            stopAndHideVideo()
            m.top.visible = true
            m.top.setFocus(true)
            handled = true
        end if
    end if
    return handled
end function