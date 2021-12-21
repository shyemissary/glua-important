if (SERVER) then
    SWEP.Weight = 0;
    SWEP.AutoSwitchTo = false;
    SWEP.AutoSwitchFrom = false;
elseif (CLIENT) then
    SWEP.Author = "Norra";
    SWEP.Purpose = "Upgrade Droids with a random weapon";
    SWEP.Instructions = "Left click to give a Droid a random weapon.";
    SWEP.PrintName = "Droid Upgrader";
    SWEP.Slot = 4;
    SWEP.SlotPos = 1;
    SWEP.DrawAmmo = false;
    SWEP.DrawCrosshair = true;
end;

SWEP.AccurateCrosshair = true;
SWEP.Category = "Norra's SWEPs";
SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;

SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 95
SWEP.ViewModelFlip = true
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/v_c4.mdl"
SWEP.WorldModel = "models/weapons/w_satchel_hls.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
    ["v_weapon.Right_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(-1.668, 0.2, 0), angle = Angle(10, 0, 0) },
    ["v_weapon.Left_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(13, 7, 10) },
    ["v_weapon.c4"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.Primary.ClipSize = -1;
SWEP.Primary.DefaultClip = -1;
SWEP.Primary.Automatic = false;
SWEP.Primary.Ammo = "";
SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.DefaultClip = -1;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.Ammo = "";

---------------------------------------------------------------------

function SWEP:PrimaryAttack()

    local owner = self.Owner

    if CLIENT then

        return;

    end;

    

    self:SetNextPrimaryFire(CurTime() + 1)

    

    local target = owner:GetEyeTrace().Entity

    

    if (!IsValid(target)) then

        DarkRP.notify(owner, 1, 4, "This is not a player!");



        return;

    end;

    

    local plypos = owner:GetPos();

    local entpos = target:GetPos();

    local distancesquared = plypos:DistToSqr(entpos);

    local distance = 100;

    local rangesquared = distance * distance;   

    

    if (distancesquared > rangesquared) then

        DarkRP.notify(owner, 1, 4, "That Droid is too far away!");



        return;

    end;

    if target:GetNWBool("isUpgradedDroid") then

        DarkRP.notify(owner, 1, 4, "This Droid has already been upgraded!");

        return
    end

    local HitSound   = {
    "npc/dog/dog_servo12.wav",
    "npc/dog/dog_servo7.wav"
    };

    local upgradeWeps = {
        
        "cw_tr09_auga3",
        "cw_m14",
        "cw_c7a1",
        "cw_jng90",
        "bo2r_m27",
        "cw_acr",
        "cw_ws_m16a4",
        "cw_m249_official",
        "cw_g36c",
        "cw_scarh",
        "cw_aacgsm",
        "cw_tr09_qbz97",
        "cw_tr09_tar21",
        "cw_ppsh-41",
        "cw_rpd"
        
    };

    local selectedUpgrade = table.Random(upgradeWeps);

    local teams = {
        "Anderson Robotics Peregrine Droid"
    };   

    if target:IsPlayer() then       
    
        if ( table.HasValue(teams, team.GetName( target:Team() ) ) ) then

            owner:EmitSound(table.Random(HitSound),60)
            target:Give(selectedUpgrade, false)
            owner:Say("/me upgrades " .. target:GetName() .. " with an " .. selectedUpgrade .. ".")
            target:SetNWBool("isUpgradedDroid", true); 
            
            return false
        end

    end;

    

end


---------------------------------------------------------------------

SWEP.VElements = {
    ["ammo"] = { type = "Model", model = "models/Items/BoxMRounds.mdl", bone = "v_weapon", rel = "", pos = Vector(0.5, -9, 16), angle = Angle(-94, -90, 1), size = Vector(0.33, 0.33, 0.33), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

---------------------------------------------------------------------

function SWEP:Initialize()

    // other initialize code goes here


    self:SetHoldType("slam");


    if CLIENT then

        // Create a new table for every weapon instance
        self.VElements = table.FullCopy( self.VElements )
        self.WElements = table.FullCopy( self.WElements )
        self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

        self:CreateModels(self.VElements) // create viewmodels
        self:CreateModels(self.WElements) // create worldmodels

        // init view model bone build function
        if IsValid(self.Owner) then
            local vm = self.Owner:GetViewModel()
            if IsValid(vm) then
                self:ResetBonePositions(vm)

                // Init viewmodel visibility
                if (self.ShowViewModel == nil or self.ShowViewModel) then
                    vm:SetColor(Color(255,255,255,255))
                else
                    // we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
                    vm:SetColor(Color(255,255,255,1))
                    // ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
                    // however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
                    vm:SetMaterial("Debug/hsv")
                end
            end
        end

    end

end


if CLIENT then

    SWEP.vRenderOrder = nil
    function SWEP:ViewModelDrawn()

        local vm = self.Owner:GetViewModel()
        if !IsValid(vm) then return end

        if (!self.VElements) then return end

        self:UpdateBonePositions(vm)

        if (!self.vRenderOrder) then

            // we build a render order because sprites need to be drawn after models
            self.vRenderOrder = {}

            for k, v in pairs( self.VElements ) do
                if (v.type == "Model") then
                    table.insert(self.vRenderOrder, 1, k)
                elseif (v.type == "Sprite" or v.type == "Quad") then
                    table.insert(self.vRenderOrder, k)
                end
            end

        end

        for k, name in ipairs( self.vRenderOrder ) do

            local v = self.VElements[name]
            if (!v) then self.vRenderOrder = nil break end
            if (v.hide) then continue end

            local model = v.modelEnt
            local sprite = v.spriteMaterial

            if (!v.bone) then continue end

            local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )

            if (!pos) then continue end

            if (v.type == "Model" and IsValid(model)) then

                model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)

                model:SetAngles(ang)
                //model:SetModelScale(v.size)
                local matrix = Matrix()
                matrix:Scale(v.size)
                model:EnableMatrix( "RenderMultiply", matrix )

                if (v.material == "") then
                    model:SetMaterial("")
                elseif (model:GetMaterial() != v.material) then
                    model:SetMaterial( v.material )
                end

                if (v.skin and v.skin != model:GetSkin()) then
                    model:SetSkin(v.skin)
                end

                if (v.bodygroup) then
                    for k, v in pairs( v.bodygroup ) do
                        if (model:GetBodygroup(k) != v) then
                            model:SetBodygroup(k, v)
                        end
                    end
                end

                if (v.surpresslightning) then
                    render.SuppressEngineLighting(true)
                end

                render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
                render.SetBlend(v.color.a/255)
                model:DrawModel()
                render.SetBlend(1)
                render.SetColorModulation(1, 1, 1)

                if (v.surpresslightning) then
                    render.SuppressEngineLighting(false)
                end

            elseif (v.type == "Sprite" and sprite) then

                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                render.SetMaterial(sprite)
                render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)

            elseif (v.type == "Quad" and v.draw_func) then

                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)

                cam.Start3D2D(drawpos, ang, v.size)
                    v.draw_func( self )
                cam.End3D2D()

            end

        end

    end

    SWEP.wRenderOrder = nil
    function SWEP:DrawWorldModel()

        if (self.ShowWorldModel == nil or self.ShowWorldModel) then
            self:DrawModel()
        end

        if (!self.WElements) then return end

        if (!self.wRenderOrder) then

            self.wRenderOrder = {}

            for k, v in pairs( self.WElements ) do
                if (v.type == "Model") then
                    table.insert(self.wRenderOrder, 1, k)
                elseif (v.type == "Sprite" or v.type == "Quad") then
                    table.insert(self.wRenderOrder, k)
                end
            end

        end

        if (IsValid(self.Owner)) then
            bone_ent = self.Owner
        else
            // when the weapon is dropped
            bone_ent = self
        end

        for k, name in pairs( self.wRenderOrder ) do

            local v = self.WElements[name]
            if (!v) then self.wRenderOrder = nil break end
            if (v.hide) then continue end

            local pos, ang

            if (v.bone) then
                pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
            else
                pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
            end

            if (!pos) then continue end

            local model = v.modelEnt
            local sprite = v.spriteMaterial

            if (v.type == "Model" and IsValid(model)) then

                model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)

                model:SetAngles(ang)
                //model:SetModelScale(v.size)
                local matrix = Matrix()
                matrix:Scale(v.size)
                model:EnableMatrix( "RenderMultiply", matrix )

                if (v.material == "") then
                    model:SetMaterial("")
                elseif (model:GetMaterial() != v.material) then
                    model:SetMaterial( v.material )
                end

                if (v.skin and v.skin != model:GetSkin()) then
                    model:SetSkin(v.skin)
                end

                if (v.bodygroup) then
                    for k, v in pairs( v.bodygroup ) do
                        if (model:GetBodygroup(k) != v) then
                            model:SetBodygroup(k, v)
                        end
                    end
                end

                if (v.surpresslightning) then
                    render.SuppressEngineLighting(true)
                end

                render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
                render.SetBlend(v.color.a/255)
                model:DrawModel()
                render.SetBlend(1)
                render.SetColorModulation(1, 1, 1)

                if (v.surpresslightning) then
                    render.SuppressEngineLighting(false)
                end

            elseif (v.type == "Sprite" and sprite) then

                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                render.SetMaterial(sprite)
                render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)

            elseif (v.type == "Quad" and v.draw_func) then

                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)

                cam.Start3D2D(drawpos, ang, v.size)
                    v.draw_func( self )
                cam.End3D2D()

            end

        end

    end

    function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )

        local bone, pos, ang
        if (tab.rel and tab.rel != "") then

            local v = basetab[tab.rel]

            if (!v) then return end

            // Technically, if there exists an element with the same name as a bone
            // you can get in an infinite loop. Let's just hope nobody's that stupid.
            pos, ang = self:GetBoneOrientation( basetab, v, ent )

            if (!pos) then return end

            pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)

        else

            bone = ent:LookupBone(bone_override or tab.bone)

            if (!bone) then return end

            pos, ang = Vector(0,0,0), Angle(0,0,0)
            local m = ent:GetBoneMatrix(bone)
            if (m) then
                pos, ang = m:GetTranslation(), m:GetAngles()
            end

            if (IsValid(self.Owner) and self.Owner:IsPlayer() and
                ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
                ang.r = -ang.r // Fixes mirrored models
            end

        end

        return pos, ang
    end

    function SWEP:CreateModels( tab )

        if (!tab) then return end

        // Create the clientside models here because Garry says we can't do it in the render hook
        for k, v in pairs( tab ) do
            if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and
                    string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then

                v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
                if (IsValid(v.modelEnt)) then
                    v.modelEnt:SetPos(self:GetPos())
                    v.modelEnt:SetAngles(self:GetAngles())
                    v.modelEnt:SetParent(self)
                    v.modelEnt:SetNoDraw(true)
                    v.createdModel = v.model
                else
                    v.modelEnt = nil
                end

            elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite)
                and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then

                local name = v.sprite.."-"
                local params = { ["$basetexture"] = v.sprite }
                // make sure we create a unique name based on the selected options
                local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
                for i, j in pairs( tocheck ) do
                    if (v[j]) then
                        params["$"..j] = 1
                        name = name.."1"
                    else
                        name = name.."0"
                    end
                end

                v.createdSprite = v.sprite
                v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)

            end
        end

    end

    local allbones
    local hasGarryFixedBoneScalingYet = false

    function SWEP:UpdateBonePositions(vm)

        if self.ViewModelBoneMods then

            if (!vm:GetBoneCount()) then return end

            // !! WORKAROUND !! //
            // We need to check all model names :/
            local loopthrough = self.ViewModelBoneMods
            if (!hasGarryFixedBoneScalingYet) then
                allbones = {}
                for i=0, vm:GetBoneCount() do
                    local bonename = vm:GetBoneName(i)
                    if (self.ViewModelBoneMods[bonename]) then
                        allbones[bonename] = self.ViewModelBoneMods[bonename]
                    else
                        allbones[bonename] = {
                            scale = Vector(1,1,1),
                            pos = Vector(0,0,0),
                            angle = Angle(0,0,0)
                        }
                    end
                end

                loopthrough = allbones
            end
            // !! ----------- !! //

            for k, v in pairs( loopthrough ) do
                local bone = vm:LookupBone(k)
                if (!bone) then continue end

                // !! WORKAROUND !! //
                local s = Vector(v.scale.x,v.scale.y,v.scale.z)
                local p = Vector(v.pos.x,v.pos.y,v.pos.z)
                local ms = Vector(1,1,1)
                if (!hasGarryFixedBoneScalingYet) then
                    local cur = vm:GetBoneParent(bone)
                    while(cur >= 0) do
                        local pscale = loopthrough[vm:GetBoneName(cur)].scale
                        ms = ms * pscale
                        cur = vm:GetBoneParent(cur)
                    end
                end

                s = s * ms
                // !! ----------- !! //

                if vm:GetManipulateBoneScale(bone) != s then
                    vm:ManipulateBoneScale( bone, s )
                end
                if vm:GetManipulateBoneAngles(bone) != v.angle then
                    vm:ManipulateBoneAngles( bone, v.angle )
                end
                if vm:GetManipulateBonePosition(bone) != p then
                    vm:ManipulateBonePosition( bone, p )
                end
            end
        else
            self:ResetBonePositions(vm)
        end

    end

    function SWEP:ResetBonePositions(vm)

        if (!vm:GetBoneCount()) then return end
        for i=0, vm:GetBoneCount() do
            vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
            vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
            vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
        end

    end

end
