hook.Add( "PlayerDeath", "N_Hook_Death", function(ply)

	if vSCPs.gunCount == 1 then

		vSCPs.gunCount = 0 
	end
	
	if vSCPs.scrapCount == 1 then

		vSCPs.scrapCount = 0
	end

	if isSCP3114 == true then

		isSCP3114 = false
	end

	if ply:GetNWBool("hasAugment") then

		ply:SetNWBool("hasAugment", false);
   end

	if ply:GetNWBool("isUpgradedDroid") then

		ply:SetNWBool("isUpgradedDroid", false);
    end

end)

hook.Add( "OnPlayerChangedTeam", "N_Hook_Change_Team", function(ply)

	if vSCPs.gunCount == 1 then

		vSCPs.gunCount = 0
	end
	
	if vSCPs.scrapCount == 1 then

		vSCPs.scrapCount = 0
	end

	if isSCP3114 == true then

		isSCP3114 = false
	end	

	if ply:GetNWBool("hasAugment") then

		ply:SetNWBool("hasAugment", false);
   end

	if ply:GetNWBool("isUpgradedDroid") then

		ply:SetNWBool("isUpgradedDroid", false);
    end

end)

print("Norra's norras_reset_hooks has loaded. -[script] n_misc")