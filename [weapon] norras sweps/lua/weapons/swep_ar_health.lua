if (SERVER) then
	
	SWEP.Weight = 0
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
elseif (CLIENT) then
	SWEP.Author = "Norra"
	SWEP.Purpose = "AR Augment"
	SWEP.Instructions = "Hold left click to regain your health up to 100."
	SWEP.PrintName = "AR Health Regeneration"
	SWEP.Slot = 2
	SWEP.SlotPos = 0
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.AccurateCrosshair = true
SWEP.Category = "Norra's SWEPs"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.WorldModel = ""
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""



function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:Deploy()
	if (CLIENT) then
		return true
	end

	if (!IsValid(self:GetOwner())) then
		return true
	end

	self:GetOwner():DrawWorldModel(false)
	
    return true
end

function SWEP:PreDrawViewModel()
    return true
end

function SWEP:PrimaryAttack()
	if (CLIENT) then
		return
	end
	
	if IsValid(self.Owner) then
	
		if !self.Owner:Alive() then
			return
		end
		
		if self.Owner:Health() >= 100 then
			return 
		end
		
		if self.CanRegenrateHP == false then 
			return
		end
		
		self.Owner:SetHealth( self.Owner:Health() + 1)
		self.Owner:EmitSound( "npc/roller/code2.wav", 55, 60)
		self.CanRegenrateHP = false

		if self.Owner:Health() > 100 then 
		
			self.Owner:SetHealth( 100 )

		end
	end
	timer.Simple(1, function()
		if IsValid(self) then
			self.CanRegenrateHP = true
		end
	end)
end

function SWEP:SecondaryAttack()
	if (CLIENT) then
		return
	end
end

