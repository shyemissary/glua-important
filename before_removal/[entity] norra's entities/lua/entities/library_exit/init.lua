AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/door01_left.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:Wake()
		physObj:EnableMotion(true)
	end

	self:SetSkin(2)
	self:SetBodygroup(1, 1)

end

local function zapEffect(target)
    local effectdata = EffectData()
    effectdata:SetStart(target:GetShootPos())
    effectdata:SetOrigin(target:GetShootPos())
    effectdata:SetScale(1)
    effectdata:SetMagnitude(1)
    effectdata:SetScale(1)
    effectdata:SetRadius(3)
    effectdata:SetEntity(target)
    for i = 1, 2 do
        util.Effect("TeslaHitBoxes", effectdata, true, true)
    end

    local Zap = math.random(1,3)
    target:EmitSound("ambient/energy/zap" .. Zap .. ".wav", 75, 100, 0.2)
end

function ENT:Use(activator, ply)

	local Cooldown = 2
	if (ply.lastTouch and (ply.lastTouch + Cooldown) > CurTime()) then return end

	if IsValid(ents.FindByClass("wanderers_library")[1]) then 
		ply:EmitSound("doors/door_latch3.wav", 75, math.random(95,105))
		ply:SetPos(ents.FindByClass("wanderers_library")[1]:GetPos())
		zapEffect(ply)
		return 
	else 

		ply:EmitSound("doors/latchlocked2.wav", 75, math.random(95,105))
		DarkRP.notify(ply, 1, 3, "No wanderers_library found on the map!");

	end
 
	ply.lastTouch = CurTime()

end