if (SERVER) then
	
	SWEP.Weight = 0
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
elseif (CLIENT) then
	SWEP.Author = "Norra"
	SWEP.Purpose = "AR Augment"
	SWEP.Instructions = "Hold left click to regain your armor up to 60."
	SWEP.PrintName = "AR Armor Regeneration"
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
		
		if self.Owner:Armor() >= 60 then
			return 
		end
		
		if self.CanRegenrateArmor == false then 
			return
		end
		
		self.Owner:SetArmor( self.Owner:Armor() + 2)
		self.Owner:EmitSound( "npc/roller/mine/rmine_blip1.wav", 55, 30)
		self.CanRegenrateArmor = false

		if self.Owner:Armor() > 60 then 
		
			self.Owner:SetArmor( 60 )

		end
	end
	timer.Simple(1, function()
		if IsValid(self) then
			self.CanRegenrateArmor = true
		end
	end)
end

function SWEP:SecondaryAttack()
	if (CLIENT) then
		return
	end
end

