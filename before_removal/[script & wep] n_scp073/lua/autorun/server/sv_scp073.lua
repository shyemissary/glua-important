hook.Add( "PlayerShouldTakeDamage", "SCP073_Hook", function( ply, attacker )
	if ply:Team() == TEAM_SCP073 then		
		

		attacker:TakeDamage(14)

	end
end)

print("Norra's sv_scp073 has loaded. -[script] n_scp073")