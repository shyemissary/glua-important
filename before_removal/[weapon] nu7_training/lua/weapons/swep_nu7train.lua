if (SERVER) then	

	SWEP.Weight = 0

	SWEP.AutoSwitchTo = false

	SWEP.AutoSwitchFrom = false

elseif (CLIENT) then

	SWEP.Author = "Norra"

	SWEP.Purpose = "Using this while NOT a Drill Instructor can get you warned in-game and removed from Nu-7."

	SWEP.Instructions = "Left click to give Nu-7 Recuits training weapons."

	SWEP.PrintName = "Nu-7 Trainer SWEP"

	SWEP.Slot = 2

	SWEP.SlotPos = 0

	SWEP.DrawAmmo = false

	SWEP.DrawCrosshair = true

end



SWEP.AccurateCrosshair = true

SWEP.Category = "Norra's SWEPs"

SWEP.Spawnable = true

SWEP.AdminSpawnable = true

SWEP.ViewModel = Model("models/weapons/c_arms.mdl")

SWEP.WorldModel = " "

SWEP.ViewModelFlip = false

SWEP.Primary.ClipSize = -1

SWEP.Primary.DefaultClip = -1

SWEP.Primary.Automatic = false

SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1

SWEP.Secondary.DefaultClip = -1

SWEP.Secondary.Automatic = false

SWEP.Secondary.Ammo = ""



function SWEP:Initialize()

    self:SetHoldType("slam");

end;



function SWEP:SetupDataTables()

	self:NetworkVar("Bool", 0, "heavywep")

end;



function SWEP:PrimaryAttack()

	if CLIENT then

		return;

	end;

	

	self:SetNextPrimaryFire(CurTime() + 2)

	

	local owner = self.Owner

	local target = owner:GetEyeTrace().Entity

	

	if (!IsValid(target)) then

		DarkRP.notify(owner, 1, 4, "Invalid entity.");



		return;

	end;

	

	

	local plypos = owner:GetPos();

	local entpos = target:GetPos();

	local distancesquared = plypos:DistToSqr(entpos);

	local distance = 100;

	local rangesquared = distance * distance;	

	

	if (distancesquared > rangesquared) then

		DarkRP.notify(owner, 1, 4, "That player is too far away!");



		return;

	end;

		

	

	local teams = {

		

		"MTF Nu-7 Recruit"

		

		

	};

	

	if ( !table.HasValue(teams, team.GetName( target:Team() ) ) ) then

	

		DarkRP.notify(owner, 1, 2, "You can't give weapons to this player!");

		

        return

    end

	

	if target:IsPlayer() then 



		if target:GetNWBool("heavywep") then

			

			DarkRP.notify(owner, 1, 4, "This person already has training weapons!");

			

			return		

		
		else

		

			DarkRP.notify(owner, 1, 4, "You have given " .. target:Nick() .. " training weapons.");

			DarkRP.notify(target, 1, 4, "You have been given a Training Glock 17 and HK MP5.");

			target:Give("cw_mp5_train");

			target:Give("cw_nen_glock17_train")

			target:GiveAmmo(62, "9x19MM", false)
			
			target:SetNWBool("heavywep", true)
			

		end	

	end;

end	