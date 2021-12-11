if (SERVER) then	

	SWEP.Weight = 0

	SWEP.AutoSwitchTo = false

	SWEP.AutoSwitchFrom = false

elseif (CLIENT) then

	SWEP.Author = "Norra"

	SWEP.Purpose = ""

	SWEP.Instructions = "Left click to 'Conscript' a new Agent. Right click to give the Agent GRU-P Comms and a Makarov."

	SWEP.PrintName = "GRU-P Conscripter"

	SWEP.Slot = 2

	SWEP.SlotPos = 0

	SWEP.DrawAmmo = false

	SWEP.DrawCrosshair = true

end



SWEP.AccurateCrosshair = true

SWEP.Category = "Norra's SWEPs"

SWEP.Spawnable = true

SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/c_arms.mdl"

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



function SWEP:SetupDataTables()

	self:NetworkVar("Bool", 0, "sleeperagent")
	self:NetworkVar("Bool", 0, "heavywep")

end;



function SWEP:Initialize()

    self:SetHoldType("slam");

end;



function SWEP:PrimaryAttack()

	if CLIENT then

		return;

	end;

	

	self:SetNextPrimaryFire(CurTime() + 3)

	

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

		DarkRP.notify(owner, 1, 4, "That entity is too far.");



		return;

	end;

	
	
	vSCPs.sleeperAgents = 0;



	for k, v in pairs(player.GetAll()) do

		if (v:getDarkRPVar("job") == "GRU-P Conscripted Agent") then

			vSCPs.sleeperAgents = vSCPs.sleeperAgents + 1;

		end;

	end;



	if (vSCPs.sleeperAgents >= 2) then

		DarkRP.notify(owner, 1, 4, "You already have 2 GRU-P Conscripted Agents!");



		return false;

	end;

	

	local teams = {

		"Civilian",

		"Reporter",

		"Paramedic",

		"Police Officer",

		"SWAT Unit"

	};

	

	

	if ( table.HasValue(teams, team.GetName( target:Team() ) ) ) then

	

		if target:IsPlayer() then 		

			if target:GetNWBool("sleeperagent") then

				DarkRP.notify(owner, 1, 4, "That person is already under your command.");

			else

				target:SetNWBool("sleeperagent", true);
				target:SetNWBool("hasGRUcomms", false);

				target:ChatPrint("[fred]"..owner:Name().." has Conscritped you into a GRU-P Agent. You must listen to every order your superiors give to you.")
				owner:ChatPrint("[fred]You have Conscripted "..target:Name().." into a GRU-P Agent.")
				
				owner:Say("Man is the most important means of production. Welcome, "..target:Name()..".")

				target:updateJob("GRU-P Agent");
				target:EmitSound("npc/combine_soldier/gear3.wav")
				
				timer.Simple(6, function()
					target:ChatPrint("[fred]Your begin to feel a sharp pain in your head.")
					owner:EmitSound( "ambient/atmosphere/thunder3.wav", 30, 80, 1)
				end)
				
				timer.Simple(15, function()

					target:EmitSound( "player/geiger2.wav", 30, 95, 1)

				end)

				
				timer.Simple(43, function()

					target:ChatPrint("[fred]You begin to soothe your mind.")
					owner:EmitSound( "player/geiger3.wav", 30, 95, 1)

				end)

			end	

		end;

		

        

	else

	

		DarkRP.notify(owner, 1, 4, "You can't conscript this player!");

		

		return

    end

	

end	

function SWEP:SecondaryAttack()

	if CLIENT then

		return;

	end;

	
	local GRUComms = {"GRU-P"}

	local Owner = self.Owner

	local target = Owner:GetEyeTrace().Entity

	

	self:SetNextSecondaryFire(CurTime() + 2)

	

	if target:IsPlayer() then 

		

		

		if (target:getDarkRPVar("job") == "GRU-P Agent") then

		

			target:AddComms(GRUComms)
			target:Give("cw_makarov", false)
			target:EmitSound("items/ammo_pickup.wav")
			target:SetNWBool("heavywep", true)

			

		else

		

			DarkRP.notify(Owner, 1, 4, "You can't give out this loudout to non Agents.");

			

		end	

	end;

	

end	
