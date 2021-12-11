AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_marines/ammo_crate02_static.mdl")
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

	timer.Simple(900, function() 

    	SafeRemoveEntity(self)

	end)

end;

function ENT:Use(activator, ply)

	local Cooldown = 300

		if (ply.lastTouch and (ply.lastTouch + Cooldown) > CurTime()) then


			DarkRP.notify(ply, 1, 2, "Please wait 5 minutes before using the crate again.");

			ply:EmitSound("buttons/button16.wav", 75, 50 )


		return;

	end;	

	if ( !IsValid( activator ) ) then
		return
	end
	
		ply:Give("cw_ar15")
		ply:Give("cw_nen_glock17")
		DarkRP.notify( ply, 2, 4, "You've picked up a AR-15 and Glock-17!")
		ply:EmitSound( "items/ammo_pickup.wav" )

	ply.lastTouch = CurTime();
		
end;
