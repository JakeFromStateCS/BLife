MODULE = MODULE or {};
MODULE.Name = "Screens";
MODULE.Hooks = MODULE.Hooks or {};
MODULE.Nets = MODULE.Nets or {};
MODULE.Config = MODULE.Config or {};
MODULE.Stored = MODULE.Stored or {};
MODULE.VGUIs = MODULE.VGUIs or {};
if( CLIENT ) then

	function MODULE:RegisterScreenVGUI( name, tab )
		self.VGUIs[name] = tab;
	end;

	local screenButton = {
		data = {
			pos = { x = 0, y = 0 },
			ang = Angle( 0, 0, 90 ),
			size = {
				w = 10,
				h = 10
			};
			parent = nil,
			scale = 1,
			offset = nil,
			normal = nil,
			angOffset = nil,
			visible = true,
			rotations = {
				Right = nil,
				Up = nil,
				Forward = nil
			}
		},
		children = {
		}
	};
	screenButton.__index = screenButton;

	function screenButton:SetPos( x, y )
		local scale = self:GetParent():GetScale();
		if( scale ) then
			x = x;
			y = y;
		end;
		self.data.pos = { x = x, y = y };
	end;

	function screenButton:GetPos()
		return self.data.pos or { x = 0, y = 0 };
	end;

	function screenButton:SetParent( parent )
		if( parent.data ) then
			self.data.parent = parent;
		end;
	end;

	function screenButton:GetParent()
		return self.data.parent;
	end;

	function screenButton:SetSize( w, h )
		if( self.data.parent ) then
			local scale = self.data.parent:GetScale();
			w = w / scale;
			h = h / scale;
			print( scale );
		end;
		self.data.size.w = w;
		self.data.size.h = h;
	end;

	function screenButton:GetSize()
		return self.data.size or {
			w = 10,
			h = 10
		};
	end;

	function screenButton:Paint()

	end;

	function screenButton:Draw()
		if( !self.data.visible ) then
			return;
		end;
		local normal = self:GetParent():GetNormal();
		local offset = self:GetPos();
		local parPos = self:GetParent():GetPos();
		local parAng = self:GetParent():GetAngles();
		local scale = self:GetParent():GetScale();
		if( normal ) then
			self.data.forward = normal:Forward() * offset.x;
			self.data.right = normal:Right() * offset.y;
			self.data.up = Vector( 0, 0, 0 );
		end;
		local pos = ( parPos + self.data.forward + self.data.right + self.data.up );
		--render.ClearStencil()
		--render.SetStencilEnable( true )

		
			cam.Start3D2D( pos, parAng, scale );
				--render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
	    			--render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
				self:Paint();
			cam.End3D2D();
		--render.SetStencilEnable( false );
	end;

	function screenButton:Think()
		if( self.data.parent ~= nil ) then
			self.data.pos = self.data.parent:GetPos();
			self.data.ang = self.data.parent:GetAngles()
			self.data.normal = ang;
			for funcName,val in pairs( self.data.rotations ) do
				if( val ) then
					self.data.ang:RotateAroundAxis( self.data.normal[funcName](), val );
				end;
			end;
		else
			self.data.normal = self.data.ang;
			self.data.ang = self.data.ang;
		end;
	end;




	local defScreen = {
		data = {
			pos = Vector( 0, 0, 0 ),
			ang = Angle( 0, 0, 90 ),
			size = {
				w = 10,
				h = 10
			};
			parent = nil,
			scale = 1,
			offset = nil,
			normal = nil,
			angOffset = nil,
			visible = true,
			rotations = {
				Right = nil,
				Up = nil,
				Forward = nil
			}
		},
		children = {
		}
	};
	defScreen.__index = defScreen;

	function defScreen:AddChild( panel )
		table.insert( self.children, panel );
		return self.children[#self.children];
	end;

	function defScreen:SetScale( scale )
		self.data.scale = scale;
	end;

	function defScreen:GetScale()
		return self.data.scale or 1;
	end;

	function defScreen:SetPos( pos )
		self.data.pos = pos;
	end;

	function defScreen:GetPos()
		return self.data.pos or Vector( 0, 0, 0 );
	end;

	function defScreen:SetAngles( ang )
		self.data.ang = ang;
	end;

	function defScreen:GetAngles()
		return self.data.ang or Angle( 0, 0, 0 );
	end;

	function defScreen:SetOffset( vec )
		self.data.offset = vec;
	end;

	function defScreen:GetOffset()
		return self.data.offset or Vector( 0, 0, 0 );
	end;

	function defScreen:SetAngleOffset( ang )
		self.data.angOffset = ang;
	end;

	function defScreen:GetAngleOffset()
		return self.data.angOffset or Angle( 0, 0, 0 );
	end;

	function defScreen:SetNormal( ang )
		self.data.normal = ang;
	end;

	function defScreen:GetNormal()
		return self.data.normal or Angle( 0, 0, 0 );
	end;

	function defScreen:SetParent( parent )
		if( parent:IsValid() ) then
			self.data.parent = parent;
		end;
	end;

	function defScreen:GetParent()
		return self.data.parent;
	end;

	function defScreen:RotateAroundAxis( axis, val )
		self.data.rotations[axis] = val;
	end;

	function defScreen:SetSize( w, h )
		self.data.size.w = w / self.data.scale;
		self.data.size.h = h / self.data.scale;
	end;

	function defScreen:GetSize()
		return self.data.size or {
			w = 10,
			h = 10
		};
	end;

	function defScreen:Paint()

	end;

	function defScreen:Think()
		if( self.data.parent ~= nil ) then
			if( self.data.parent:IsValid() ) then
				self.data.pos = self.data.parent:GetPos();
				self.data.ang = self.data.parent:GetAngles();
				self.data.normal = ang;
				for funcName,val in pairs( self.data.rotations ) do
					if( val ) then
						self.data.ang:RotateAroundAxis( self.data.normal[funcName](), val );
					end;
				end;
			end;
		else
			self.data.normal = self.data.ang;
			self.data.ang = self.data.ang;
		end;
	end;

	function defScreen:Draw()
		if( !self.data.visible ) then
			return;
		end;
		local normal = self:GetNormal();
		local offset = self:GetOffset();
		if( normal ) then
			self.data.forward = normal:Forward() * offset.x;
			self.data.right = normal:Right() * offset.y;
			self.data.up = normal:Up() * offset.z;
		end;
		local pos = ( self.data.pos + self.data.forward + self.data.right + self.data.up );
		render.ClearStencil()
		render.SetStencilEnable(true)

		render.SetStencilFailOperation(STENCILOPERATION_KEEP)
		render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
		render.SetStencilReferenceValue(1)
			cam.Start3D2D( pos, self.data.ang, self.data.scale );
				local size = self:GetSize();
					surface.SetDrawColor( Color( 0, 0, 0, 255 ) );
					surface.DrawRect( 0, 0, size.w / self.data.scale, size.h / self.data.scale );
					render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
	    				render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
					self:Paint();
			cam.End3D2D();
			for index,panel in pairs( self.children ) do
				if( panel.Draw) then
					panel:Draw();
				end;
			end;
		
		render.SetStencilEnable(false)
	end;

	function MODULE:OnLoad()
		Base.Screens = self;

		Base.Screens:RegisterScreenVGUI( "button", screenButton );

		Shit = Base.Screens:CreateScreen();
		ShitButton = Base.Screens:CreateVGUI( "button", Shit );
		Shit:SetPos( LocalPlayer():EyePos() + LocalPlayer():GetForward() * 50 -  LocalPlayer():GetRight() * 20 + LocalPlayer():GetUp() * 50 );
		Shit:SetAngles( Angle( 0, 90, 90 ) );
		Shit:SetScale( 0.1 );
		Shit:SetSize( 10, 10 );
		function Shit:Paint()
			local size = self:GetSize();
			surface.SetTextColor( Color( 255, 255, 255, 255 ) );
			surface.SetFont( "ChatFont" );
			surface.SetTextPos( 0, 0 );
			surface.DrawText( "TEST SCREEN! <3" );
			surface.SetTextPos( 0, 15 );
			surface.DrawText( "These screens are objects to which I can add more objects such as buttons" );
			surface.SetTextPos( 0, 30 );
			surface.DrawText( "They don't allow drawing outside of their bounds" );
			surface.SetTextPos( 0, 45 );
			surface.DrawText( "Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test " );
			
			for i=1, 360 do
				--local x, y = math.sin( i / 58 ) * 100, math.cos( i / 58) * 100;
				--surface.SetDrawColor( HSVToColor( i, 1, 1 ) );
				--surface.DrawRect( size.w / 0.1 / 2 + x, size.h / 0.1 / 2 + y, 10, 10 );
			end;
			--surface.DrawRect( 0, 0, size.w, size.h );
		end;
		ShitButton:SetPos( 50, 50 )
		ShitButton:SetSize( 10, 10 );
		function ShitButton:Paint()
			local size = self:GetSize();
			surface.SetDrawColor( Color( 255, 255, 255 ) );
			surface.DrawRect( 0, 0, size.w, size.h );
			for i=1, 360 do
				local parSize = Shit:GetSize();
				local x, y = math.sin( ( i + CurTime() * 100 ) / 57 ) * 100, math.cos( ( i + CurTime() * 100 ) / 57 ) * 100;
				surface.SetDrawColor( HSVToColor( i, 1, 1 ) );
				surface.DrawRect( size.w / 2 + x, size.h / 2 + y, 10, 10 );
			end;
		end;
	end;

	function MODULE:CreateVGUI( name, parent )
		if( self.VGUIs[name] ) then
			local obj = {};
			setmetatable( obj, self.VGUIs[name] );
			if( parent ) then
				obj:SetParent( parent );
			end;
			obj = parent:AddChild( obj );
			return obj;
		end;
	end;

	function MODULE:CreateScreen()
		local screen = {};
		setmetatable( screen, defScreen );
		screen.Paint = screen:Paint();
		table.insert( self.Stored, screen );
		return self.Stored[#self.Stored];
	end;

	function MODULE.Hooks:PostDrawOpaqueRenderables()
		for index,screen in pairs( self.Stored ) do
			if( screen.Draw ) then
				screen:Draw();
				
			end;
		end;
	end;

	function MODULE.Hooks:Think()
		for index,screen in pairs( self.Stored ) do
			if( screen.Think ) then
				screen:Think();
				
			end;
		end;
	end;


end;