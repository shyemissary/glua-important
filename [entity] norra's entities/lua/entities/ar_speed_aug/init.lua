AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/items/combine_rifle_cartridge01.mdl")

-------------------------------------------------------------------------
	
	local plate = ents.Create( "prop_physics" )
	
	local oang1 = self:GetAngles()
	local opos1 = self:GetPos()
	local ang1 = self:GetAngles()
	local pos1 = self:GetPos()

	ang1:RotateAroundAxis( oang1:Up(), 0 )
	ang1:RotateAroundAxis( oang1:Right(), -61 )
	ang1:RotateAroundAxis( oang1:Up(), 0)

	pos1 = pos1 + oang1:Forward()*-2 + oang1:Up() * 1.7 + oang1:Right() * 0
		
		plate:SetModel("models/props_combine/breenlight.mdl")
		plate:SetPos( pos1 )
		plate:SetAngles( ang1 )
		plate:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
		plate:SetModelScale( 0.4 )
		plate:SetParent( self )
		plate:Spawn()
		plate:DrawShadow(false)
		
-------------------------------------------------------------------------

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
		"SCP-073",
		"Engineer",
		"Head Researcher",
		"O5 Council Member",
		"Site Director",
		"Site Advisor",
		"Broken Church Construct",
		"Primordial Contractor",
		"IT Technician",
		"Cafeteria Worker",
		"Anderson Robotics Salesman",
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
	
		DarkRP.notify( player, 2, 4, "You can't pick up this Augment!")
		self:EmitSound("player/suit_denydevice.wav")
		
        return
    end
	
	if ( table.HasValue( jobs, player:getDarkRPVar("job" ) ) ) then
		
		DarkRP.notify( player, 2, 4, "You can't pick up this Augment!")
		self:EmitSound("player/suit_denydevice.wav")
		
		return false
	end
	
	if player:GetNWBool( "hasAugment" ) then
	
		DarkRP.notify( player, 2, 4, "You already have an Augment installed!")
		self:EmitSound("player/suit_denydevice.wav")
		
		return
	end
	
	player:EmitSound("npc/scanner/cbot_servoscared.wav", 75, 110)
	player:Say("/me installs the Augment onto themselves.")
	SafeRemoveEntity( self );

	timer.Simple(3, function()
	
		player:SetWalkSpeed(180)
		player:SetRunSpeed(260)
		player:EmitSound( "buttons/button5.wav")
		player:ChatPrint("[ar]You have now installed the Anderson Robotics Speed Augment!")
		player:SetNWBool("hasAugment", true)

	end)
end