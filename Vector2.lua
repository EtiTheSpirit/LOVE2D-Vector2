local vec2 = {}

function vec2.new(x, y)
	local x = x or 0
	local y = y or 0
	local v = {
				[1] = x; --First index x
				[2] = y; --Second index y
				X = x; --Uppercase X property
				Y = y; --Uppercase Y property
				x = x; --Lowercase x property
				y = y; --Lowercase y property
			}
			
	v.mt ={} --Our metatable
	setmetatable(v, v.mt)
	
	v.Add = function (a, b)
		if getmetatable(a) ~= "Vector2" or getmetatable(b) ~= "Vector2" then
			return vec2.new()
		end
		local x = a.X + b.X
		local y = a.Y + b.Y
		return vec2.new(x, y)
	end
	v.Subtract = function (a, b)
		if getmetatable(a) ~= "Vector2" or getmetatable(b) ~= "Vector2" then
			return vec2.new()
		end
		local x = a.X - b.X
		local y = a.Y - b.Y
		return vec2.new(x, y)
	end
	v.Multiply = function (a, b)
		if getmetatable(a) ~= "Vector2" or getmetatable(b) ~= "Vector2" then
			return vec2.new()
		end
		local x = a.X * b.X
		local y = a.Y * b.Y
		return vec2.new(x, y)
	end
	v.Divide = function (a, b)
		if getmetatable(a) ~= "Vector2" or getmetatable(b) ~= "Vector2" then
			return vec2.new()
		end
		local x = a.X / b.X
		local y = a.Y / b.Y
		return vec2.new(x, y)
	end
	v.Print = function (a)
		if getmetatable(a) ~= "Vector2" then
			return "[NOT A VECTOR]"
		end
		return "["..tostring(a.X)..", "..tostring(a.Y).."]"
	end
	--
	v.Magnitude = function ()
		local x = v.X
		local y = v.Y
		return math.sqrt((x^2)+(y^2))
	end
	v.Unit = function ()
		local x = v.X
		local y = v.Y
		local d = math.sqrt((x^2)+(y^2))
		local dir = v / vec2.new(d, d)
		return dir
	end
	function v:lerp(a, frac)
		if getmetatable(a) ~= "Vector2" then
			return vec2.new()
		end
		local frac = frac or 0
		if frac < 0 then
			frac = 0
		elseif frac > 1 then
			frac = 1
		end
		local a = (a - v) * vec2.new(frac, frac)
		return a + v
	end
	function v:toAngle(a)
		if getmetatable(a) ~= "Vector2" then
			return vec2.new()
		end
		return math.atan2(a[2] - v[2], a[1] - v[1])
	end
	v.mt.__add = v.Add
	v.mt.__sub = v.Subtract
	v.mt.__div = v.Divide
	v.mt.__mul = v.Multiply
	v.mt.__tostring = v.Print
	v.mt.__metatable = "Vector2"
	return v
end

function vec2.intersects(a, b, c, d)
	--[[
		a = top left corner of rectangle 1
		b = rectangle 1 size (as Vector2)
		
		c = top left rectangle 1
		d = rectangle 2 size (as Vector2)
	--]]

	local surface = ""
	local collide = false
	local x1 = a[1]
	local y1 = a[2]
	local x2 = c[1]
	local y2 = c[2]
	local w1 = b[1]
	local h1 = b[2]
	local w2 = d[1]
	local h2 = d[2]
	
	if  x1 < x2 + w2 + 1 and	--Right
		x1 + w1 > x2 - 1 and	--Left
		y1 < y2 + h2 + 1 and
		y1 + h1 > y2 - 1
	then
		collide = true
		if y1 + h1 > y2 - 1 and y1 + h1 < y2 then
			surface = "top"
		elseif y1 > y2 + h2 and y1 < y2 + h2 + 1 then
			surface = "bottom"
		end
		if x1 + w1 > x2 - 1 and x1 + w1 < x2 then
			surface = "left"
		elseif x1 > x2 + w2 and x1 < x2 + w2 + 1 then
			surface = "right"
		end
		
		--At this point we need to check if we have mixed surfaces (When this happens, we get stuck on corners)
		if  y1 + h1 > y2 - 1 and y1 + h1 < y2 and
			x1 + w1 > x2 - 1 and x1 + w1 < x2 then
			surface = "topleft"
		elseif  y1 + h1 > y2 - 1 and y1 + h1 < y2 and
				x1 > x2 + w2 and x1 < x2 + w2 + 1 then
			surface = "topright"
		elseif  y1 > y2 + h2 and y1 < y2 + h2 + 1 and
				x1 + w1 > x2 - 1 and x1 + w1 < x2 then
			surface = "bottomleft"	
		elseif  y1 > y2 + h2 and y1 < y2 + h2 + 1 and
				x1 > x2 + w2 and x1 < x2 + w2 + 1 then
			surface = "bottomright"
		end
	end
	
	return collide, surface
end

return vec2
