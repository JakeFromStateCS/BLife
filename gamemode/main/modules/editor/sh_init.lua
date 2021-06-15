--sh_init.lua
MODULE = MODULE or {};
MODULE.Hooks = MODULE.Hooks or {};
MODULE.Nets = MODULE.Nets or {};
MODULE.Name = "Editor";

function MODULE:OnLoad()

end;

if( SERVER ) then

	function MODULE:SpawnEntity( class, pos )
		print( class, pos );
		local ent = ents.Create( class );
		ent:SetPos( pos );
		ent:Spawn();
		if( ent:IsValid() ) then
			return ent;
		end;
	end;


	function MODULE.Hooks:PlayerButtonDown( client, button )
			if( button == KEY_E ) then
				Base.Modules:NetMessage( client, "SpawnEntity", client );
				--net.Start( "character_move" );
				--	net.WriteEntity( client.Character );
				--net.Send( client );
			elseif( button == MOUSE_RIGHT ) then
			end;

	end;

	function MODULE.Nets:SpawnEntity()
		local client = net.ReadEntity();
		local class = net.ReadString();
		local pos = net.ReadVector();
		if( client:IsPlayer() ) then
			--if( client:IsAdmin() or client:SteamID() == "STEAM_0:1:20456822" ) then
				self:SpawnEntity( class, pos );
			--end;
		end;
	end;

else

	function MODULE.Nets:SpawnEntity()
		print( "yo" );
		local client = net.ReadEntity();
		print( client );
		local trace = LocalPlayer():GetViewTrace();
		Base.Modules:NetMessage( "SpawnEntity", LocalPlayer(), "money_printer", trace.HitPos );
	end;
end;