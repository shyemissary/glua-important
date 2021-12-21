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

    c:ChatPrint("This drink tastes weird, but it's probably nothing.")

    c:EmitSound( "npc/barnacle/barnacle_gulp" .. math.random( 1,2 ) .. ".wav", 150, 100, 1 )
 
    SafeRemoveEntity(self)

        timer.Simple( 8, function() c:TakeDamage(15) end )

        timer.Simple( 7.5, function() c:EmitSound("vo/npc/male01/moan01.wav") end )

        timer.Simple( 14, function() c:TakeDamage(35) end )

        timer.Simple( 13.5, function() c:EmitSound("vo/npc/male01/moan02.wav") end )

end


