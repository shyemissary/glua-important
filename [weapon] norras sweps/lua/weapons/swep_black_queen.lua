if (SERVER) then
	
	SWEP.Weight = 0
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
elseif (CLIENT) then
	SWEP.Author = "Norra"
	SWEP.Purpose = ""
	SWEP.Instructions = "If you are not Norra, do not use this SWEP."
	SWEP.PrintName = "Apologetic"
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

	self:SetNextPrimaryFire(CurTime() + 1)

	local owner = self.Owner
	local target = owner:GetEyeTrace().Entity

	if ( !owner:IsSuperAdmin() ) then --No fucker touches my SWEP
		DarkRP.notify(owner, 1, 4, "You are not allowed to use this SWEP!");
		owner:StripWeapon("swep_black_queen")
		return;
	end;

	if (!IsValid(target)) then
		DarkRP.notify(owner, 1, 4, "Invalid entity.");
		return;
	end;

	DarkRP.notify(owner, 1, 5, "You have blinded " .. target:GetName() .."for 15 seconds.");
	target:ChatPrint("[fblack]I am sorry, " .. target:GetName() ..".")
	target:EmitSound( "ambient/wind/wind_moan2.wav", 46, 75, 0.6)
	timer.Simple(5, function()
		target:EmitSound( "ambient/wind/wind_moan4.wav", 46, 75, 0.6)
	end)

	--This chunk below makes the black screen fade in and fade out
	target:ScreenFade(SCREENFADE.OUT, Color(0, 0, 0, 255), 0.5, 14)
	timer.Simple(14.3, function()
		target:ScreenFade(SCREENFADE.IN, Color(0, 0, 0, 255), 0.5, 0)
	end)

end

function SWEP:SecondaryAttack()
	if (CLIENT) then
		return
	end

	self:SetNextPrimaryFire(CurTime() + 1)

	local owner = self.Owner

	if ( !owner:IsSuperAdmin() ) then --No fucker touches my SWEP
		DarkRP.notify(owner, 1, 4, "You are not allowed to use this SWEP!");
		owner:StripWeapon("swep_black_queen")
		return;
	end;

	DarkRP.notify(owner, 1, 5, "You have blinded everyone near you.");

-------------------
	if ( !IsValid( owner ) ) then
		return;
	end

	if ( !owner:Alive() ) then
		return;
	end
-------------------

	for k, targets in pairs( ents.FindInSphere( owner:GetPos(), 450 ) ) do
		if ( !IsValid( targets ) ) then
			continue;
		end

		if ( !targets:IsPlayer() ) then
			continue;
		end
			
		if ( targets == owner ) then
			continue;
		end

		targets:ChatPrint("[fblack]I am sorry, all of you.")

		targets:EmitSound( "ambient/wind/wind_moan2.wav", 46, 75, 0.6)
		timer.Simple(5, function()
			targets:EmitSound( "ambient/wind/wind_moan4.wav", 46, 75, 0.6)
		end)

		--This chunk below makes the black screen fade in and fade out
		targets:ScreenFade(SCREENFADE.OUT, Color(0, 0, 0, 255), 0.5, 14)
		timer.Simple(14.3, function()
			targets:ScreenFade(SCREENFADE.IN, Color(0, 0, 0, 255), 0.5, 0)
		end)		
	end
end
