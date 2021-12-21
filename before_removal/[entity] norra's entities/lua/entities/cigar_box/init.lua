AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/SuitCase_Passenger_Physics.mdl")
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

	self:SetSubMaterial(0, "models/werwolf/aptstairs/woodstair002c")
	self:SetModelScale(0.5)
	self:SetColor( Color(188,188,188,255) )
	self:SetCollisionGroup(15)


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
		
	};
	
	if ( table.HasValue(teams, team.GetName( player:Team() ) ) ) then
	
		self:EmitSound("player/suit_denydevice.wav")
		
        return
    end
	
	
	local cigarettes = {
		
		"weapon_ciga_cheap",
		"weapon_ciga",
		"weapon_ciga_blat"
	};
	
	local cigarettes = table.Random(cigarettes);
	
	
		player:Give(cigarettes, false)
		
		player:Say("/me takes a " .. cigarettes .. "out of the box.")
		player:EmitSound( "player/footsteps/woodpanel2.wav" )
		
		SafeRemoveEntity( self );
end