if (SERVER) then
	
	SWEP.Weight = 0
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
elseif (CLIENT) then
	SWEP.Author = "Norra"
	SWEP.Purpose = "Press R to get the position. Left click to teleport 1 player. Right click to teleport yourself."
	SWEP.Instructions = "For events most of the time."
	SWEP.PrintName = "Event Teleport"
	SWEP.Slot = 2
	SWEP.SlotPos = 0
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
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

SWEP.TeleportSetDelay = 0


function SWEP:Initialize()
    self:SetHoldType("normal")
    self.HasSetLocation = 0
    self.TeleportLoctation = ""
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

	self:SetNextPrimaryFire(CurTime() + 1)

	local owner = self.Owner
	local target = owner:GetEyeTrace().Entity

	if self.HasSetLocation == 0 then 
		DarkRP.notify(owner, 1, 4, "You have to set a teleport location!");
		return
	end

	if (!IsValid(target)) then
		DarkRP.notify(owner, 1, 4, "Invalid entity.");
		return;
	end;

	DarkRP.notify(owner, 1, 4, "Teleporting " .. target:GetName() .."...");
	target:EmitSound("ambient/levels/citadel/portal_beam_shoot6.wav", 46, 90, 0.8)
	target:ScreenFade(SCREENFADE.OUT, Color(0, 0, 0, 255), 0.4, 1.5)
	timer.Simple(1.5, function()
		owner:EmitSound("ambient/levels/canals/drip4.wav", 46, 100, 0.75)
		target:SetPos(self.TeleportLoctation)
	end)	
	timer.Simple(1.8, function()
		target:ScreenFade(SCREENFADE.IN, Color(0, 0, 0, 255), 0.5, 0)
	end)

end

function SWEP:SecondaryAttack()
	if (CLIENT) then
		return
	end

	self:SetNextSecondaryFire(CurTime() + 0.3)

	local owner = self.Owner

	if self.HasSetLocation == 0 then 
		DarkRP.notify(owner, 1, 4, "You have to set a teleport location!");
		return
	end

	self:SetNextPrimaryFire(CurTime() + 0.3)

	local owner = self.Owner

	DarkRP.notify(owner, 1, 4, "Teleporting " .. owner:GetName() .."...");
	owner:EmitSound("ambient/levels/citadel/portal_beam_shoot6.wav", 46, 90, 0.8)
	owner:ScreenFade(SCREENFADE.OUT, Color(0, 0, 0, 255), 0.4, 1.5)
	timer.Simple(1.5, function()
		owner:SetPos(self.TeleportLoctation)
	end)
	timer.Simple(1.8, function()
		owner:ScreenFade(SCREENFADE.IN, Color(0, 0, 0, 255), 0.5, 0)
	end)

end


function SWEP:Reload()

	local owner = self.Owner

	if self.TeleportSetDelay == 1 then 
		return
	end 

	owner:ChatPrint("[white]You have set a teleport location! Please wait 5 seconds before setting another one!")
	owner:EmitSound( "garrysmod/content_downloaded.wav", 46)
	self.TeleportLoctation = owner:GetPos()
	self.HasSetLocation = 1

	self.TeleportSetDelay = 1
	timer.Simple(5, function()
		self.TeleportSetDelay = 0
	end)

end