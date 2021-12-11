AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/squad/sf_bars/sf_bar1.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:Wake()
		physObj:EnableMotion(true)
	end;

	self:SetMaterial("grey")
	self:SetColor( Color(232,185,44,255) )

end;

function ENT:Use(activator, ply)
	
	local Cooldown = 30

	if (self.lastTouch and (self.lastTouch + Cooldown) > CurTime()) then

		DarkRP.notify(ply, 1, 2, "You can't see the light too.")

		return
	end	

	if not IsFirstTimePredicted() then 
        return 
    end

	if ( !IsValid( activator ) ) then
		return
	end
	
	local range = 250

	
	for k,v in pairs(ents.FindInSphere(self:GetPos(), range)) do 
		if v:IsPlayer() then
			v:PrintMessage(HUD_PRINTTALK, "[white]Endure ".. ply:GetName() .." as they chare light inside of them.")
			v:EmitSound("music/hl2_song10.mp3", 46, 110, 0.6)
		end		
	end


	self.lastTouch = CurTime();

	ply:Lock()
	ply:ScreenFade(SCREENFADE.OUT, Color(255, 255, 255, 200), 1, 25.5)
	
	timer.Simple(7, function()
		ply:ChatPrint("[white]You feel... oddly better. Happier even...")
	end)

	timer.Simple(15, function()
		ply:ChatPrint("[white]The [fred]Rector[white], I must listen to him.")
	end)

	timer.Simple(24, function()
		ply:ChatPrint("[white]For a better me.")
	end)

	timer.Simple(26.5, function()
		ply:UnLock()
		ply:ScreenFade(SCREENFADE.IN, Color(255, 255, 255, 200), 1, 0)
	end)

	timer.Simple(29, function() 

		local target = self

		local damage = DamageInfo()
		damage:SetDamage( math.huge )
		damage:SetDamageType( DMG_DISSOLVE )
		damage:SetDamageForce( Vector(0, 1, 0) )
		
		target:TakeDamageInfo( damage )
			
		local dissolver = ents.Create("env_entity_dissolver")
		dissolver:SetKeyValue("dissolvetype", 2)
		dissolver:SetKeyValue("magnitude", 1)
		dissolver:SetPos(Vector(0, 1, 0))
		dissolver:Spawn()
			
		target:SetName("TARGET_NOFUCKOFF")
					
		dissolver:Fire("Dissolve", target:GetName())
		dissolver:Fire("Kill", "", 0)

		self:EmitSound("weapons/physcannon/energy_disintegrate4.wav", 75, 100, 1)
		self:OnRemove()

	end)
end
