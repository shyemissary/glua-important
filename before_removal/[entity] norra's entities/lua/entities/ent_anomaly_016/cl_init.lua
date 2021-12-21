include("shared.lua");

function ENT:Draw()
	self:DrawModel();
end;


net.Receive("c016contain",function()
	local wid = (ScrW()/4)/2

	local wid = Lerp( FrameTime() * 10, 0 , wid )
	local function cProgress()
		print(math.Round(wid, 1))
		draw.RoundedBox(5,ScrW()/2 - (ScrW()/4)/2, ScrH()/2 - (ScrH()/20)/2, ScrW()/4, ScrH()/20 ,Color(255,255,255))
		draw.RoundedBox(5,ScrW()/2 - (ScrW()/4)/2 + 2  , ScrH()/2 - (ScrH()/20)/2 +2 , ScrW()/4 - 4 - wid , ScrH()/20 - 4 ,Color(255,55,55))
		timer.Simple(10, function() hook.Remove("HUDPaint", "identifier_c016"); end)

	end;
	
	hook.Add("HUDPaint","identifier_c016", cProgress)


end)