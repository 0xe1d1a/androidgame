local _W = display.viewableContentWidth
local _H = display.viewableContentHeight
local soundID = audio.loadSound( "froot.wav" )
local background = display.newImage("back.jpg", display.contentCenterX, display.contentCenterY);
local froot = "froot.png";
local view = display.newImage(froot);
view.x=_W/5
view.y=_H/2

----- TEEEEEEEEEEEEST----------
-- an image sheet with a cat
local baseline=200
local sheet1 = graphics.newImageSheet( "damn2b.png", { width=50, height=55, numFrames=6,  } )

-- play 8 frames every 1000 ms
local instance1 = display.newSprite( sheet1, { name="cat", start=1, count=6, time=200, loopCount=1} )


instance1.xScale = 1
instance1.yScale = 1

--------------------------------------------------------------------------------------

local physics = require ("physics")
physics.start();
borderBodyElement = { density = 1.0, friction = 0.1, bounce = 1 }
physics.addBody(view,"dynamic",{density=1.0, friction=0.5, bounce=0.3})
view:applyForce(500,0,view.x,view.y)

local leftWall = display.newRect (0, 0, 1, display.contentHeight);
local rightWall = display.newRect (display.contentWidth, 0, 1, display.contentHeight);
local ceiling = display.newRect (0, 0, display.contentWidth, 1);
local bot = display.newRect( 10, display.contentHeight, display.contentWidth, 0)
physics.addBody( bot, "static", borderBodyElement )

function view:touch(event)
	if event.phase=="began" then
		local whiteTLX, whiteTLY = view:localToContent( 0, 0 )
		print( "White square's top-left position in screen coordinates: ", whiteTLX, whiteTLY )
		print ("TOUCHED???")
		instance1.x = whiteTLX
        instance1.y = whiteTLY 
		view.isVisible=false
		instance1.isVisible=true
		audio.play(soundID)
		instance1:play()
		return true
	end
end

view:addEventListener("touch",view)
instance1:addEventListener( "end", instance1 )




