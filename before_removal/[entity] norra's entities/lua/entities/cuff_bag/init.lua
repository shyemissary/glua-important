AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/gta iv/duffle_bag.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:SetMass( 5 )
		physObj:Wake()
		physObj:EnableMotion(true)
	end;
end;

function ENT:Use(activator, player)

	if ( !IsValid( activator ) ) then
		return
	end

	local teams = {
		
		"Staff on Duty",
		"SCP-096",
		"SCP-049",
		"SCP-1048",
		"SCP-939",
		"SCP-173",
		"SCP-457",
		"SCP-106",
		"SCP-999",
		"SCP-1370",
		"SCP-913",
		"SCP-087-II",
		"SCP-035",
		"SCP-008-II",
		"SCP-682",
		"Paramedic",
		"Engineer",
		"Service Personnel",
		"Junior Researcher",
		"Senior Researcher",
		"Head Researcher",
		"O5 Council Member",
		"Site Director",
		"Site Advisor",
		"Head of External Affairs",
		"IT Technician",
		"Cafeteria Worker",
		"Anderson Robotics Peregrine Droid"
		
	};
	
	local jobs = {
	
		"SCP-049-2",
		"SCP-008-II",
		"Anomaly",
		"Sarkic Abomination",
		"MTF Omega-12",
		"016-2",
		"Werewolf",
		"SCP-2191-2",
		"SCP-2191-3",
		"Nobody"
		
	};
	
	if ( table.HasValue(teams, team.GetName( player:Team() ) ) ) then
	
		self:EmitSound("player/suit_denydevice.wav")
		
        return
    end
	
	if ( table.HasValue( jobs, player:getDarkRPVar("job" ) ) ) then
		
		self:EmitSound("player/suit_denydevice.wav")
		
		return false
	end
	
	if player:GetNWBool( "cuffs" ) then
	
		DarkRP.notify( player, 2, 4, "You've already purchased cuffs!")
		self:EmitSound("player/suit_denydevice.wav")
		
		return
	end
	
	local weaponlist = {
		
		"weapon_cuff_capture",
		"weapon_cuff_elastic",
		"weapon_cuff_police",
		"weapon_cuff_rope",
		"weapon_cuff_shackles",
		"weapon_cuff_tactical"
	};
	
	local selectedweapon = table.Random(weaponlist);
	
	
		player:Give(selectedweapon, false)
		
		DarkRP.notify( player, 2, 4, "You have picked up a " .. selectedweapon .. "!")
		player:EmitSound( "items/ammo_pickup.wav" )
		
		player:SetNWBool("cuffs", true)
		
		SafeRemoveEntity( self );
end