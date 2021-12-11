AddCSLuaFile("shared.lua");
AddCSLuaFile("cl_init.lua");
include("shared.lua");

local mdl = {
	"models/mechanics/gears/gear12x12.mdl",	"models/mechanics/gears/gear12x6.mdl",	"models/mechanics/gears/gear16x12.mdl",	"models/mechanics/gears/gear16x6.mdl"
}
function ENT:Initialize()
	self:SetModel(mdl[math.random(1, #mdl)]);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);

	local physObj = self:GetPhysicsObject();

	if (IsValid(physObj)) then
		physObj:Wake();
		physObj:EnableMotion(true);
	end;
end;

function ENT:Use(player)	DarkRP.notify(player, 1, 3, "Seems to be an ancient Broken Church artifact.")
end;

hook.Add("PlayerSay", "HookGodBoy", function(ply, text)

	if ( string.find(string.lower(text),"bless me") ) then

		for k,v in pairs( ents.FindByClass("ent_anomaly_fleshgod") ) do
			if ply:GetPos():Distance( v:GetPos() ) < 150 then
				if (ply.shouldBeBlessed) then
					DarkRP.notify(ply, 1, 5, "You are already blessed my child!")
				else
					ply.shouldBeBlessed = true
					DarkRP.notify(ply, 2, 5, "You are now blessed my child!")
				end
			end
		end
	end
end)
