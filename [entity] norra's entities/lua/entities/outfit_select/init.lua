AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/gta iv/duffle_bag.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:Wake()
		physObj:EnableMotion(true)
	end;

	self.hasChosen = false 
	self.suitOutfit = false 
	self.civiOutfit = false 
	self.milOutfit = false

	util.AddNetworkString("OpenOutfitMenu")
	util.AddNetworkString("choseSuit")
	util.AddNetworkString("choseCivi")
	util.AddNetworkString("choseMil")

end


local suitModels = {
	"models/player/suits/male_01_closed_coat_tie.mdl",
	"models/player/suits/male_02_closed_coat_tie.mdl",
	"models/player/suits/male_03_closed_coat_tie.mdl",
	"models/player/suits/male_04_closed_coat_tie.mdl",
	"models/player/suits/male_05_closed_coat_tie.mdl",
	"models/player/suits/male_06_closed_coat_tie.mdl",
	"models/player/suits/male_07_closed_coat_tie.mdl",
	"models/player/suits/male_08_closed_coat_tie.mdl",
	"models/player/suits/male_09_closed_coat_tie.mdl",
	"models/player/suits/male_01_closed_tie.mdl",
	"models/player/suits/male_02_closed_tie.mdl",
	"models/player/suits/male_03_closed_tie.mdl",
	"models/player/suits/male_04_closed_tie.mdl",
	"models/player/suits/male_05_closed_tie.mdl",
	"models/player/suits/male_06_closed_tie.mdl",
	"models/player/suits/male_07_closed_tie.mdl",
	"models/player/suits/male_08_closed_tie.mdl",
	"models/player/suits/male_09_closed_tie.mdl",
	"models/player/suits/male_01_open.mdl",
	"models/player/suits/male_01_open.mdl",
	"models/player/suits/male_02_open.mdl",
	"models/player/suits/male_03_open.mdl",
	"models/player/suits/male_04_open.mdl",
	"models/player/suits/male_05_open.mdl",
	"models/player/suits/male_06_open.mdl",
	"models/player/suits/male_07_open.mdl",
	"models/player/suits/male_08_open.mdl",
	"models/player/suits/male_09_open.mdl",
	"models/player/suits/male_01_open_tie.mdl",
	"models/player/suits/male_02_open_tie.mdl",
	"models/player/suits/male_03_open_tie.mdl",
	"models/player/suits/male_04_open_tie.mdl",
	"models/player/suits/male_05_open_tie.mdl",
	"models/player/suits/male_06_open_tie.mdl",
	"models/player/suits/male_07_open_tie.mdl",
	"models/player/suits/male_08_open_tie.mdl",
	"models/player/suits/male_09_open_tie.mdl",
	"models/player/suits/male_01_open_waistcoat.mdl",
	"models/player/suits/male_02_open_waistcoat.mdl",
	"models/player/suits/male_03_open_waistcoat.mdl",
	"models/player/suits/male_04_open_waistcoat.mdl",
	"models/player/suits/male_05_open_waistcoat.mdl",
	"models/player/suits/male_06_open_waistcoat.mdl",
	"models/player/suits/male_07_open_waistcoat.mdl",
	"models/player/suits/male_08_open_waistcoat.mdl",
	"models/player/suits/male_09_open_waistcoat.mdl",
	"models/player/suits/male_01_shirt_tie.mdl",
	"models/player/suits/male_02_shirt_tie.mdl",
	"models/player/suits/male_03_shirt_tie.mdl",
	"models/player/suits/male_04_shirt_tie.mdl",
	"models/player/suits/male_05_shirt_tie.mdl",
	"models/player/suits/male_06_shirt_tie.mdl",
	"models/player/suits/male_07_shirt_tie.mdl",
	"models/player/suits/male_08_shirt_tie.mdl",
	"models/player/suits/male_09_shirt_tie.mdl",
}

local civiModels = {
    "models/kayf/humans/group01/male_01.mdl",
    "models/kayf/humans/group01/male_02.mdl",
    "models/kayf/humans/group01/male_03.mdl",
    "models/kayf/humans/group01/male_07.mdl",
    "models/kayf/humans/group01/male_09.mdl",
    "models/kayf/humans/group02/male_04.mdl",
    "models/kayf/humans/group02/male_05.mdl",
    "models/kayf/humans/group01/female_04.mdl",
    "models/kayf/humans/group01/female_07.mdl",
    "models/kayf/humans/group01/female_03.mdl",
    "models/kayf/humans/group01/female_01.mdl",
}

local milModels = {
	"models/player/cellassault4player.mdl",
	"models/bloocobalt/resident_evil/re6_agent.mdl",
	"models/blacklist/merc1.mdl",
	"models/ninja/mgs4_pieuvre_armament_merc.mdl",
}

local MCND = {
	"MC&D Bouncer",
	"MC&D Agent",
	"MC&D Salesman",
}

local canPickupOutfit = {
	"Civilian",
	"Chaos Insurgency Operative",
	"Chaos Insurgency Infiltrator",
	"Chaos Insurgency Delta",
}

function ENT:Use(ply, caller)

	if not IsFirstTimePredicted() then return end

	local Cooldown = 5

	if (ply.lastTouch and (ply.lastTouch + Cooldown) > CurTime()) then
		return
	end	

	ply.lastTouch = CurTime()

	if self.hasChosen == false then

		if (team.GetName(ply:Team()) == "MC&D Salesman") then
			net.Start("OpenOutfitMenu")
			net.Send(caller)
		else 
			DarkRP.notify(ply, 2, 4, "Only the Salesman can choose an random outfit.")
			return
		end			

	elseif self.hasChosen == true then

		if (table.HasValue(MCND, team.GetName(ply:Team()))) then
			DarkRP.notify(ply, 2, 4, "You can not pickup this outfit.")
			return 
		end

		if (!table.HasValue(canPickupOutfit, team.GetName(ply:Team()))) then
			DarkRP.notify(ply, 2, 4, "You can not pickup this outfit.")
			return 
		end

		if self.suitOutfit == true then

			local selectedSuitModel = table.Random(suitModels)
			self:EmitSound("npc/combine_soldier/gear6.wav")
			ply:Say("/me puts on the Outfit.")
			ply:SetModel(selectedSuitModel)
			SafeRemoveEntity(self)

		elseif self.civiOutfit == true then

			local selectedCiviModel = table.Random(civiModels)
			self:EmitSound("npc/combine_soldier/gear6.wav")
			ply:Say("/me puts on the Outfit.")
			ply:SetModel(selectedCiviModel)
			SafeRemoveEntity(self)

		elseif self.milOutfit == true then

			local selectedMilModel = table.Random(milModels)
			self:EmitSound("npc/combine_soldier/gear6.wav")
			ply:Say("/me puts on the Outfit.")
			ply:SetModel(selectedMilModel)
			SafeRemoveEntity(self)

		end
	end
end

net.Receive("choseSuit", function()

	for k,v in pairs(ents.FindByClass("outfit_select")) do 
		if not v:IsValid() then
			return 
		end

		local pos = v:GetPos()
		local ED = EffectData()
		ED:SetOrigin(pos)
		util.Effect("StunstickImpact", ED)	

		v:EmitSound("npc/combine_soldier/gear1.wav")
		v.hasChosen = true 
		v.suitOutfit = true
	end

end)
net.Receive("choseCivi", function()

	for k,v in pairs(ents.FindByClass("outfit_select")) do 
		if not v:IsValid() then
			return 
		end

		local pos = v:GetPos()
		local ED = EffectData()
		ED:SetOrigin(pos)
		util.Effect("StunstickImpact", ED)	

		v:EmitSound("npc/combine_soldier/gear1.wav")
		v.hasChosen = true 
		v.civiOutfit = true
	end
	
end)
net.Receive("choseMil", function()

	for k,v in pairs(ents.FindByClass("outfit_select")) do 
		if not v:IsValid() then
			return 
		end

		local pos = v:GetPos()
		local ED = EffectData()
		ED:SetOrigin(pos)
		util.Effect("StunstickImpact", ED)

		v:EmitSound("npc/combine_soldier/gear1.wav")
		v.hasChosen = true 
		v.milOutfit = true
	end
	
end)