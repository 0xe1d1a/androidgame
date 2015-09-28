local _W = display.viewableContentWidth
local _H = display.viewableContentHeight
local soundID = audio.loadSound( "froot.wav" )
local background = display.newImage("bg.jpg", display.contentCenterX, display.contentCenterY);
local froot = "froot.png";
local view = display.newImage(froot);

view.x=_W/5
view.y=_H/2

local physics = require ("physics")
physics.start();
borderBodyElement = { density = 5.0, friction = 0.1, bounce = 0.7 }
physics.addBody(view,"dynamic",{density=1.0, friction=0.9, bounce=0.3})
view:applyForce(5000,50,view.x,view.y)

local borderTop = display.newRect( -50, 0, 1, display.viewableContentHeight*2 )
--borderTop:setFillColor( 0, 0, 0, 0)		-- make invisible
physics.addBody( borderTop, "static", borderBodyElement )

local borderBottom = display.newRect( 0, 320, 2000, 1 ) --bot
--borderBottom:setFillColor( 0, 0, 0, 0)		-- make invisible
physics.addBody( borderBottom, "static", borderBodyElement )

local borderLeft = display.newRect( 0, -5, 2000, 1 ) --top border
--borderLeft:setFillColor( 0, 0, 0, 0)		-- make invisible
physics.addBody( borderLeft, "static", borderBodyElement )

local borderRight = display.newRect( 550, 250, 1, 500 ) --right border
--borderRight:setFillColor( 0, 0, 0, 0)		-- make invisible
physics.addBody( borderRight, "static", borderBodyElement )

function view:touch(event)
	if event.phase=="began" then
		print ("TOUCHED")
		view.isVisible=false
		--audio.play(soundID)
		return true
	end
end

view:addEventListener("touch",view)





