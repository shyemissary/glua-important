include("shared.lua")



surface.CreateFont("diesel_big", {

	font = "Roboto",

	size = 128,

	weight = 800,

	antialias = true

})



surface.CreateFont("diesel_small", {

	font = "Roboto",

	size = 72,

	weight = 800,

	antialias = true

})

function InverseLerp( pos, p1, p2 )



	local range = 0

	range = p2-p1



	if range == 0 then return 1 end



	return ((pos - p1)/range)



end

function ENT:Draw()

	self:DrawModel()



	local alpha = 255

	local viewdist = 175



	-- calculate alpha

	local max = viewdist

	local min = viewdist*0.75



	local dist = LocalPlayer():EyePos():Distance( self:GetPos() )



	if dist > min and dist < max then

		local frac = InverseLerp( dist, max, min )

		alpha = alpha * frac

	elseif dist > max then

		alpha = 0

	end



	local oang = self:GetAngles()

	local opos = self:GetPos()



	local ang = self:GetAngles()

	local pos = self:GetPos()



	ang:RotateAroundAxis( oang:Up(), 85 )

	ang:RotateAroundAxis( oang:Right(), -67 )

	ang:RotateAroundAxis( oang:Up(), -7)



	pos = pos + oang:Forward()*2 + oang:Up() * 6 + oang:Right() * 7



	if alpha > 0 then

		cam.Start3D2D( pos, ang, 0.025 )

			draw.SimpleText( "Cuffs", "diesel_big", 0, 0, Color(255,255,255, alpha) )

			draw.DrawText( "Press [E] to interact", "diesel_small", 0, 128, Color(255,255,255, alpha) )

		cam.End3D2D()

	end



end