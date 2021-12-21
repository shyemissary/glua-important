AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:StartMusicSound()
    self.sound = CreateSound(self, Sound("music/radio1.mp3"))
    self.sound:SetSoundLevel(75)
    self.sound:PlayEx(1, 100)
end

function ENT:OnRemove()
	self.isPlaying = false
	if	self.sound then
        self.sound:Stop()
	end
end

function ENT:Initialize()
	self:SetModel("models/sligwolf/grocel/radio/gramophone.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:Wake()
		physObj:EnableMotion(true)
	end

    self.isPlaying = false
    self.TotalHealth = 100
    self.isDestroyed = false

end 

function ENT:OnTakeDamage( dmg )
	if ( !IsValid( self ) ) then
		return
	end

	if self.isDestroyed == true then 
		return 
	end

	local att = dmg:GetAttacker()

	if ( !IsValid( att ) ) then
		return
	end

	if ( !att:IsPlayer() ) then
		return
	end

	self:GetPhysicsObject():AddVelocity(dmg:GetDamageForce() * 0.02)

	self.TotalHealth = self.TotalHealth - math.random( 20, 30 )

	local pos = self:GetPos()

	local ED = EffectData()
	ED:SetOrigin(pos)
		
	util.Effect("StunstickImpact", ED)
	self:EmitSound("ambient/levels/prison/radio_random2.wav")

	if ( self.TotalHealth <= 0 ) then

		self.isDestroyed = true
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
		return
	end
end

function ENT:Use(ply)

	if self.isPlaying == false then

		self:EmitSound("npc/turret_floor/click1.wav")
		self.isPlaying = true
		timer.Simple(0.3, function()
		if ( !IsValid( self ) ) then
			return
		end	
			if self.isPlaying == false then
				return 
			end
			self:StartMusicSound()
		end)

		timer.Simple(25, function()
		if ( !IsValid( self ) ) then
			return
		end	
			if self.isPlaying == false then
				return 
			end

			local range = 120
			for k,v in pairs(ents.FindInSphere(self:GetPos(), range)) do 
				if v:IsPlayer() then
					v:ChatPrint("[red]Your stomach feels upset.")
					v:SetNWBool("SCP513Enabled", true)
					net.Start( "DarkRP_Animations" );
	    				net.WriteEntity( v );
	    				net.WriteInt( ACT_GMOD_GESTURE_BOW, 16 );
					net.Broadcast();
					timer.Simple(0.3, function()
						v:EmitSound("vo/npc/male01/moan0".. math.random(1, 5).. ".wav")
					end)
				end		
			end
		end)

		timer.Simple(38, function()
		if ( !IsValid( self ) ) then
			return
		end	
			if self.isPlaying == false then
				return 
			end
			self:EmitSound("npc/turret_floor/click1.wav")
			self.sound:Stop()
			self.isPlaying = false
		end)

	else

		self:EmitSound("npc/turret_floor/click1.wav")
		self.sound:Stop()
		self.isPlaying = false 
	end
end
