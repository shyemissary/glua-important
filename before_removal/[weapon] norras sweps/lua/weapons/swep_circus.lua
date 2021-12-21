if ( SERVER ) then
	AddCSLuaFile("swep_joshysfirst.lua");

	SWEP.Weight = 0;
	SWEP.AutoSwitchTo = false;
	SWEP.AutoSwitchFrom = false;
elseif ( CLIENT ) then
	SWEP.Author = "Norra";
	SWEP.Purpose = "Invites People to the Circus";
	SWEP.Instructions = "M1 to invite someone.";
	SWEP.PrintName = "The Inviting Circus";
	SWEP.Slot = 2;
	SWEP.SlotPos = 1;
	SWEP.DrawAmmo = false;
	SWEP.DrawCrosshair = true;
end;

SWEP.AccurateCrosshair = true;
SWEP.Category = "Norra's SWEPs";
SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;

SWEP.HoldType = "slam";
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.UseHands = true
SWEP.ViewModel = "models/pg_props/pg_weapons/pg_shot_v.mdl"
SWEP.WorldModel = ""
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false

SWEP.Primary.ClipSize = -1;
SWEP.Primary.DefaultClip = -1;
SWEP.Primary.Automatic = false;
SWEP.Primary.Ammo = "";
SWEP.Primary.Delay = 10
SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.DefaultClip = -1;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.Ammo = "";
SWEP.Clown = 0

local delay = 0

local teams = {

	"Hierarchy",

	"Staff on Duty",

	"Hazmat Unit",
		
	"SCP-096",

	"SCP-049",

	"SCP-939",

	"SCP-1048",

	"SCP-966",

	"SCP-173",

	"SCP-457",
		
	"SCP-682",
		
	"SCP-076-II",

	"SCP-106",

	"SCP-999",

	"SCP-1370",

	"SCP-913",

	"SCP-087-II",

	"SCP-035",

	"SCP-008-II",

	"MTF E-11 Containment",

	"MTF E-11 Commander",

	"MTF E-11 Specialist",

	"Circus Clown"

};

local mdl = {

	"models/player/zombie_classic.mdl",

	"models/player/zombie_fast.mdl",

	"models/player/zombie_soldier.mdl",

	"models/player/corpse1.mdl",

}

local Attack = 0 

function SWEP:Initialize()
	self:SetWeaponHoldType("slam")

end

local dist = 100;



function SWEP:PrimaryAttack( )

		if ( CLIENT ) then return end

		local ply = self:GetOwner()

		ply.ClownCount = 0;


		local tr = util.TraceLine( {
			start = ply:EyePos(),
				endpos = ply:EyePos() + ply:EyeAngles():Forward() * 150,
			filter = ply
		} )

		if(not IsValid(tr.Entity)) then
			tr = util.TraceLine{ 
			start = shootpos,
			endpos = endshootpos,
			filter = ply,
			mask = MASK_SHOT_HULL}
		end

		local ent = tr.Entity
		if (IsValid(ent)) && ( ent:IsPlayer() ) then
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			ply:SetAnimation( PLAYER_ATTACK1 )


			for k, v in pairs(player.GetAll()) do

				if (v:getDarkRPVar("job") == "Circus Clown") then

					ply.ClownCount = ply.ClownCount + 1;

				end;

			end;



			if (ply.ClownCount >= 3) then

				DarkRP.notify(ply, 1, 4, "You have too many clowns.");


				return false;

			end;


			if ( table.HasValue(teams, team.GetName( ent:Team() ) ) ) then

				DarkRP.notify(ply, 1, 4, "You cannot infect this person.");
		
        		return false

   			end


				if (ply.ClownCount < 3) then

					self:SetNextPrimaryFire(CurTime() + 30)

					ent:TakeDamage(10)

						timer.Simple(3, function()

							ent:EmitSound("vo/npc/male01/moan01.wav")

						end)	

						timer.Simple(6, function()

							ent:EmitSound("vo/npc/male01/moan02.wav")

						end)						
	
					timer.Create("Circus_Clown_Infect" .. ply:UserID(), 10, 1, function()

						ent:SetModel(mdl[math.random(1, #mdl)]);

						ent:EmitSound("npc/zombie/zombie_alert2.wav")

						ent:StripWeapons();
	
						ent:SetHealth(150)

						ent:Give("weapon_fists");

						ent:SelectWeapon("weapon_fists");

						ent:ChatPrint("[red](OOC)[fred] You have joined the circus, you MUST listen to '" ..ply:Name().. "' or else you can be warned")						
	
						ent:updateJob("Circus Clown")

					end)
				end
			end
		end

