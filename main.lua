local soundID = audio.loadSound( "sounds/froot.wav" )
local background = display.newImage("images/bg.jpg", display.contentCenterX, display.contentCenterY);
local file_name = "images/froot.png";
local halfW = display.viewableContentWidth / 2
local halfH = display.viewableContentHeight / 2
--Dimiourgia Animation
local sheet1 = graphics.newImageSheet( "animation2.png", { width=50, height=55, numFrames=6,  } )
local instance1 = display.newSprite( sheet1, { name="cat", start=1, count=6, time=200, loopCount=1} )
instance1.isVisible=false
instance1.xScale = 1
instance1.yScale = 1
--end of animation init
local counter=0
text="Strawberries clicked: "..tostring(counter)
local myText = display.newText(text, 80, 24, native.systemFont, 16 )
myText:setFillColor( 1, 0, 0 )

local unview = function( event )
	if event.phase=="began" then
		counter=counter+1
		myText.text="Strawberries clicked: "..tostring( counter )
		event.target.isVisible=false
		local whiteTLX, whiteTLY = event.target:localToContent( 0, 0 ) --finds coordinates of the touched item
		instance1.x = whiteTLX
        instance1.y = whiteTLY --passes touched coordinates to to animation 
        event.target.isVisible=false
		display.remove( event.target )
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

 







