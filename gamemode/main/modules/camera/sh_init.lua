MODULE = MODULE or {};
MODULE.Name = "Camera";
MODULE.Hooks = MODULE.Hooks or {};
MODULE.Nets = MODULE.Nets or {};
MODULE.Config = {};

local playerMeta = FindMetaTable( "Player" );

function MODULE:OnLoad()
	Base.Camera = self;

	if( CLIENT ) then
		self.Config.zoom = 100;
		self.Config.zoomRate = 3;
		self.Config.right = -7--40;
		self.Config.up = 5;
		self.Config.yaw = 0;--math.atan( self.Config.zoom / self.Config.right );
		self.Config.pitch = 0;
		self.zoom = self.Config.zoom;
		self.right = self.Config.right;
		self.up = self.Config.up
		self.yaw = self.Config.yaw;
		self.pitch = self.Config.pitch;
	else

	end;
end;

if( CLIENT ) then

	function playerMeta:GetViewTrace()
		return Base.Camera:GetEyeTrace( self );
	end;

	function MODULE:GetEyeTrace( client )
		if( self.viewAng ) then
			local trace = {};
			trace.start = self.calcviewPos
			trace.endpos = trace.start + self.viewAng:Forward() * 5000;
			trace.filter = client;
			trace = util.TraceLine( trace );
			return trace;
		end;
		return {};
	end;

	function MODULE.Hooks:CalcView( client, pos, ang, fov, nearZ, farZ )
		local view = {};

		view.origin = pos - ( ang:Forward() * self.zoom ) + ang:Right() * self.right + Vector( 0, 0, self.zoom / 10 + self.up );
		view.angles = ang + Angle( self.pitch, self.yaw, 0 );
		view.fov = fov;

		if( input.IsKeyDown( KEY_C ) ) then
			view.angles = self.viewAng;
		end;

		self.calcviewAng = view.angles;
		self.calcviewPos = view.origin;

		return view;
	end;

	function MODULE.Hooks:ShouldDrawLocalPlayer()
		if( self.zoom > 0 ) then
			local boneIndex = LocalPlayer():LookupBone("ValveBiped.Bip01_Head1")
			LocalPlayer():ManipulateBoneScale( boneIndex, Vector( 1, 1, 1 ) );
			
			return true;
		else
			local boneIndex = LocalPlayer():LookupBone("ValveBiped.Bip01_Head1")
			LocalPlayer():ManipulateBoneScale( boneIndex, Vector( 0, 0, 0 ) );
			
			return false;
		end;
	end;

	function MODULE.Hooks:InputMouseApply( cmd, x, y, ang )
		if( input.IsKeyDown( KEY_C ) ) then
			if( self.viewAng == Angle( 0, 0, 0 ) ) then
				self.viewAng = self.calcviewAng;
			else
				ang.p = y / 20;
				ang.y =  -x / 20;
				self.viewAng = self.viewAng + ang;
				self.prevMouseAng = ang;


				self.viewAng.p = math.Clamp( self.viewAng.p, -70, 70 );
				self.viewAng.y = math.Clamp( self.viewAng.y, LocalPlayer():GetAngles().y - 30, LocalPlayer():GetAngles().y );
				self.zoom = math.Approach( self.zoom, 0, -self.Config.zoomRate );
				self.up = math.Approach( self.up, 0, -self.Config.zoomRate );
				self.right = math.Approach( self.right, 0, self.Config.zoomRate );
			end;
			--LocalPlayer():SetEyeAngles( ang );
			return true;
		else
			self.viewAng = self.calcviewAng;
			--self.viewAng = Angle( 0, 0, 0 );
			self.prevMouseAng = Angle( 0, 0, 0 );
			self.zoom = math.Approach( self.zoom, self.Config.zoom, self.Config.zoomRate );
			self.right = math.Approach( self.right, self.Config.right, self.Config.zoomRate );
			self.up = math.Approach( self.up, self.Config.up, -self.Config.zoomRate );
		end;
	end;

	function MODULE.Hooks:HUDPaint()
		if( !input.IsKeyDown( KEY_C ) ) then
			if( self.viewAng ) then
				local viewTrace = LocalPlayer():GetViewTrace();
				local viewpos = viewTrace.HitPos;
				local scrPos = viewpos:ToScreen();

				local eyeTrace = LocalPlayer():GetEyeTrace();
				local hitPos = eyeTrace.HitPos;
				local scrEyePos = hitPos:ToScreen();


				surface.SetDrawColor( Color( 255, 255, 255 ) );
				--surface.DrawRect( scrPos.x - 5, scrPos.y - 5, 10, 10 );
				--surface.DrawRect( scrEyePos.x - 5, scrEyePos.y - 5, 10, 10 );
				surface.DrawCircle( scrEyePos.x - 3, scrEyePos.y - 3, 6, Color( 255, 100, 100 ) );
			end;	
		end;
	end;

	function MODULE.Hooks:Think()
		if( self.viewAng ) then
			--local eyeTrace = LocalPlayer():GetEyeTrace();
			--local viewTrace = LocalPlayer():GetViewTrace();

			--local shootDist = EyePos():Distance( eyeTrace.HitPos );
			
			--local accDist = math.sqrt( ( eyeTrace.HitPos.x - viewTrace.HitPos.x ) ^2 + ( eyeTrace.HitPos.y - viewTrace.HitPos.y ))
			--local viewDist = self.calcviewPos:Distance( viewTrace.HitPos );
			--local sub = self.calcviewPos:Distance( eyeTrace.HitPos );
			--self.pitch = math.deg( math.atan( ( self.zoom + shootDist) / ( self.calcviewPos.z - eyeTrace.StartPos.z ) ) ) -- 180;
			--if( math.ceil( self.pitch ) == -90 ) then
			
			--end;
			self.pitch = 0--math.Clamp( self.pitch - 90 , -21, 0 );
			--local ang = ( self.calcviewPos - EyePos() ):Angle();

			--self.yaw = 0--math.deg( ( self.zoom + dist ) / self.right ) / 180;
			--if( self.yaw < 0 ) then
			--	self.yaw = 360 + self.yaw;
			--end;
			--print( self.yaw, dist, viewDist );

			--self.Config.yaw = LocalPlayer():GetAngles().y - self.calcviewAng.y;
		end;
	end;

else

end;