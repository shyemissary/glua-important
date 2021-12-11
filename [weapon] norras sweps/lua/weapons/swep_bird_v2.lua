if (SERVER) then
    
    SWEP.Weight = 0
    SWEP.AutoSwitchTo = false
    SWEP.AutoSwitchFrom = false
elseif (CLIENT) then
    SWEP.Author = "Norra"
    SWEP.Purpose = ""
    SWEP.Instructions = "Reload to transform into a crow. Left click to peck people. Right click to caw."
    SWEP.PrintName = "Bird Transformation"
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

SWEP.TransformDelay = 0
SWEP.OwnerModel = nil
SWEP.TransformModel = "models/crow.mdl"

local birdSounds = {

    "npc/crow/alert1.wav",
    "npc/crow/alert2.wav",
    "npc/crow/alert3.wav",
    "npc/crow/crow2.wav",
    "npc/crow/crow3.wav",
    "npc/crow/idle1.wav",
    "npc/crow/idle2.wav",
    "npc/crow/idle3.wav",
    "npc/crow/idle4.wav"

}

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

if (SERVER) then
function SWEP:PrimaryAttack()

    if (CLIENT) then return end

    self:SetNextPrimaryFire(CurTime() + 2)
    local owner = self:GetOwner()

    if ( !owner:GetNWBool("transformation_active") ) then

        DarkRP.notify(owner, 1, 4, "You must be a bird to peck others.");
        return

    else 

        local target = owner:GetEyeTrace().Entity

        if (!IsValid(target)) then

            DarkRP.notify(owner, 1, 4, "This is not a player!");
            return;
        end;

        local plypos = owner:GetPos();
        local entpos = target:GetPos();
        local distancesquared = plypos:DistToSqr(entpos);
        local distance = 200;
        local rangesquared = distance * distance;   

        if (distancesquared > rangesquared) then

            DarkRP.notify(owner, 1, 4, "This player is too far away!");
            return;
        end;

        owner:EmitSound("npc/crow/pain" .. math.random( 1,2 ) .. ".wav", 75, 100, 0.8)
        target:TakeDamage(5, owner)

    end

end 





function SWEP:SecondaryAttack()

    if (CLIENT) then return end

    self:SetNextSecondaryFire(CurTime() + 3)
    local owner = self:GetOwner()

    if ( !owner:GetNWBool("transformation_active") ) then

        DarkRP.notify(owner, 1, 4, "You must be a bird to peck others.");
        return

    else 

        owner:EmitSound(birdSounds[math.random(1, #birdSounds)], 80);

    end

end 




function SWEP:Reload()

    if (CLIENT) then return end

    local ply = self:GetOwner()

    if not IsFirstTimePredicted() then 
        return 
    end

    if !IsValid(ply) then
        return
    end;
    if ( !ply:Alive() ) then
        return
    end;
    if self.TransformDelay > CurTime() then
        return
    end;

    self.TransformDelay = CurTime() + 5

    if ply:GetNWBool("transformation_active") then

        self:BirdTransformation()
    else 
        self:HumanTransformation()
    end
end
end




function SWEP:HumanTransformation()

    if (CLIENT) then return end
    local ply = self:GetOwner()

    timer.Simple(0.10, function()
    
        if ( !ply:IsValid() ) then return end; 
        if ( !ply:Alive() ) then return end;
        self:EmitSound("npc/barnacle/barnacle_die" .. math.random( 1,2 ) .. ".wav", 73)
        
        end)
    timer.Simple(1, function()

        if ( !ply:IsValid() ) then return end; 
        if ( !ply:Alive() ) then return end;

        self.PlayerModel = ply:GetModel()
        ply:SetModel( self.TransformModel );
        ply:SetMoveType( MOVETYPE_FLY )
        ply:SetNWBool("transformation_active", true)
    end)
end




function SWEP:BirdTransformation()
   
   if (CLIENT) then return end
    local ply = self:GetOwner()
       
    timer.Simple(0.10, function()

        self:EmitSound("npc/barnacle/barnacle_die" .. math.random( 1,2 ) .. ".wav", 73)
        
        end)

    timer.Simple(1, function()

        if ( !ply:IsValid() ) then return end; 
        if ( !ply:Alive() ) then return end;

        if ply:GetModel() == self.PlayerModel then
           return
        end

        if self.PlayerModel != nil then 
            ply:SetModel( self.PlayerModel or "models/player/kleiner.mdl" ) 
        end
        ply:SetMoveType( MOVETYPE_WALK )
        ply:SetNWBool("transformation_active", false)
    end)
end




hook.Add("PlayerSwitchWeapon","swep_bird_PlayerSwitchWeapon",function(ply,old,new)
    if ply:GetNWBool("transformation_active") then
        if new:GetClass() == "swep_bird_v2" then
            return
        end
        return true
    end
end)




hook.Add("PostPlayerDeath","swep_bird_PostPlayerDeath",function(ply)
    if ply:GetNWBool("transformation_active") then
        ply:SetNWBool("transformation_active",false)
    end
end)