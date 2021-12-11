AddCSLuaFile("shared.lua");
AddCSLuaFile("cl_init.lua");
include("shared.lua");

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

function ENT:Use(player) end;

local timerLength = 1;

timer.Create("vAnomalyQuake", timerLength, 0, function()
	for k, v in pairs(ents.FindByClass("ent_anomaly_quake")) do
		if (v:IsPlayerHolding()) then
			continue;
		end;
		
		util.ScreenShake(v:GetPos(), 4000, math.random(300,500), timerLength, 1000);
	end;
end);
