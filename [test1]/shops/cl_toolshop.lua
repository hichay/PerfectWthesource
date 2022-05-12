
toolshop = {

	{44.83, -1748.53, 29.54},
	{2749.23, 3472.33, 55.67}

}
Citizen.CreateThread(function()
	exports["pw-polyzone"]:AddBoxZone("tool_shop", vector3(44.83, -1748.53, 29.54), 1.8, 2.4, {
		  heading=315,
		  minZ=28.40,
		  maxZ=30.50,
	})
  
	exports["pw-polyzone"]:AddBoxZone("tool_shop", vector3(2749.23, 3472.33, 55.67), 5.2, 4.4, {
		heading=8,
		minZ=55.20,
		maxZ=56.0
	})
	  
	  
end)
  