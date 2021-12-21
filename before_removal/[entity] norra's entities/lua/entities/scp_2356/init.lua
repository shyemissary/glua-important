AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_lab/pipesystem03b.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:Wake()
		physObj:EnableMotion(true)
	end;

	self:SetColor( Color(255,150,150,255) )

end;

function ENT:Use(ply)
	
	if ( self:IsPlayerHolding() ) then 
		return 
	end

local mdl = {

	"models/props_junk/PopCan01a.mdl",

	"models/props_lab/huladoll.mdl",

	"models/props_c17/doll01.mdl",

	"models/props_c17/playgroundTick-tack-toe_block01a.mdl",

	"models/marioragdoll/super mario galaxy/star/star.mdl",

	"models/gta iv/nuts.mdl",

	"models/spartex117/key.mdl",

	"models/labware/goggles.mdl",

	"models/mishka/models/rubber_duck.mdl",

	"models/mishka/models/scp178.mdl",

	"models/thenextscp/scp207/cola.mdl",

	"models/vinrax/props/scp_513.mdl",

}

local rndmSound = {

	"garrysmod/save_load1.wav",

	"garrysmod/save_load2.wav",

	"garrysmod/save_load3.wav",

	"garrysmod/save_load4.wav",

}

	ply:PickupObject( self )
	self:EmitSound(rndmSound[math.random(1, #rndmSound)])
	self:SetModel(mdl[math.random(1, #mdl)])


end
