include("shared.lua")

local draw = draw
local Color = Color
local vgui = vgui
local net = net
local surface = surface

surface.CreateFont( "close_roboto", {
    font = "Roboto",
    size = 13
} )

surface.CreateFont( "title_roboto", {
    font = "Roboto",
    size = 22
} )

surface.CreateFont( "option_roboto", {
    font = "Roboto",
    size = 17
} )

--------------------------------------

local scrw, scrh = ScrW(), ScrH()

local posx, posy = scrw / 2, scrh / 2
local width, height = 200, 265

local framecolor = Color( 45, 55, 65, 255 )

--------------------------------------d

local cb_width, cb_height = 20, 20
local cb_posx, cb_posy = width-25, height-height+5

local cb_color = Color( 255, 100, 100 )

local cb_textcolor = Color( 0, 0, 0 )

--------------------------------------

local t_x, t_y = 10, 10
local t_w, t_h = 280, 22

local t_text = "Select Outfit:"

--------------------------------------

local suit_x, suit_y = 25, 60
local suit_w, suit_h = 150, 50

local suit_text = "Random Suit"
local suit_color = Color( 0,185,45 )

--------------------------------------

local civi_x, civi_y = 25, 125
local civi_w, civi_h = 150, 50

local civi_text = "Random Civilian"

--------------------------------------

local mil_x, mil_y = 25, 190
local mil_w, mil_h = 150, 50

local mil_text = "Random Military"

--------------------------------------
local function outfitGUI()

    local DermaPanel = vgui.Create( "DFrame" )
    DermaPanel:SetPos( posx, posy )
    DermaPanel:SetTitle( "" )
    DermaPanel:SetSize( 0, 0 )
    DermaPanel:Center()
    DermaPanel:ShowCloseButton( false )
    DermaPanel:SetSizable( false )
    DermaPanel:MakePopup()

    local isAnimating = true
    DermaPanel:SizeTo(width, height, 1, 0, .1, function()
        isAnimating = false
    end)

    DermaPanel.Paint = function()
        surface.SetDrawColor(framecolor)
        surface.DrawRect(0,0,width,height)
    end

    --------------------------------------

    local closebtn = vgui.Create( "DButton", DermaPanel )
    closebtn:SetText( "" )
    closebtn:SetPos( cb_posx, cb_posy )
    closebtn:SetSize( cb_width, cb_height )
    closebtn.DoClick = function()
        --Optional close animation (buggy)
        --isAnimating = true
        --DermaPanel:SizeTo(0, 0, 0.5, 0, .1, function()
        --    isAnimating = false
        --end)
        surface.PlaySound("buttons/blip1.wav")
        DermaPanel:Close()
    end
    closebtn.Paint = function()
        draw.RoundedBox( 5, 0, 0, cb_width, cb_height, cb_color )
    end

    local closebtn_text = vgui.Create( "DLabel", DermaPanel )
    closebtn_text:SetPos( cb_posx + 7, cb_posy+1 )
    closebtn_text:SetText( "X" )
    closebtn_text:SetFont( "close_roboto" )
    closebtn_text:SetColor( cb_textcolor )

    --------------------------------------

    local title = vgui.Create( "DLabel", DermaPanel )
    title:SetPos( t_x, t_y )
    title:SetSize( t_w, t_h )
    title:SetText( t_text )
    title:SetFont( "title_roboto" )
    title:SetColor( Color( 255,255,255 ) )

    DermaPanel.OnSizeChanged = function()
        if isAnimating then
            DermaPanel:Center()
        end
    end

    --------------------------------------

    local suitbtn = vgui.Create( "DButton", DermaPanel )
    suitbtn:SetText( "" )
    suitbtn:SetPos( suit_x, suit_y )
    suitbtn:SetSize( suit_w, suit_h )
    suitbtn.DoClick = function()

		net.Start("choseSuit")
		net.SendToServer()
    	DermaPanel:Close()
    end

    suitbtn.Paint = function()
        draw.RoundedBox( 5, 0, 0, suit_w, suit_h, suit_color )
    end

    local suitbtntext = vgui.Create( "DLabel", DermaPanel )
    suitbtntext:SetPos( suit_x + 32, suit_y + 19)
    suitbtntext:SetSize( 100, 14 )
    suitbtntext:SetText( suit_text )
    suitbtntext:SetFont( "option_roboto" )
    suitbtntext:SetColor( Color( 0, 0, 0 ) )

    --------------------------------------

    local suitbtn = vgui.Create( "DButton", DermaPanel )
    suitbtn:SetText( "" )
    suitbtn:SetPos( civi_x, civi_y )
    suitbtn:SetSize( civi_w, civi_h )
    suitbtn.DoClick = function()

		net.Start("choseCivi")
		net.SendToServer()  	
    	DermaPanel:Close()
    end

    suitbtn.Paint = function()
        draw.RoundedBox( 5, 0, 0, civi_w, civi_h, suit_color )
    end

    local suitbtntext = vgui.Create( "DLabel", DermaPanel )
    suitbtntext:SetPos( civi_x + 22, civi_y + 19)
    suitbtntext:SetSize( 120, 14 )
    suitbtntext:SetText( civi_text )
    suitbtntext:SetFont( "option_roboto" )
    suitbtntext:SetColor( Color( 0, 0, 0 ) )

    --------------------------------------

    local suitbtn = vgui.Create( "DButton", DermaPanel )
    suitbtn:SetText( "" )
    suitbtn:SetPos( mil_x, mil_y )
    suitbtn:SetSize( mil_w, mil_h )
    suitbtn.DoClick = function()

		net.Start("choseMil")
		net.SendToServer()    	
    	DermaPanel:Close()
    end

    suitbtn.Paint = function()
        draw.RoundedBox( 5, 0, 0, mil_w, mil_h, suit_color )
    end

    local suitbtntext = vgui.Create( "DLabel", DermaPanel )
    suitbtntext:SetPos( mil_x + 22, mil_y + 19)
    suitbtntext:SetSize( 120, 14 )
    suitbtntext:SetText( mil_text )
    suitbtntext:SetFont( "option_roboto" )
    suitbtntext:SetColor( Color( 0, 0, 0 ) )

    --------------------------------------
end

net.Receive("OpenOutfitMenu", outfitGUI)

    --------------------------------------

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

            draw.SimpleText( "Outfit", "diesel_big", 0, 0, Color(255,255,255, alpha) )

            draw.DrawText( "Press [E] to interact", "diesel_small", 0, 128, Color(255,255,255, alpha) )

        cam.End3D2D()

    end



end