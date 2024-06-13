-- Sample Lua tensor file created manually with math

-- Define the dimensions of the tensor
local rows = 2
local cols = 3

-- Create an empty table to hold the tensor elements
local tensor = {}

-- Populate the tensor with values
for i = 1, rows do
	tensor[i] = {} -- Initialize a new row
	for j = 1, cols do
		-- Calculate the value based on the row and column indices
		tensor[i][j] = i * j
	end
end

-- Print the tensor
for i = 1, rows do
	for j = 1, cols do
		io.write(tensor[i][j] .. " ")
	end
	io.write("\n")
end
