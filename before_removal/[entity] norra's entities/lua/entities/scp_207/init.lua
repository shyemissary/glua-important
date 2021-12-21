AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()

    self:SetModel("models/thenextscp/scp207/cola.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()

    end
end

function ENT:Use(a , c)

    c:ChatPrint("You decide to drink the whole bottle, but you feel abnormally more energetic.")

    c:EmitSound( "npc/barnacle/barnacle_gulp" .. math.random( 1,2 ) .. ".wav", 150, 100, 1 )
 
    SafeRemoveEntity(self)

    a:SetRunSpeed(330)
	a:SetWalkSpeed(220)

	timer.Simple(300, function() 

		c:ChatPrint("You begin to feel more tired than before. Maybe the spurt of energy is over.")

		a:SetRunSpeed(240)
		a:SetWalkSpeed(105)

	end

	)

        

end


