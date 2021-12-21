hook.Add("Initialize", "ToggleULXLogEcho", function()
	DarkRP.defineChatCommand("toggleecho", function(ply)
    
    	if not ply:CheckGroup("superadmin") then --Checks if they have the superadmin rank
    		ply:ChatPrint("[red]You are not allowed to use this command!")

    		return end

    	if not echo then --Checks if the boolean is true, if its false then it moves down to the else

    		ply:ChatPrint("[red]ULX Log Echo has been turned off!")
    		RunConsoleCommand("ulx_logecho", "0") --Turns off logecho
			RunConsoleCommand( "ulx", "asay", "[Logecho] " .. ply:Name() .. " has turned off ULX Logecho - SteamID: " .. ply:SteamID() .. ""); -- This informs staff chat

        	echo = true --Makes the boolean true
    	else

    		ply:ChatPrint("[green]ULX Log Echo has been turned on!")
    		RunConsoleCommand("ulx_logecho", "2") --Turns on logecho
			RunConsoleCommand( "ulx", "asay", "[Logecho] " .. ply:Name() .. " has turned on ULX Logecho - SteamID: " .. ply:SteamID() .. ""); -- This informs staff chat

        	echo = not echo --This inverts the boolean
    	end
	end)
end)

print("Turning on ulx_logecho 2... -[script] n_toggle_ulx_logecho")
RunConsoleCommand("ulx_logecho", "2") --When the server starts, it will turn logecho to 2.
print("Norra's sv_togglelogecho.lua has loaded. -[script] n_toggle_ulx_logecho")