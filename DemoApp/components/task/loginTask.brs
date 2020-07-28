sub init()
    m.top.functionName = "getToken"
    'port is used for sending post requests to webserver
	m.asyncMsgPort = CreateObject("roMessagePort")
end sub

sub getToken()
    m.app = App()
    url = m.app.api.host + m.app.api.login
    requestBody = {
        username: m.top.username,
        password: m.top.password
    }

    request = CreateObject("roUrlTransfer")
    request.SetMessagePort(m.asyncMsgPort)
    request.SetCertificatesFile("common:/certs/ca-bundle.crt")
    request.InitClientCertificates()
    request.addHeader("Content-Type", "application/json")
    request.setURL(url)

    didSend = request.asyncPostFromString(FormatJson(requestBody))
    requestId = request.GetIdentity().ToStr()
    response = handleResponse(didSend, requestId)

    if response <> invalid and response.token <> invalid then
        registrySection = CreateObject("roRegistrySection", "Transient")
        registrySection.Write("apiToken", response.token)
        registrySection.Flush()
        m.top.token = response.token
    else
        m.top.error = response.message
    end if
end sub

function handleResponse(didSend as boolean, requestId as string)
    if didSend then
		while (true)
			msg = wait(0, m.asyncMsgPort)

			if type(msg) = "roUrlEvent" and msg.GetInt() = 1 and requestId = msg.GetSourceIdentity().ToStr() then
				responseCode = msg.GetResponseCode()

				if responseCode = 200 then
					return parseJson(msg.getString())
				end if
			end if

			if msg = invalid then
				return invalid
			end if
		end while
	end if
end function