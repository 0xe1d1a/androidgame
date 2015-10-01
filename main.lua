
local fn_img_froot = "images/bubble.png"
local fn_img_bg = "images/background.jpg"
local fn_snd_onclick = "sounds/froot.wav"
local fn_img_anim2 = "images/animation2.png"


local soundID = audio.loadSound(fn_snd_onclick);
local background = display.newImage(fn_img_bg, display.contentCenterX, display.contentCenterY);

--display counter init
local counter = 0
local counter_left = 15
text="Get 10 fish! "..counter_left.." fish left Fish clicked: "..tostring( counter )
local myText = display.newText(text, 100, 24, native.systemFont, 16 )
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
		myText.text="Get 10 fish! "..counter_left.." fish left! Fish clicked: "..tostring( counter )
		animation_display( event )
		if counter == 10 then
			myText.text = "Well played :)"
		end
		--audio.play(soundID)
		return true
	end
end



local physics = require ("physics")
physics.start();
physics.setGravity( 0.1, 1 )


-- border init
borderBodyElement = { density = 1.0, friction = 0.0, bounce = 1.0 }

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


function countdown(event)
	if counter == 10 then return end
	display.remove( event.source.param )
	event.source.param = nil
	counter_left = counter_left - 1
	myText.text="Get 10 fish! "..counter_left.." fish left! Fish clicked: "..tostring( counter )
end

function appear(event)
	--view = display.newImage(fn_img_froot);
	if counter == 10 then return end
	local view = event.source.param
	view.isVisible = true
	view:translate( math.random( 50, display.actualContentWidth-50 ),  math.random( 50, display.actualContentHeight-50 ) )
	--view:applyForce(math.random(-100, 100), 50, view.x, view.y)

	physics.addBody(view,"dynamic",{density=1.0, friction=0.0, bounce=1.0})
	view.gravityScale = 0
	view:setLinearVelocity( math.random(-300,300)	, math.random(-300,300) )
	view:addEventListener( "touch", unview )
end
---- Spawn objects ----
local halfW = display.actualContentWidth / 2
local halfH = display.actualContentHeight / 2
local t = 1000

for i=1,15 do
	rand_time = math.random(1000,5000)
	view = display.newImage(fn_img_froot);
	view.isVisible = false
	local cb_appear =  timer.performWithDelay( t, appear )
	cb_appear.param = view
	local cb_countdown = timer.performWithDelay( t+rand_time, countdown )
	cb_countdown.param = cb_appear.param
	t = t + rand_time
end  







