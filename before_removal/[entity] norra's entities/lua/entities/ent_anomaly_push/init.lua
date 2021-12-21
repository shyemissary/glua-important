AddCSLuaFile("shared.lua");
AddCSLuaFile("cl_init.lua");
include("shared.lua");

local pairs = pairs
local timer = timer

local mdl = {
	"models/props_lab/reciever01c.mdl",
	"models/props_lab/jar01a.mdl",
	"models/props_junk/MetalBucket01a.mdl",
	"models/props_lab/binderredlabel.mdl",
	"models/props_junk/plasticbucket001a.mdl",
	"models/props_junk/garbage_milkcarton001a.mdl",
	"models/props_interiors/pot01a.mdl",
	"models/props_combine/breenglobe.mdl",
	"models/props_c17/tv_monitor01.mdl",
	"models/props_c17/SuitCase001a.mdl",
	"models/props_c17/metalPot001a.mdl",
	"models/props_c17/chair_office01a.mdl",
	"models/props_junk/garbage_coffeemug001a.mdl",
}
function ENT:Initialize()
	self:SetModel(mdl[math.random(1, #mdl)]);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	self:SetTrigger(true);

	local physObj = self:GetPhysicsObject();

	if (IsValid(physObj)) then
		physObj:Wake();
		physObj:EnableMotion(true);
	end;
end;

function ENT:Use(player)
end;

timer.Create("Push_Anomaly", 2, 0, function()

	for k, v in pairs(ents.FindByClass("ent_anomaly_push")) do
		for k2,v2 in pairs( ents.FindInSphere( v:GetPos(), 250 ) ) do
			if (!IsValid(v2)) then
				continue
			end

			if (!v2:IsPlayer()) then
				continue
			end

			if (v2:GetNoDraw()) then
				continue
			end

			if (!v2:Alive()) then
				continue
			end

			v2:SetVelocity( (v:GetPos() - v2:GetPos()):GetNormalized() * - 1000 + Vector(0,0,-150))
		end
	end
end)
