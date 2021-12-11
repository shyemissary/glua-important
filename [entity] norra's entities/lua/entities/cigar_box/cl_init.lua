include("shared.lua")



surface.CreateFont("diesel_big", {

	font = "Merriweather",

	size = 128,

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



	ang:RotateAroundAxis( oang:Up(), 90 )

	ang:RotateAroundAxis( oang:Right(), -90 )

	ang:RotateAroundAxis( oang:Up(), -90)


	pos = pos + oang:Forward()*-3 + oang:Up() * -1.4 + oang:Right() * 2



	if alpha > 0 then

		cam.Start3D2D( pos, ang, 0.025 )

			draw.SimpleText( "Club", "diesel_big", 0, 0, Color(255,255,255, alpha) )

			draw.DrawText( "Cigars", "diesel_big", -35, 95, Color(255,255,255, alpha) )

		cam.End3D2D()

	end



end