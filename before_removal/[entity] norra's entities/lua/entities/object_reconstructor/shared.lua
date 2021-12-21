ENT.Type = "anim";
ENT.Base = "base_gmodentity";
ENT.PrintName = "Object Reconstructor";
ENT.Category = "Norra's Entities";
ENT.Author = "Norra";
ENT.Spawnable = true;
ENT.AdminSpawnable = true;

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "HasAnomaly")
	self:NetworkVar("Bool", 1, "isWorking")
	self:NetworkVar("Bool", 2, "isReady")
end




