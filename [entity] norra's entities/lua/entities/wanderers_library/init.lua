AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

local mdl = {
	"models/props_combine/breenbust.mdl",
	"models/props_lab/huladoll.mdl",
	"models/props_lab/binderblue.mdl",
	"models/props_lab/bindergreen.mdl",
	"models/props_lab/binderredlabel.mdl",
	"models/props_combine/breenclock.mdl",
	"models/props_combine/breenglobe.mdl",
	"models/props_c17/SuitCase_Passenger_Physics.mdl",
	"models/props_lab/frame002a.mdl",
}

local count = 0
local limit = 1

function ENT:OnRemove()
	count = count - 1
end

function ENT:Initialize()
	count = count + 1
    if count > limit then
        self:Remove()
    end
	self:SetModel(mdl[math.random(1, #mdl)])
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:Wake()
		physObj:EnableMotion(true)
	end

	self:SetCollisionGroup(15)	

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

	ply:SetPos(Vector(-5781.4, -8152.3, -1370.7))
	ply:EmitSound("garrysmod/save_load"..math.random(1,4)..".wav")
	zapEffect(ply)

end

