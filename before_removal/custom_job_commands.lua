local function zapEffect(target)
    local effectdata = EffectData()
    effectdata:SetStart(target:GetShootPos())
    effectdata:SetOrigin(target:GetShootPos())
    effectdata:SetScale(2)
    effectdata:SetMagnitude(1)
    effectdata:SetScale(2)
    effectdata:SetRadius(3)
    effectdata:SetEntity(target)
    for i = 1, 100 do
        util.Effect("TeslaHitBoxes", effectdata, true, true)
    end

    local Zap = math.random(1,9)
    if Zap == 4 then Zap = 3 end
    target:EmitSound("ambient/energy/zap" .. Zap .. ".wav")
end

local FoundationSpawn = Vector(-11238, 15377, -2821)

hook.Add("Initialize", "N_???Commands", function()

	DarkRP.defineChatCommand("level3norm", function(ply)

		if ply:Team() == TEAM_ONEIROI then

			if ply.proFoundation == true then
				ply:ChatPrint("[red]You may only use Pro Foundation commands once per life!")
				return
			end

			ply:SetPos(FoundationSpawn)
			ply.proFoundation = true
			zapEffect( ply )
			ply:GiveCleranceKeycard(3)
			ply:AddComms({"Foundation"})

			return
		end

		ply:ChatPrint("[red]You must be ??? in order to use this command!")

	end)

	DarkRP.defineChatCommand("level3res", function(ply)

		if ply:Team() == TEAM_ONEIROI then

			if ply.proFoundation == true then
				ply:ChatPrint("[red]You may only use Pro Foundation commands once per life!")
				return
			end

			ply:SetPos(FoundationSpawn)
			ply.proFoundation = true
			zapEffect( ply )
			ply:GiveCleranceKeycard(3)
			ply:AddComms({"Foundation", "Research"})

			return
		end

		ply:ChatPrint("[red]You must be ??? in order to use this command!")

	end)

	DarkRP.defineChatCommand("level3doea", function(ply)

		if ply:Team() == TEAM_ONEIROI then

			if ply.proFoundation == true then
				ply:ChatPrint("[red]You may only use Pro Foundation commands once per life!")
				return
			end

			ply:SetPos(FoundationSpawn)
			ply.proFoundation = true
			zapEffect( ply )
			ply:GiveCleranceKeycard(3)
			ply:AddComms({"Foundation", "Department of External Affairs"})

			return
		end

		ply:ChatPrint("[red]You must be ??? in order to use this command!")

	end)



	DarkRP.defineChatCommand("level4norm", function(ply)

		if ply:Team() == TEAM_ONEIROI then

			if ply.proFoundation == true then
				ply:ChatPrint("[red]You may only use Pro Foundation commands once per life!")
				return
			end

			ply:SetPos(FoundationSpawn)
			ply.proFoundation = true
			zapEffect( ply )
			ply:GiveCleranceKeycard(4)
			ply:AddComms({"Foundation"})

			return
		end

		ply:ChatPrint("[red]You must be ??? in order to use this command!")

	end)

	DarkRP.defineChatCommand("level4res", function(ply)

		if ply:Team() == TEAM_ONEIROI then

			if ply.proFoundation == true then
				ply:ChatPrint("[red]You may only use Pro Foundation commands once per life!")
				return
			end

			ply:SetPos(FoundationSpawn)
			ply.proFoundation = true
			zapEffect( ply )
			ply:GiveCleranceKeycard(4)
			ply:AddComms({"Foundation", "Research"})

			return
		end

		ply:ChatPrint("[red]You must be ??? in order to use this command!")

	end)

	DarkRP.defineChatCommand("level4admin", function(ply)

		if ply:Team() == TEAM_ONEIROI then

			if ply.proFoundation == true then
				ply:ChatPrint("[red]You may only use Pro Foundation commands once per life!")
				return
			end

			ply:SetPos(FoundationSpawn)
			ply.proFoundation = true
			zapEffect( ply )
			ply:GiveCleranceKeycard(4)
			ply:AddComms({"Foundation", "Foundation Administration"})

			return
		end

		ply:ChatPrint("[red]You must be ??? in order to use this command!")

	end)

	DarkRP.defineChatCommand("level4doea", function(ply)

		if ply:Team() == TEAM_ONEIROI then

			if ply.proFoundation == true then
				ply:ChatPrint("[red]You may only use Pro Foundation commands once per life!")
				return
			end

			ply:SetPos(FoundationSpawn)
			ply.proFoundation = true
			zapEffect( ply )
			ply:GiveCleranceKeycard(4)
			ply:AddComms({"Foundation", "Department of External Affairs"})

			return
		end

		ply:ChatPrint("[red]You must be ??? in order to use this command!")

	end)

	DarkRP.defineChatCommand("fevent", function(ply)

		if ply:Team() == TEAM_EVENTJOB then

			if ply.proFoundation == true then
				ply:ChatPrint("[red]You may only use Pro Foundation commands once per life!")
				return
			end

			ply:ChatPrint("Your event character has now become Pro Foundation (meaning you can be facescanned). To remove this effect, you must be killed, I recommend doing [ar]!sslay ^")
			ply.proFoundation = true
			zapEffect( ply )

			return
		end

		ply:ChatPrint("[red]You must be Event Job in order to use this command!")

	end)

end)


hook.Add( "PlayerDeath", "proF_Death", function(ply)
	if ply.proFoundation == true then 
		ply.proFoundation = false
	end
end)

hook.Add( "OnPlayerChangedTeam", "proF_Team_Change", function(ply)
	if ply.proFoundation == true then 
		ply.proFoundation = false
	end
end)

--AddComms({"Foundation", "Foundation Administration"})
print("Norra's custom_job_commands.lua has loaded. -[script] n_misc")