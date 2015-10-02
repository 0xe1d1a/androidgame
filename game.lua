--Attack of the killer cubes

local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local json = require( "json" )
local utility = require( "utility" )
local physics = require( "physics" )
local myData = require( "mydata" )

-- 
-- define local variables here
--

local spawnTimer            -- will be used to hold the timer for the spawning engine
local fn_img_fish = "images/bubble.png"
local fn_img_bg = "images/background.jpg"
local fn_snd_onclick = "sounds/froot.wav"
local fn_img_anim2 = "images/animation2.png"
local counter = 0
local counter_left = 15
local myText
local _width = display.actualContentWidth
local _height= display.actualContentHeight
--
-- define local functions here
--



local function handleWin( event )
    --
    -- When you tap the "I Win" button, reset the "nextlevel" scene, then goto it.
    --
    -- Using a button to go to the nextlevel screen isn't realistic, but however you determine to 
    -- when the level was successfully beaten, the code below shows you how to call the gameover scene.
    --
    if event.phase == "ended" then
        composer.removeScene("nextlevel")
        composer.gotoScene("nextlevel", { time= 500, effect = "crossFade" })
    end
    return true
end

local function handleLoss( event )
    --
    -- When you tap the "I Loose" button, reset the "gameover" scene, then goto it.
    --
    -- Using a button to end the game isn't realistic, but however you determine to 
    -- end the game, the code below shows you how to call the gameover scene.
    --
    if event.phase == "ended" then
        composer.removeScene("gameover")
        composer.gotoScene("gameover", { time= 500, effect = "crossFade" })
    end
    return true
end

local unview = function( event )
    if event.phase=="began" then
        counter = counter + 1
        myText.text="Get 10 fish! "..counter_left.." fish left! Fish clicked: "..counter
        --animation_display( event )
        event.target:removeSelf( )
        if counter == 10 then
            myText.text = "Well played :)"
        end
        --audio.play(soundID)
        return true
    end
end

function countdown(event)
    if counter == 10 then return end
    local view = event.source.param
    display.remove( view )
    if counter_left == 1 then
        myText.text = "You lose biatch!"
        return
    end
    counter_left = counter_left - 1
    myText.text = "Get 10 fish! "..counter_left.." fish left! Fish clicked: "..counter
end

function appear(event)
    if counter_left == 1 or counter == 10 then
        timer.cancel( spawnTimer )
        return
    end
    local sceneGroup = scene.view  
    local view = display.newImage(fn_img_fish);
    view:translate( math.random( 50, display.actualContentWidth-50 ),  math.random( 50, display.actualContentHeight-50 ) )
    physics.addBody(view,"dynamic",{density=1.0, friction=0.0, bounce=1.0})
    view.gravityScale = 0
    view:setLinearVelocity( math.random(-300,300)   , math.random(-300,300) )
    view:addEventListener( "touch", unview )
    sceneGroup:insert(view)
    local timer_disappear = timer.performWithDelay( 1000, countdown )
    timer_disappear.param = view
end


--
-- This function gets called when composer.gotoScene() gets called an either:
--    a) the scene has never been visited before or
--    b) you called composer.removeScene() or composer.removeHidden() from some other
--       scene.  It's possible (and desirable in many cases) to call this once, but 
--       show it multiple times.
--
function scene:create( event )
    --
    -- self in this case is "scene", the scene object for this level. 
    -- Make a local copy of the scene's "view group" and call it "sceneGroup". 
    -- This is where you must insert everything (display.* objects only) that you want
    -- Composer to manage for you.
    local sceneGroup = self.view

    -- 
    -- You need to start the physics engine to be able to add objects to it, but...
    --
    physics.start()
    --
    -- because the scene is off screen being created, we don't want the simulation doing
    -- anything yet, so pause it for now.
    --
    physics.pause()

    --
    -- make a copy of the current level value out of our
    -- non-Global app wide storage table.
    --
    local thisLevel = myData.settings.currentLevel

    --
    -- create your objects here
    --
    
    --
    -- These pieces of the app only need created.  We won't be accessing them any where else
    -- so it's okay to make it "local" here
    --
    local background = display.newImage(fn_img_bg, display.contentCenterX, display.contentCenterY);
    sceneGroup:insert(background)

    --
    -- levelText is going to be accessed from the scene:show function. It cannot be local to
    -- scene:create(). This is why it was declared at the top of the module so it can be seen 
    -- everywhere in this module

    text="Get 10 fish! "..counter_left.." fish left Fish clicked: "..counter
    myText = display.newText(text, 135, 24, native.systemFont, 16 )
    myText:setFillColor( 1, 0, 0 )
    myText.alpha = 0
    sceneGroup:insert( myText )

    -- 
    -- because we want to access this in multiple functions, we need to forward declare the variable and
    -- then create the object here in scene:create()
    --
    --
    -- these two buttons exist as a quick way to let you test
    -- going between scenes (as well as demo widget.newButton)
    --

    local iWin = widget.newButton({
        label = "I Win!",
        onEvent = handleWin
    })
    sceneGroup:insert(iWin)
    iWin.x = display.contentCenterX - 100
    iWin.y = display.contentHeight - 60

    local iLoose = widget.newButton({
        label = "I Lose!",
        onEvent = handleLoss
    })
    sceneGroup:insert(iLoose)
    iLoose.x = display.contentCenterX + 100
    iLoose.y = display.contentHeight - 60

    -- border init
    borderBodyElement = { density = 1.0, friction = 0.0, bounce = 1.0 }

    local borderTop = display.newRect(0, 0, _width*2, 1)
    --borderTop:setFillColor( 0, 0, 0, 0)       -- make invisible
    physics.addBody( borderTop, "static", borderBodyElement )

    local borderBottom = display.newRect( 0, _height, _width*2, 1 ) --bot
    --borderBottom:setFillColor( 0, 0, 0, 0)        -- make invisible
    physics.addBody( borderBottom, "static", borderBodyElement )

    local borderLeft = display.newRect( 0, 0, 1, _height*2 ) --top border
    --borderLeft:setFillColor( 0, 0, 0, 0)      -- make invisible
    physics.addBody( borderLeft, "static", borderBodyElement )

    local borderRight = display.newRect( _width, _height, 1, _height*2 ) --right border
    --borderRight:setFillColor( 0, 0, 0, 0)     -- make invisible
    physics.addBody( borderRight, "static", borderBodyElement )
    -- end of border init

end

--
-- This gets called twice, once before the scene is moved on screen and again once
-- afterwards as a result of calling composer.gotoScene()
--
function scene:show( event )
    --
    -- Make a local reference to the scene's view for scene:show()
    --
    local sceneGroup = self.view

    --
    -- event.phase == "did" happens after the scene has been transitioned on screen. 
    -- Here is where you start up things that need to start happening, such as timers,
    -- tranistions, physics, music playing, etc. 
    -- In this case, resume physics by calling physics.start()
    -- Fade out the levelText (i.e start a transition)
    -- Start up the enemy spawning engine after the levelText fades
    --
    if event.phase == "did" then
        physics.start()
        transition.to( myText, { time = 450, alpha = 1 } )
        spawnTimer = timer.performWithDelay( 1000, appear, -1 )
    else -- event.phase == "will"
        -- The "will" phase happens before the scene transitions on screen.  This is a great
        -- place to "reset" things that might be reset, i.e. move an object back to its starting
        -- position. Since the scene isn't on screen yet, your users won't see things "jump" to new
        -- locations. In this case, reset the score to 0.
    end
end

--
-- This function gets called everytime you call composer.gotoScene() from this module.
-- It will get called twice, once before we transition the scene off screen and once again 
-- after the scene is off screen.
function scene:hide( event )
    local sceneGroup = self.view
    
    if event.phase == "will" then
        -- The "will" phase happens before the scene is transitioned off screen. Stop
        -- anything you started elsewhere that could still be moving or triggering such as:
        -- Remove enterFrame listeners here
        -- stop timers, phsics, any audio playing
        --
        physics.stop()
        timer.cancel( spawnTimer )
    end

end

--
-- When you call composer.removeScene() from another module, composer will go through and
-- remove anything created with display.* and inserted into the scene's view group for you. In
-- many cases that's sufficent to remove your scene. 
--
-- But there may be somethings you loaded, like audio in scene:create() that won't be disposed for
-- you. This is where you dispose of those things.
-- In most cases there won't be much to do here.
function scene:destroy( event )
    local sceneGroup = self.view
    
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
