-- by likalium :)

-- == Advent of code 2023: Day 1 ==

local function part1()
	local total = 0 -- Will contain the total of all numbers (the thing we want to find, in other words)
	local file = assert(io.open("input", "r"))
	local content = file:read("*l") -- We read the file line by line

	while content do -- While there's a line, do:
		local nums = {} -- Will contain all numbers found on the line
		local tablelen = 0 -- Will contain the length of the table "nums"

		for i in content:gmatch"." do
			if pcall(function() if not tonumber(i) then error() end end) then
				table.insert(nums, i) -- If the character is a number, then we include it
			end
		end
		for _ in pairs(nums) do tablelen = tablelen + 1 end -- We calculate the length of the table
		total = total + tonumber(nums[1] .. nums[tablelen]) -- Concatenation of the first and the last value of "nums" is added to the total
		content = file:read("*l")
	end
	print(total)
	file:close()
end

local function part2()
	local file = assert(io.open("input", "r"))
	local content = file:read("*l")
		local total = 0
	local textDigits = { one = "1", two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9"} -- We'll also work with textual digits, so we link numerical and textual values

	while content do
		-- We store the start index of the last occurence of every possible textual or numerical number
		local lastOccurence = {text = {}, nums = {}}
		for i,j in pairs(textDigits) do
			lastOccurence.text[i] = 1
			lastOccurence.nums[j] = 1
		end
		local nums = {}
		local tablelen = 0
		local txt = ""

		for i in content:gmatch"." do
			txt = txt .. i
			for j in pairs(textDigits) do
				-- We start the search only after the start index of the last occurence of what we search for
				if string.find(txt, j, lastOccurence.text[j]) then
					local x = string.find(txt, j, lastOccurence.text[j])
					table.insert(nums, textDigits[j])
					-- The stored value is the start index of the last occurent PLUS one, to start search just after start of the last occurence
					lastOccurence.text[j] = x + 1
				end
				if string.find(txt, textDigits[j], lastOccurence.nums[textDigits[j]]) then
					local x = string.find(txt, textDigits[j], lastOccurence.nums[textDigits[j]])
					table.insert(nums, textDigits[j])
					lastOccurence.nums[textDigits[j]] = x + 1
				end
			end
		end
		for _ in pairs(nums) do tablelen = tablelen + 1 end
		total = total + tonumber(nums[1] .. nums[tablelen])
		content = file:read("*l")
	end
	print(total)
	file:close()
end

io.write("Execute code for part 1 or part 2? [1/2] ")
local chosen = io.read("*l")
if chosen == "1" then
	part1()
elseif chosen == "2" then
	part2()
end
