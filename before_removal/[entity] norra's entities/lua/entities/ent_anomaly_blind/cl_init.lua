include("shared.lua");

function ENT:Draw()
	self:DrawModel();
end;

net.Receive("vAnomalyBlind",function(len)

	local isBlinded = net.ReadBool();

	if isBlinded then
		local function cBlind()
			draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color( 0, 0, 0 ) )
		end
		hook.Add( "HUDPaint", "ent_blind", cBlind)
	else
		hook.Remove( "HUDPaint", "ent_blind")
	end



end)