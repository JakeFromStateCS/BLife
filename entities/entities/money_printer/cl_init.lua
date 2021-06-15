include("shared.lua")

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos() + self:GetRight() * 15 - self:GetForward() * 15;
	local Ang = self:GetAngles()

	local owner = "Dicks";
	--owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")

	--surface.SetFont("HUDNumber5")
	local text = "Fuck"--DarkRP.getPhrase("money_printer")
	local TextWidth = surface.GetTextSize(text)
	local TextWidth2 = surface.GetTextSize(owner)

	Ang:RotateAroundAxis(Ang:Up(), 90)

	cam.Start3D2D(Pos + Ang:Up() * 11.5, Ang, 0.11)
		if( Base.VGUI ~= nil ) then
			surface.SetDrawColor( Base.VGUI.Config.colors.theme );
			surface.DrawRect( 0, 0, 100, 40 );
			--draw.WordBox(2, -TextWidth*0.5, -30, text, "HUDNumber5", Color(140, 0, 0, 100), Color(255,255,255,255))
			--draw.WordBox(2, -TextWidth2*0.5, 18, owner, "HUDNumber5", Color(140, 0, 0, 100), Color(255,255,255,255))
		end;
	cam.End3D2D()
end

function ENT:Think()
end

