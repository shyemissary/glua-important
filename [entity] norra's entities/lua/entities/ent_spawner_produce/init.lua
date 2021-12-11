AddCSLuaFile("shared.lua");
AddCSLuaFile("cl_init.lua");
include("shared.lua");
local model = {
	"models/props_c17/chair02a.mdl",
	"models/props_interiors/Furniture_Lamp01a.mdl",
	"models/props_lab/monitor01a.mdl",
	"models/props_combine/breenclock.mdl",
	"models/props_junk/TrafficCone001a.mdl",
	"models/props_phx/misc/fender.mdl",
	"models/maxofs2d/camera.mdl",
	"models/balloons/balloon_dog.mdl",
	"models/props_office/office_chair_static.mdl",
	"models/props_interiors/tv.mdl",
	"models/mark2580/gtav/mp_apa_06/planningrm/planningrm_monitor.mdl",
	"models/props_lab/binderredlabel.mdl",
	"models/gibs/hgibs_scapula.mdl"
}

local spawnsound = {
	"garrysmod/save_load1.wav",
	"garrysmod/save_load4.wav"

}

local despawnsound = {
	"garrysmod/save_load2.wav",
	"garrysmod/save_load3.wav"
}

function ENT:Initialize()
	self:SetModel(model[math.random(1, #model)]);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
	self.bool = true;
	local physObj = self:GetPhysicsObject();

	if (IsValid(physObj)) then
		physObj:Wake();
		physObj:EnableMotion(true);
	end;

	self:EmitSound(spawnsound[math.random(1, #spawnsound)], 67);

	timer.Simple(5, function()

		self:EmitSound(despawnsound[math.random(1, #despawnsound)], 67);
    	SafeRemoveEntity(self)
		
		end)

end;


