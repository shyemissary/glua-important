AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/bkeypads/keycard.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:Wake()
		physObj:EnableMotion(true)
	end;
	
end;

function ENT:Use(activator, ply)
	local cooldown = 6
	

	if ( !IsValid( ply ) ) then
		return
	end
	
	if (ply.lastUse and (ply.lastUse + cooldown) > CurTime()) then	
		return;
	end;
		
	local jobs = {
		"SCP-049-2",
		"SCP-008-II",
		"016-2",
		"Werewolf",
		"SCP-2191-2",
		"SCP-2191-3",
		"Nobody",
		"Anomaly"
	};

	local teams = {
		"Class D Personnel"
	};
	
	if ( table.HasValue( jobs, ply:getDarkRPVar("job" ) ) ) then
		return
	end;
	
	if ( !table.HasValue( teams, team.GetName( ply:Team() ) ) ) then 
		return 
	end;
	
	if IsValid( ply ) then
		ply:Give("bkeycard")
		ply:Give("keys")
		ply:ChatPrint("With this keycard, I can open the airlock doors.")
	end
	
	ply.lastUse = CurTime()
	SafeRemoveEntity( self )
	
end