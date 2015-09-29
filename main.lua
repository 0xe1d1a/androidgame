
local fn_img_froot = "images/bubble.png"
local fn_img_bg = "images/background.jpg"
local fn_snd_onclick = "sounds/froot.wav"
local fn_img_anim2 = "images/animation2.png"


local soundID = audio.loadSound(fn_snd_onclick);
local background = display.newImage(fn_img_bg, display.contentCenterX, display.contentCenterY);

--display counter init
local counter = 0
text="Strawberries clicked: "..tostring(counter)
local myText = display.newText(text, 80, 24, native.systemFont, 16 )
myText:setFillColor( 1, 0, 0 )
--end of display counter init


--animation init
local sheet1 = graphics.newImageSheet( fn_img_anim2, { width=50, height=55, numFrames=6  } )
local sheet_instance = display.newSprite( sheet1, { name="cat", start=1, count=6, time=200, loopCount=1} )
sheet_instance.isVisible=false
sheet_instance.xScale = 1
sheet_instance.yScale = 1
--end of animation init


function animation_display( event )
		local whiteTLX, whiteTLY = event.target:localToContent( 0, 0 ) --finds coordinates of the touched item
		sheet_instance.x = whiteTLX
	    sheet_instance.y = whiteTLY --passes touched coordinates to to animation 
	    event.target.isVisible=false
		display.remove( event.target )
		sheet_instance.isVisible=true
		sheet_instance:play()
end

	

local unview = function( event )
	if event.phase=="began" then
		counter=counter+1
		myText.text="Strawberries clicked: "..tostring( counter )
		animation_display( event )
		--audio.play(soundID)
		return true
	end
end



local physics = require ("physics")
physics.start();
physics.setGravity( 0.1, 1 )


-- border init
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
-- end of border init



---- Spawn objects ----
local halfW = display.viewableContentWidth / 2
local halfH = display.viewableContentHeight / 2
for i=1,5 do
	local view = display.newImage(fn_img_froot);
	view:translate( halfW + math.random( -100, 100 ), halfH + math.random( -100, 100 ) )
	--view:applyForce(math.random(-100, 100), 50, view.x, view.y)
	view.vx = math.random( 1, 5 )
	view.vy = math.random( -2, 2 )
	physics.addBody(view,"dynamic",{density=1.0, friction=0.9, bounce=0.3})
	view:addEventListener( "touch", unview )
end  

 







