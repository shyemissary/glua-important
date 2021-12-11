AddCSLuaFile("shared.lua");
AddCSLuaFile("cl_init.lua");
include("shared.lua");
local mdl = {
	"models/mechanics/gears/gear12x12.mdl",
	"models/mechanics/gears/gear12x6.mdl",
	"models/mechanics/gears/gear16x12.mdl",
	"models/mechanics/gears/gear16x6.mdl"
}
function ENT:Initialize()
	self:SetModel(mdl[math.random(1, #mdl)]);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	self.bool = true;
	local physObj = self:GetPhysicsObject();

	if (IsValid(physObj)) then
		physObj:Wake();
		physObj:EnableMotion(true);
	end;
end;

ENT.DHealth = 100;

function ENT:Use(player)
	if (self.bool) then
	if (player.cooldown) then
		DarkRP.notify(player, 1, 4, "You decide not to touch this anomaly so close to your last interaction.");
		return;
	end;

	player:SetArmor(player:Armor() + 30);

	if player:Armor() >= 200 then
		player:SetArmor(200)
	end

	player.cooldown = true;

	timer.Simple(10, function()
		if (!IsValid(self)) then
			return;
		end;

		player.cooldown = false;
	end);

	DarkRP.notify(player, 1, 2, "You have been given armour by the anomaly.");
	end;
end;


function ENT:OnTakeDamage(dmg)
	self:TakePhysicsDamage(dmg)

	if (self.DHealth <= 0) then return end

	self.DHealth = self.DHealth - dmg:GetDamage()

	if (self.DHealth <= 0) then
		self:SetColor(Color(150,150,150))
        self:EmitSound("npc/scanner/scanner_pain2.wav", self:GetPos())
        self.bool = false;
        timer.Simple(30,function() if self:IsValid() then self.bool = true; self:SetColor(Color(255,255,255)); self.DHealth = 100; self:EmitSound("npc/scanner/scanner_scan2.wav", self:GetPos()) end; end)
	end


end
