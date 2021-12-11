AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

util.PrecacheModel("models/weapons/NeN/Glock 17/v_pist_glock17")
util.PrecacheModel("models/weapons/NeN/Glock 17/w_pist_glock17")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Training Glock 17"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "c"
	killicon.AddFont("cw_glock17", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.4
	SWEP.ShellOffsetMul = 0
	SWEP.ShellPosOffset = {x = 1.5, y = 0, z = 0}

	SWEP.IronsightPos = Vector(2.01, -1, 1.125)
	SWEP.IronsightAng = Vector(0, 0, 0)
	SWEP.ZoomAmount	= 0
	SWEP.FOVPerShot = 0

	SWEP.MicroT1Pos = Vector(2.025, 0, 0.145)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.RMRPos = Vector(2, 0, 0.65)
	SWEP.RMRAng = Vector(0, 0, 0)

	SWEP.CustomizePos = Vector(-6.628, -4.422, -1.81)
    SWEP.CustomizeAng = Vector(21.809, -40.805, -13.367)
	
	SWEP.SprintPos = Vector(-1.634, -9.28, -8.311)
	SWEP.SprintAng = Vector(70, 0, 0)
	
	SWEP.AlternativePos = Vector(-2.36, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = true
	SWEP.BoltBone = "Glock18 Slide"
	SWEP.BoltShootOffset = Vector(0, 0, 0)
	SWEP.BoltReloadOffset = Vector(0, 0, 0)
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0, hor = 0, roll = 0, forward = -3, pitch = 0}
	SWEP.CustomizationMenuScale = 0.0075
	SWEP.ReloadViewBobEnabled = false
	SWEP.BoltBonePositionRecoverySpeed = 15 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	SWEP.DontMoveBoltOnHipFire = true
	
	SWEP.AttachmentModelsVM = {
		["md_insight_x2"] = {model = "models/cw2/attachments/pistollaser.mdl", bone = "Glock18", pos = Vector(0, -0.5, 1.2), angle = Angle(0, -90, 0), size = Vector(0.15, 0.125, 0.125)},
		["md_g17laser"] = {model = "models/cw2/attachments/pistollaser.mdl", bone = "Glock18", pos = Vector(0, -0.5, 2.3), angle = Angle(0, -90, 0), size = Vector(0.001, 0.001, 0.001)},
		["kk_ins2_m6x"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_m6x.mdl", bone = "Glock18", pos = Vector(0, -1, 0.5), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_m9.mdl", pos = Vector(0.00000, -4.30000, 0.69000), angle = Angle(0.00000, 90.00000, 0.00000), size = Vector(1.00000, 1.00000, 1.00000), bone = "Glock18"},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_m9.mdl", pos = Vector(0.00000, -3.60000, 0.50000), angle = Angle(0.00000, 90.00000, 0.00000), size = Vector(0.70000, 0.80000, 0.80000), bone = "Glock18"},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Glock18 Barrel", pos = Vector(-0.01, -5.65, 1), angle = Angle(0, 0, 0), size = Vector(0.63, 0.63, 0.63)},
		["md_cobram2"] = {model = "models/cw2/attachments/cobra_m2.mdl", bone = "Glock18 Barrel", pos = Vector(0, -5.6, 1.75), angle = Angle(0, -90, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Glock18 Slide", pos = Vector(-0.02, 9.5,  0.63), angle = Angle(180, 180, -180), size = Vector(0.449, 0.449, 0.449)},
		["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "Glock18 Slide", pos = Vector(0.3, 14,  -4.15), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8)},
	}
end
	
SWEP.TritiumBGs = {main = 1, off = 0, on = 1}
	
function SWEP:IndividualThink()
    if self.dt.State == CW_AIMING and self.AimPos == self.IronsightPos and self:Clip1() > 0 then
        self.BoltShootOffset = Vector(0, 0, 0)
        self.LuaViewmodelRecoil = true
        self.LuaVMRecoilAxisMod = {vert = 0, hor = 0, roll = 0, forward = -3, pitch = 0}
        self.ADSFireAnim = true
    else
        self.BoltShootOffset = Vector(-1.25, 0, 0) //<----- remove your BoltShootOffset from the top and place it here
        self.LuaViewmodelRecoil = true
        self.LuaVMRecoilAxisMod = {vert = 0, hor = 0, roll = 0, forward = 0.5, pitch = 1.5}
        self.ADSFireAnim = false
    end
	
	if self.ActiveAttachments.kk_ins2_m6x or self.ActiveAttachments.kk_ins2_lam then
		self.LaserPosAdjust = Vector(0, 0, 0)
		self.LaserAngAdjust = Angle(0, 0, 0)
	else
		self.LaserPosAdjust = Vector(0, 0, -1.25)
		self.LaserAngAdjust = Angle(0, 180, 0)
	end
	
	if self.ActiveAttachments.bg_glock17scifi then
        self:setBodygroup(self.TritiumBGs.main, self.TritiumBGs.off)
    end
end

function SWEP:fireAnimFunc()
	local cyc = 0
	local clip = self:Clip1()

	if self.ActiveAttachments.md_rmr and self:isAiming() or self.ActiveAttachments.md_microt1 and self:isAiming() then
		cyc = 1
	end

	if clip > 0 then
		self:sendWeaponAnim("fire",1,cyc)
	end
end

SWEP.LaserPosAdjust = Vector(0, 0, -1.25)
SWEP.LaserAngAdjust = Angle(0, 180, 0)

SWEP.LuaViewmodelRecoil = false
SWEP.LuaViewmodelRecoilOverride = false
SWEP.CanRestOnObjects = false

function SWEP:SetupDataTables()
self:NetworkVar("Int", 0, "State")
self:NetworkVar("Int", 1, "Shots")
self:NetworkVar("Int", 2, "INS2LAMMode")
self:NetworkVar("Float", 0, "HolsterDelay")
self:NetworkVar("Bool", 0, "Suppressed")
self:NetworkVar("Bool", 1, "Safe")
self:NetworkVar("Bool", 2, "BipodDeployed")
self:NetworkVar("Bool", 3, "M203Active")
self:NetworkVar("Angle", 0, "ViewOffset")
end

if CustomizableWeaponry_NeN_G17 and CustomizableWeaponry_KK and CustomizableWeaponry_KK.ins2 then
SWEP.Attachments = {[1] = {header = "Sight", offset = {850, -350}, atts = {"md_microt1", "md_rmr"}},
[2] = {header = "Barrel", offset = {-600, -350}, atts = {"md_tundra9mm", "md_cobram2"}},
[3] = {header = "Rail", offset = {-900, 100}, atts = {"md_insight_x2", "md_g17laser", "kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_m6x"}},
[4] = {header = "Tritium", offset = {-50, -700}, atts = {"bg_tritiumG17"}},
["+reload"] = {header = "Ammo", offset = {850, 25}, atts = {"am_magnum", "am_matchgrade"}},
["+use"] = {header = "Skin", offset = {-50, -400}, atts = {"bg_glock17black", "bg_glock17tan", "bg_glock17green", "bg_glock17nickel", "bg_glock17scifi"}}}
elseif CustomizableWeaponry_NeN_G17 then
SWEP.Attachments = {[1] = {header = "Sight", offset = {850, -350}, atts = {"md_microt1", "md_rmr"}},
[2] = {header = "Barrel", offset = {-600, -350}, atts = {"md_tundra9mm", "md_cobram2"}},
[3] = {header = "Rail", offset = {-900, 100}, atts = {"md_insight_x2", "md_g17laser"}},
[4] = {header = "Tritium", offset = {-50, -700}, atts = {"bg_tritiumG17"}},
["+reload"] = {header = "Ammo", offset = {850, 25}, atts = {"am_magnum", "am_matchgrade"}},
["+use"] = {header = "Skin", offset = {-50, -400}, atts = {"bg_glock17black", "bg_glock17tan", "bg_glock17green", "bg_glock17nickel", "bg_glock17scifi"}}}
elseif CustomizableWeaponry_KK and CustomizableWeaponry_KK.ins2 then
SWEP.Attachments = {[1] = {header = "Sight", offset = {850, -350}, atts = {"md_microt1", "md_rmr"}},
[2] = {header = "Barrel", offset = {-600, -350}, atts = {"md_tundra9mm", "md_cobram2"}},
[3] = {header = "Rail", offset = {-900, 100}, atts = {"md_insight_x2", "md_g17laser", "kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_m6x"}},
[4] = {header = "Tritium", offset = {-50, -700}, atts = {"bg_tritiumG17"}},
["+reload"] = {header = "Ammo", offset = {850, 25}, atts = {"am_magnum", "am_matchgrade"}},
["+use"] = {header = "Skin", offset = {-50, -400}, atts = {"bg_glock17black"}}}
else
SWEP.Attachments = {[1] = {header = "Sight", offset = {850, -350}, atts = {"md_microt1", "md_rmr"}},
[2] = {header = "Barrel", offset = {-600, -350}, atts = {"md_tundra9mm", "md_cobram2"}},
[3] = {header = "Rail", offset = {-900, 100}, atts = {"md_insight_x2", "md_g17laser"}},
[4] = {header = "Tritium", offset = {-50, -700}, atts = {"bg_tritiumG17"}},
["+reload"] = {header = "Ammo", offset = {850, 25}, atts = {"am_magnum", "am_matchgrade"}},
["+use"] = {header = "Skin", offset = {-50, -400}, atts = {"bg_glock17black"}}}
end

SWEP.Animations = {fire = {"shoot_1"},
	reload = "glock_reload",
	reload_empty = "glock_reload",
	idle = "glock_idle",
	draw = "glock_draw"}
	
SWEP.Sounds = {glock_draw = {[1] = {time = 0, sound = "CW_glock17_DRAW"}},

	glock_reload = {[1] = {time = 0.42, sound = "CW_glock17_MAGOUT"},
	[2] = {time = 1.55, sound = "CW_glock17_MAGIN"},
	[3] = {time = 2.05, sound = "CW_glock17_SLIDERELEASE"}}}

SWEP.SpeedDec = 5

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi", "safe"}
SWEP.Base = "cw_base"
SWEP.Category = "Norra's SWEPs"

SWEP.Author			= "Niggarto el Negro"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/NeN/Glock 17/v_pist_glock17.mdl"
SWEP.WorldModel		= "models/weapons/NeN/Glock 17/w_pist_glock17.mdl"

SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/NeN/Glock 17/w_pist_glock17.mdl"
SWEP.WMPos = Vector(-0.4, 0, -0.4)
SWEP.WMAng = Vector(-4, 0, 185)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 17
SWEP.Primary.DefaultClip	= 17
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_glock17_FIRE_T"
SWEP.FireSoundSuppressed = "CW_glock17_FIRE_SUPPRESSED"
SWEP.Recoil = 0.49

SWEP.HipSpread = 0.035
SWEP.AimSpread = 0.009
SWEP.VelocitySensitivity = 1.25
SWEP.MaxSpreadInc = 0.046
SWEP.SpreadPerShot = 0.009
SWEP.SpreadCooldown = 0.11
SWEP.Shots = 1
SWEP.Damage = 0.5
SWEP.DeployTime = 0.7
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.6
SWEP.ReloadHalt = 2.65

SWEP.ReloadTime_Empty = 1.6
SWEP.ReloadHalt_Empty = 2.65

if CLIENT then
    function SWEP:createCustomVM(mdl)
        self.CW_VM = self:createManagedCModel(mdl, RENDERGROUP_BOTH)
        self.CW_VM:SetNoDraw(true)
        self.CW_VM:SetupBones()
        self.CW_VM:SetOwner( self.Owner ) -- FIX: PlayerWeaponColor can't find owner for proxy.
       
        if self.ViewModelFlip then
            local mtr = Matrix()
            mtr:Scale(Vector(1, -1, 1))
           
            self.CW_VM:EnableMatrix("RenderMultiply", mtr)
        end
    end
end