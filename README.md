# androidgame
our first android gaaaame yaaay

Some lua notes
--------------
1)
--single line comment

--[[
block comment
]]--

3)
print(whatever you want) for debugging output

2)
NULL in C or null in Java is nil in lua
Lua is garbage collected, free memory is: x = nil

3) tables

t = {}   --create a table
t[x] = y; -- typical array access
t.x = y; -- like t["x"] so basically a string key access

4) scoping

no keyword for globals, just on the top level
locals are the natural scoping

5) logic

~= not equal to
== first checks the type! so no compiler error between 
   different types, instead alsways false!
e.g.  "0" == 0 -- no automatic conversion

6) Strings

string concatanation double dot 
local str = "foo ".."bar"

7) length is unary #

8) functions can be variables like javascript

9) IMPORTANT! arrays are 1-based (DAFUQ) arrays start from 1 not 0

10)

x,y = y,x swap values

11)Animation ( Image/sprite sheets)
	local sheet1 = graphics.newImageSheet( "damn2b.png", { width=50, height=55, numFrames=6,  } )
	local instance1 = display.newSprite( sheet1, { name="cat", start=1, count=6, time=200, loopCount=1} )
	instance1.xScale = 1  --resize eikonas (1=100%)
	instance1.yScale = 1  --resize
	instance1.x = whiteTLX --sidetagmenes tou animation
    instance1.y = whiteTLY -- same
	instance1:play() 	--play