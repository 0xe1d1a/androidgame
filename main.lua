local soundID = audio.loadSound( "sounds/froot.wav" )
local background = display.newImage("images/bg.jpg", display.contentCenterX, display.contentCenterY);
local file_name = "images/froot.png";
local halfW = display.viewableContentWidth / 2
local halfH = display.viewableContentHeight / 2
local sheet1 = graphics.newImageSheet( "animation2.png", { width=50, height=55, numFrames=6,  } )
local instance1 = display.newSprite( sheet1, { name="cat", start=1, count=6, time=200, loopCount=1} )
instance1.isVisible=false
instance1.xScale = 1
instance1.yScale = 1

local unview = function( event )
	if event.phase=="began" then
		print ("TOUCHED")
		event.target.isVisible=false
		local whiteTLX, whiteTLY = event.target:localToContent( 0, 0 )
		instance1.x = whiteTLX
        instance1.y = whiteTLY 
        event.target.isVisible=false
		instance1.isVisible=true
		instance1:play()

		--audio.play(soundID)
		return true
	end
end


local physics = require ("physics")
physics.start();




---- Border initialization -----
borderBodyElement = { density = 5.0, friction = 0.1, bounce = 0.7 }
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

---- Spawn objects ----

for i=1,5 do
	local view = display.newImage(file_name);
	view:translate( halfW + math.random( -100, 100 ), halfH + math.random( -100, 100 ) )
	--view:applyForce(math.random(-100, 100), 50, view.x, view.y)
	view.vx = math.random( 1, 5 )
	view.vy = math.random( -2, 2 )
	physics.addBody(view,"dynamic",{density=1.0, friction=0.9, bounce=0.3})
	view:addEventListener( "touch", unview )
end  

 







