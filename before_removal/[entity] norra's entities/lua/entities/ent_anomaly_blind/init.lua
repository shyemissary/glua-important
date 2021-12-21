AddCSLuaFile("shared.lua");
AddCSLuaFile("cl_init.lua");
include("shared.lua");
util.AddNetworkString("vAnomalyBlind")
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

function ENT:StartBlind(player)
	net.Start("vAnomalyBlind");

	net.WriteBool(true);
	
	net.Send(player);

	timer.Simple(10, function()
		if (!IsValid(player)) then
			return;
		end;

		net.Start("vAnomalyBlind");

		net.WriteBool(false);

		net.Send(player);
	end);
	
	DarkRP.notify(player, 1, 2, "You have been temporarily blinded by the anomaly!");
end;

function ENT:Use(player)
	self:StartBlind(player);
end;

function ENT:StartTouch(entity)
	if (!IsValid(entity)) then
		return;
	end;

	if (!entity:IsPlayer()) then
		return;
	end;

	self:StartBlind(entity);
end;