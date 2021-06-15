MODULE = MODULE or {};
MODULE.Name = "HUD";
MODULE.Hooks = MODULE.Hooks or {};
MODULE.Nets = MODULE.Nets or {};

surface.CreateFont( "HUDXSmall_Alpha", {
	size = 20,
	antialias = true,
	weight = 400,
	font = "default"
} );

surface.CreateFont( "HUDXMedium_Alpha", {
	size = 25,
	antialias = true,
	weight = 400,
	font = "default"
} );

surface.CreateFont( "HUDXTiny_Alpha", {
	size = 16,
	antialias = true,
	weight = 400,
	font = "default"
} );

surface.CreateFont( "HUDXMedium_Bold", {
	size = 25,
	antialias = true,
	weight = 800,
	font = "default"
} );



function MODULE.Hooks:HUDPaint()
	for _,client in pairs( player.GetAll() ) do
		local boneIndex = client:LookupBone("ValveBiped.Bip01_Head1")
		local pos, ang = client:GetBonePosition( boneIndex );
		pos = pos + LocalPlayer():GetUp() * 15;
		local dist = pos:Distance( EyePos() );
		if( dist <= 500 ) then
			local alpha = math.Clamp( 255 - dist / 2 + 50, 0, 255 )
			local scrPos = pos:ToScreen();
			surface.SetFont( "HUDXMedium_Alpha" );
			local W, H = surface.GetTextSize( client:Nick() );
			surface.SetTextPos( scrPos.x - W / 2, scrPos.y - H - 5 );
			surface.SetTextColor( Color( 255, 255, 255, alpha ) );
			surface.DrawText( client:Nick() );
			if( client ~= LocalPlayer() ) then
				local hp = client:Health();
				local yPos = scrPos.y - H + 25;
				surface.SetDrawColor( Color( 50, 50, 50, 200, alpha ) );
				surface.DrawRect( scrPos.x - 51, yPos, 102, 12 );
				surface.SetDrawColor( Color( 255, 100, 100, alpha ) );
				surface.DrawRect( scrPos.x - 50, yPos + 1, hp, 10 );
				surface.SetFont( "HUDXTiny_Alpha" );
				local W, H = surface.GetTextSize( hp );
				surface.SetTextColor( Color( 255, 255, 255, alpha) );
				surface.SetTextPos( scrPos.x - 50 + hp + 1 - W, yPos + 6 - H / 2 );
				surface.DrawText( hp );
			end;
		end;
	end;
	--local activeWep = client:GetActiveWeapon();
	--if( activeWep:IsValid() ) then
		
	--end;
end;

function MODULE.Hooks:PostDrawOpaqueRenderables()
	--local ang = EyeAngles();
	local boneIndex = LocalPlayer():LookupBone("ValveBiped.Bip01_Head1")
	local pos, ang = LocalPlayer():GetBonePosition( boneIndex );
	local activeWep = LocalPlayer():GetActiveWeapon();
	if( activeWep:IsValid() ) then
		local ammo = activeWep:Clip1();
		local ammo2 = LocalPlayer():GetAmmoCount( activeWep:GetPrimaryAmmoType() );
		cam.Start3D2D(  pos + LocalPlayer():GetRight() * 7 + LocalPlayer():GetUp() * 5, Angle( 0, LocalPlayer():GetAngles().y - 90, 90 ), 0.125)
			surface.SetDrawColor( Color( 50, 50, 50, 200 ) );
			surface.DrawRect( 0, 0, 100, 45 );
			surface.SetDrawColor( Color( 255, 100, 100 ) );
			surface.DrawRect( 0, 41, 100, 4 );
			surface.SetTextColor( Color( 255, 100, 100 ) );
			surface.SetTextPos( 5, 5 );
			surface.SetFont( "HUDXSmall_Alpha" );
			surface.DrawText( ammo .. "/" .. ammo2 );
		cam.End3D2D();
		cam.Start3D2D( pos + LocalPlayer():GetUp() * 12 - LocalPlayer():GetRight() * 7, Angle( 0, LocalPlayer():GetAngles().y - 90, 90 ), 0.125 )
			surface.SetDrawColor( Color( 50, 50, 50, 200 ) );
			surface.DrawRect( 0, 0, 102, 12 );
			surface.SetDrawColor( Color( 255, 100, 100 ) );
			surface.DrawRect( 1, 1, LocalPlayer():Health(), 10 );
			surface.SetFont( "HUDXTiny_Alpha" );
			local W, H = surface.GetTextSize( LocalPlayer():Health() );
			surface.SetTextColor( Color( 255, 255, 255 ) );
			surface.SetTextPos( LocalPlayer():Health() + 1 - W, 6 - H / 2 );
			surface.DrawText( LocalPlayer():Health() );
		cam.End3D2D();
	end;

end;

function MODULE.Hooks:HUDShouldDraw( name )
	local noDraw = {
			"CHudDeathNotice",
			"CHudChat",
			"CHudHealth",
			"CHudBattery",
			"CHudSecondaryAmmo",
			"CHudAmmo",
			"CHudHintDisplay",
			"CHudCrosshair",
	}
	return !table.HasValue( noDraw, name );
end;