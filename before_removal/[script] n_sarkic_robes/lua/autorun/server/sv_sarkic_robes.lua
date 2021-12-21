local CiviModel = {

    "models/kayf/humans/group01/male_01.mdl",
    "models/kayf/humans/group01/male_02.mdl",
    "models/kayf/humans/group01/male_03.mdl",
    "models/kayf/humans/group01/male_07.mdl",
    "models/kayf/humans/group01/male_09.mdl",
    "models/kayf/humans/group02/male_04.mdl",
    "models/kayf/humans/group02/male_05.mdl",
    "models/kayf/humans/group01/female_04.mdl",
    "models/kayf/humans/group01/female_07.mdl",
    "models/kayf/humans/group01/female_03.mdl",
    "models/kayf/humans/group01/female_01.mdl",

}

hook.Add("Initialize", "SarkicRobe", function()

	DarkRP.defineChatCommand("robeon", function(ply)

		if ply:Team() == TEAM_EVENTJOB then
			
			ply:SetModel("models/player/viz/cultsquids/pm_cultist.mdl")
			ply:ChatPrint("[red]You have put on robes. Do /robeoff to remove.")
			ply:EmitSound("physics/flesh/flesh_impact_hard4.wav", 60)

			return
		end
	
		ply:ChatPrint("[red]You must be a Sarkic Cultist in order to use this command!")

	end);


	DarkRP.defineChatCommand("robeoff", function(ply)

		if ply:Team() == TEAM_EVENTJOB then
			
			ply:SetModel(CiviModel[math.random(1, #CiviModel)]);
			ply:ChatPrint("[red]You have taken off your robes.")
			ply:EmitSound("physics/flesh/flesh_impact_hard4.wav", 60)

			return
		end
	
		ply:ChatPrint("[red]You must be a Sarkic Cultist in order to use this command!")
	
	end);


end);

print("Norra's sv_sarki_robes has loaded. -[script] n_sarkic_robes")