-- by likalium :)

-- == Advent of code 2023: Day 2 ==

local function part1()
	local file = assert(io.open("input", "r"))
	local content = file:read("*l")
	local result = 0 -- Addition of all the correct games IDs
	local finish = false -- Used to know when the line is finished

	while content do
		local total = {red = 0, blue = 0, green = 0} -- Contains the maximum value for each color of cube
		local id = "" -- Will be the id of the current game we're treating
		-- Retrieves the game number
		local _,y = string.find(content, "Game")
		y = y+2
		while string.match(content, ".", y) ~= ":" do
			id = id .. string.match(content, ".", y)
			y = y + 1
		end
		y = y + 2 -- Two characters after the end of the game id + 1, it's the first number
		while not finish do
			local count = "" -- The number of cubes, we don't care the color
			while string.match(content, ".", y) ~= " " do
				-- We use concatenation because we read the file character by character
				count = count .. string.match(content, ".", y)
				y = y + 1
			end
			-- Retrieves the color
			y = y + 1  -- y + 1 is necessarily the index of first letter of the color
			local color = string.match(content, ".", y)
			if color == "g" then
				if tonumber(count) > total.green then total.green = tonumber(count) end
			elseif color == "r" then
				if tonumber(count) > total.red then total.red = tonumber(count) end
			elseif color == "b" then
				if tonumber(count) > total.blue then total.blue = tonumber(count) end
			end
			-- We go to the next space unless there's the end of the line
			while string.match(content, ".", y) ~= " " and string.match(content, ".", y) ~= nil do
				y = y + 1
			end
			y = y + 1
			-- If it's the end of the line then we must stop scanning this line
			if string.match(content, ".", y) == nil then finish = true end
		end
		if not (total.blue > 14 or total.red > 12 or total.green > 13) then result = result + tonumber(id) end
		content = file:read()
		finish = false -- Now that the line has changed, we'll scan it
	end
	print(result)
end

-- Practically the same as part 1 code but nvm
local function part2()
	local file = assert(io.open("input", "r"))
	local content = file:read("*l")
	local result = 0 -- Addition of all the correct games IDs
	local finish = false -- Used to know when the line is finished

	while content do
		local total = {red = 0, blue = 0, green = 0} -- Contains the maximum value for each color of cube
		local id = "" -- Will be the id of the current game we're treating
		-- Retrieves the game number
		local _,y = string.find(content, "Game")
		y = y+2
		while string.match(content, ".", y) ~= ":" do
			id = id .. string.match(content, ".", y)
			y = y + 1
		end
		y = y + 2 -- Two characters after the end of the game id + 1, it's the first number
		while not finish do
			local count = "" -- The number of cubes, we don't care the color
			while string.match(content, ".", y) ~= " " do
				-- We use concatenation because we read the file character by character
				count = count .. string.match(content, ".", y)
				y = y + 1
			end
			-- Retrieves the color
			y = y + 1  -- y + 1 is necessarily the index of first letter of the color
			local color = string.match(content, ".", y)
			if color == "g" then
				if tonumber(count) > total.green then total.green = tonumber(count) end
			elseif color == "r" then
				if tonumber(count) > total.red then total.red = tonumber(count) end
			elseif color == "b" then
				if tonumber(count) > total.blue then total.blue = tonumber(count) end
			end
			-- We go to the next space unless there's the end of the line
			while string.match(content, ".", y) ~= " " and string.match(content, ".", y) ~= nil do
				y = y + 1
			end
			y = y + 1
			-- If it's the end of the line then we must stop scanning this line
			if string.match(content, ".", y) == nil then finish = true end
		end
		result = result + (total.blue * total.green * total.red)
		content = file:read()
		finish = false -- Now that the line has changed, we'll scan it
	end
	print(result)
end

io.write("Execute code for part 1 or part 2? [1/2] ")
local chosen = io.read("*l")
if chosen == "1" then
	part1()
elseif chosen == "2" then
	part2()
end
