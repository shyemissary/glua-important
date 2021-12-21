AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")


function ENT:Initialize()

    self:SetModel("models/margarita/margarita.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()

    end
end

function ENT:Use(a , c)

    c:ChatPrint("This drink tastes delicious.")

    c:EmitSound( "npc/barnacle/barnacle_gulp" .. math.random( 1,2 ) .. ".wav", 150, 100, 1 )
 
    SafeRemoveEntity(self)

end


