AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:ReconstrucingSound()
    self.sound2 = CreateSound(self, Sound("ambient/machines/transformer_loop.wav"))
    self.sound2:SetSoundLevel(75 )
    self.sound2:PlayEx(1, 100)
end

function ENT:NeedSound()
    self.sound3 = CreateSound(self, Sound("buttons/button10.wav"))
    self.sound3:SetSoundLevel(65)
    self.sound3:PlayEx(1, 100)
end

function ENT:AcceptSound()
    self.sound4 = CreateSound(self, Sound("buttons/combine_button_locked.wav"))
    self.sound4:SetSoundLevel(65)
    self.sound4:PlayEx(1, 100)
end

function ENT:OnRemove()
	if self.sound2 then
	    self.sound2:Stop()
	end
end

function ENT:Initialize()
	self:SetModel("models/props_c17/trappropeller_engine.mdl")

-------------------------------------------------------------------------
	
	local plate = ents.Create( "prop_physics" )
	
	local oang1 = self:GetAngles()
	local opos1 = self:GetPos()
	local ang1 = self:GetAngles()
	local pos1 = self:GetPos()

	ang1:RotateAroundAxis( oang1:Up(), 0 )
	ang1:RotateAroundAxis( oang1:Right(), 90 )
	ang1:RotateAroundAxis( oang1:Up(), 0)

	pos1 = pos1 + oang1:Forward()*7 + oang1:Up() * -15.5 + oang1:Right() * 9.5
		
		plate:SetModel("models/squad/sf_plates/sf_plate1x2.mdl")
		plate:SetPos( pos1 )
		plate:SetAngles( ang1 )
		plate:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
		plate:SetModelScale( 1.2 )
		plate:SetParent( self )
		plate:SetMaterial("metal2")
		plate:Spawn()
		
-------------------------------------------------------------------------
-------------------------------------------------------------------------
	
	local shelf = ents.Create( "prop_physics" )
	
	local oang2 = self:GetAngles()
	local opos1 = self:GetPos()
	local ang2 = self:GetAngles()
	local pos2 = self:GetPos()

	ang2:RotateAroundAxis( oang2:Up(), 0 )
	ang2:RotateAroundAxis( oang2:Right(), 0 )
	ang2:RotateAroundAxis( oang2:Up(), 0)

	pos2 = pos2 + oang2:Forward()*1 + oang2:Up() * 14 + oang2:Right() * 2.2
		
		shelf:SetModel("models/props_phx/gears/bevel9.mdl")
		shelf:SetPos( pos2 )
		shelf:SetAngles( ang2 )
		shelf:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
		shelf:SetParent( self )
		shelf:SetMaterial("metal2")
		shelf:Spawn()
		
-------------------------------------------------------------------------



	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetColor( Color (175, 175, 175, 125) )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass( 200 )
		phys:Wake()
	end
	self:SetUseType(SIMPLE_USE)
	self:SetHasAnomaly(false)
	self:SetisWorking(false)	
	self:SetisReady(false)	

    self.isWorking = false
	self.isReady = false

    self.entHealth = 10
end


function ENT:Touch(toucher)
	if IsValid(toucher) then
		if self:GetHasAnomaly() then
				self:SetisReady(true)
		elseif toucher:GetClass() == "anomaly_orb" and !self:GetHasAnomaly() then
			self:SetHasAnomaly(true)
			self:EmitSound("physics/metal/metal_box_footstep1.wav")
			SafeRemoveEntity(toucher)
-------------------------------------------------------------------------
	
			reconstructorOrb = ents.Create( "prop_physics" )
	
			local orboang1 = self:GetAngles()
			local orbopos1 = self:GetPos()
			local orbang1 = self:GetAngles()
			local orbpos1 = self:GetPos()

			orbang1:RotateAroundAxis( orboang1:Up(), 0 )
			orbang1:RotateAroundAxis( orboang1:Right(), 90 )
			orbang1:RotateAroundAxis( orboang1:Up(), 0)

			orbpos1 = orbpos1 + orboang1:Forward()*1 + orboang1:Up() * 25.5 + orboang1:Right() * 2.2
		
				reconstructorOrb:SetModel("models/maxofs2d/hover_rings.mdl")
				reconstructorOrb:SetPos( orbpos1 )
				reconstructorOrb:SetAngles( orbang1 )
				reconstructorOrb:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
				reconstructorOrb:SetModelScale( 0.9 )
				reconstructorOrb:SetParent( self )
				reconstructorOrb:SetMaterial("models/props_combine/portalball001_sheet")
				reconstructorOrb:Spawn()
		
-------------------------------------------------------------------------
		end
	end
end

function ENT:Use(activator, caller)
	if IsValid(caller) and caller:IsPlayer() and self.isWorking == false then
		if self:GetHasAnomaly() then
			if (timer.Exists("Worktime"..self:EntIndex())) then
				DarkRP.notify(activator, 0,  3, "The anomaly is being reconstructed.")
				return;
			end
		
			DarkRP.notify(activator, 0,  3, "The anomaly will now begin reconstruction!")
			self:ReconstrucingSound()
			self:AcceptSound()
			isWorking = true
			self:SetisWorking(true)
			delay = 120	// Random Probe processing time
			
		// Random Probe Settings
		timer.Create( "Worktime"..self:EntIndex(),delay, 1, function()
		self.sound2:Stop()
		self:SetHasAnomaly(false)
		self.isWorking = false
		self:SetisWorking(false)
		self:SetisReady(false)
		local entorb = ents.Create("reconstructed_orb")
		entorb:SetPos(self:GetPos() + Vector(0, 0, 25,1))
		entorb:Spawn()
		self:EmitSound("npc/roller/mine/rmine_chirp_answer1.wav", 75, 80)
		reconstructorOrb:Remove()
	end )		

	else
			DarkRP.notify(activator, 1,  3, "You require an anomaly to begin reconstructing!")
			self:NeedSound()
		end
	end
end


		



