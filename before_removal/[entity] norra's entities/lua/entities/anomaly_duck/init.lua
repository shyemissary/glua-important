AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/vinrax/props/rubber_duck.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:Wake()
		physObj:EnableMotion(true)
	end;

	self:SetNWBool("HasBeenTouched", false)

end;

function ENT:Use(ply)
	
	if ( self:IsPlayerHolding() ) then 
		return 
	end

	ply:PickupObject( self )

	self:EmitSound("anomaly_duck/duck_squeak.mp3")

	if ( !self:GetNWBool("HasBeenTouched") ) then
		
		self:SetNWBool("HasBeenTouched", true)

--------------------

		timer.Simple(5, function()

			DarkRP.notify(ply, 1, 2, "I feel sick.")

		end)

		timer.Simple(7, function()

			ply:EmitSound("npc/barnacle/barnacle_tongue_pull3.wav")

		end)	


		timer.Simple(7.5, function()

			ply:TakeDamage(14)

		end)

--------------------

		timer.Simple(17, function()

			ply:EmitSound("npc/barnacle/barnacle_digesting2.wav")

		end)	


		timer.Simple(18, function()

			ply:EmitSound("vo/npc/male01/moan0".. math.random(1, 3) ..".wav")
			ply:TakeDamage(33)

		end)
		
--------------------

		timer.Simple(25, function() 

			local target = self

			local damage = DamageInfo()
			damage:SetDamage( math.huge )
			damage:SetDamageType( DMG_DISSOLVE )
			damage:SetDamageForce( Vector(0, 1, 0) )
		
			target:TakeDamageInfo( damage )
			
			local dissolver = ents.Create("env_entity_dissolver")
			dissolver:SetKeyValue("dissolvetype", 2)
			dissolver:SetKeyValue("magnitude", 0)
			dissolver:SetPos(Vector(0, 0, 0))
			dissolver:Spawn()
			
			target:SetName("TARGET_NOFUCKOFF")
					
			dissolver:Fire("Dissolve", target:GetName())
			dissolver:Fire("Kill", "", 0)

			self:EmitSound("weapons/physcannon/energy_disintegrate5.wav", 70, 100, 1)
			self:OnRemove()
		end)
	end
end
