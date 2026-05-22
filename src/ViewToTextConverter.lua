local CharacterFolder = workspace.CharactersFolder 

local ViewToTextConverter = {}

local viewAngle = 90

local maximumViewDistance = 100

local rayCount = 12

local topNumberOfViews = 5

local initialViewText = "---<Currently Viewing>---"

local finalViewText = "---<End of Viewing>---"

local materialEnum = Enum.Material

local oneStudToMeters = 0.28

local objectViewPriorityDictionary = { -- The lower the number, the higher the priority.
	
	["Door"] = 2,
	
	["Window"] = 3,
	
	["Stair"] = 4,
	
	["Wall"] = 10,
	
	["Floor"] = 11,
	
	["Ceiling"] = 12,

}

local function getPartDescription(part, alternativePartName, isCharacter)
	
	local colorName = part.BrickColor.Name
	
	local isPartTransparent = (part.Transparency > 0.5)
	
	local partMaterialName = part.Material.Name
	
	local transparentText = (isPartTransparent) and "Transparent " or ""
	
	local partName = alternativePartName or part.Name
	
	local partDescription = transparentText .. colorName .. " "
	
	if (not isCharacter) then partDescription = partDescription .. partMaterialName .. " " end
	
	partDescription = partDescription .. partName
	
	return partDescription
	
end

local function generateRandomViewAngle(viewAngle)
	
	return (math.random() - 0.5) * (viewAngle * math.pi / 180)
	
end

local function removeDuplicatedView(textArray, priorityArray, distanceArray)
	
	local nonDuplicatedTextArray = {}
	
	local nonDuplicatedPriorityArray = {}
	
	local nonDuplicatedDistanceArray = {}
	
	for i, text in pairs(textArray) do
		
		if (table.find(nonDuplicatedTextArray, text)) then continue end
		
		table.insert(nonDuplicatedTextArray, text)
		
		table.insert(nonDuplicatedPriorityArray, priorityArray[i])
		
		table.insert(nonDuplicatedDistanceArray, distanceArray[i])
		
	end
	
	return nonDuplicatedTextArray, nonDuplicatedPriorityArray, nonDuplicatedDistanceArray
	
end

local function sortViewsByPriorityAndDistance(textArray, priorityArray, distanceArray)

	-- Create a list of indices [1, 2, 3, ... n].
	
	local indices = {}
	
	for i = 1, #textArray do
		
		table.insert(indices, i)
		
	end

	-- Sort the indices based on the values in the priority and distance arrays.
	
	table.sort(indices, function(a, b)
		
		local priorityA = priorityArray[a]
		
		local priorityB = priorityArray[b]

		-- Primary Sort: Priority (Lower number = Higher Priority).
		
		if (priorityA ~= priorityB) then return priorityA < priorityB end

		-- Secondary Sort: Distance (Closer = Higher Priority).
		
		return (distanceArray[a] < distanceArray[b])
		
	end)

	-- Rebuild the arrays in the sorted order.
	
	local sortedTextArray = {}
	
	local sortedPriorityArray = {}
	
	local sortedDistanceArray = {}

	for i = 1, #indices do
		
		local originalIndex = indices[i]
		
		table.insert(sortedTextArray, textArray[originalIndex])
		
		table.insert(sortedPriorityArray, priorityArray[originalIndex])
		
		table.insert(sortedDistanceArray, distanceArray[originalIndex])
		
	end

	return sortedTextArray, sortedPriorityArray, sortedDistanceArray
end

local function createViewText(textArray, distanceArray)
	
	local viewText = ""
	
	for i, text in pairs(textArray) do
		
		viewText = viewText .. text .. ": " .. string.format("%.2f", distanceArray[i] * oneStudToMeters) .. "m\n"
		
	end
	
	return viewText
	
end

function ViewToTextConverter:view(viewingCharacter)
	
	local head = viewingCharacter.Head
	
	if (not head) then return "" end
	
	local headPosition = head.Position
	
	local headCFrame = head.CFrame
	
	local lookVector = headCFrame.LookVector
	
	local rightVector = headCFrame.RightVector
	
	local upVector = headCFrame.UpVector

	local viewText = initialViewText .. "\n"
	
	local textArray = {}
	
	local priorityArray = {}
	
	local distanceArray = {}
	
	local raycastParams = RaycastParams.new()
	
	raycastParams.FilterDescendantsInstances = {viewingCharacter}

	-- Cast rays in a cone.
	
	for i = 1, rayCount, 1 do
		
		-- Distribute rays in a cone pattern.
		
		local angleU = generateRandomViewAngle(viewAngle)
		
		local angleV = generateRandomViewAngle(viewAngle)

		local spreadDirection = (lookVector * math.cos(angleU) * math.cos(angleV)) +
			(rightVector * math.sin(angleU) * math.cos(angleV)) +
			(upVector * math.sin(angleV))

		local result = workspace:Raycast(head.Position, spreadDirection * maximumViewDistance, raycastParams)

		if (result) then
			
			local distance = (result.Position - headPosition).Magnitude
			
			local part = result.Instance
			
			local parentPart = part.Parent
			
			local selectedObjectPriority
			
			local subText
			
			if (parentPart == CharacterFolder) then
				
				selectedObjectPriority = 1
				
				subText = getPartDescription(part, nil, true)
				
				local playerHead = viewingCharacter:FindFirstChild("Head")
				local lookVector = playerHead and playerHead.CFrame.LookVector or Vector3.new(0,0,1)
				local directionToKaela = (headPosition - result.Position).Unit
				local dotProduct = lookVector:Dot(directionToKaela)

				local facingStatus = ""
				if (dotProduct > 0.5) then facingStatus = " (Facing Me)"
				elseif (dotProduct < -0.5) then facingStatus = " (Facing Away)"
				else facingStatus = " (Facing Sideways)"
				end
				
				subText = subText .. facingStatus
				
			else
				
				local partName = part.Name
				
				local parentPartName = parentPart.Name
				
				local selectedObjectPriority = math.huge
				
				for objectName, objectPriority in pairs(objectViewPriorityDictionary) do
					
					if (not parentPartName:match(objectName)) or (not partName:match(objectName)) then continue end
					
					selectedObjectPriority = objectPriority
					
					subText = getPartDescription(part, objectName)
					
					break
					
				end
				
			end
			
			table.insert(priorityArray, selectedObjectPriority)
			
			table.insert(textArray, subText)
			
			table.insert(distanceArray, distance)
			
		end
		
	end
	
	textArray, priorityArray, distanceArray = removeDuplicatedView(textArray, priorityArray, distanceArray)
	
	textArray, priorityArray, distanceArray = sortViewsByPriorityAndDistance(textArray, priorityArray, distanceArray)
	
	local topNTextArray = {}
	
	local topNDistanceArray = {}
	
	for i = 1, topNumberOfViews, 1 do
		
		table.insert(topNTextArray, textArray[i])
		
		table.insert(topNDistanceArray, distanceArray[i])
		
	end
	
	local middleViewText = createViewText(topNTextArray, topNDistanceArray)

	viewText = middleViewText .. finalViewText
	
	return viewText
	
end

return ViewToTextConverter
