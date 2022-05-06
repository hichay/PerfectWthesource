ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local instructorActions = {}

function bool_to_number(value)
  return value and 1 or 0
end

function GetCharacter(id)
    local xPlayer = ESX.GetPlayerFromId(id)

	local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})

    return result[1]
end

RegisterServerEvent('driving:submitTest')
AddEventHandler('driving:submitTest', function(data)
  -- Submit 

  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  local Player = ESX.GetPlayerFromId(data.cid)

  if not xPlayer then
    TriggerClientEvent("DoShortHudText",src,"Failed to get results, please Try again in a minute...",2)
    return
  end
  local userjob = xPlayer.job.name

  if userjob == "taxi" then
    return
  end

  local instructorChar = GetCharacter(source)
  local Drivername = GetCharacter(data.cid)
  local DrivernameLic = Drivername.firstname .. " " .. Drivername.lastname
  local instructorName = ''
  if (data and (data.instructor == nil and data.instructor == '')) then
    instructorName = data.instructor
  else
    instructorName = instructorChar.firstname .. " " .. instructorChar.lastname
  end

  local drivingTest = {
    cid = tostring(DrivernameLic),
    icid = tostring(instructorChar.identifier),
    instructor = tostring(instructorName),
    timestamp = os.time(),
    points = tonumber(data.points),
    passed = bool_to_number(data.passed),
    results = json.encode(data.results),
  }
 

  exports.ghmattimysql:execute("INSERT INTO driving_tests (cid, icid, instructor, timestamp, points, passed, results) VALUES (@cid, @icid, @instructor, @timestamp, @points, @passed, @results);",
  {['cid'] = drivingTest.cid, ['icid'] = drivingTest.icid, ['instructor'] = drivingTest.instructor, ['timestamp'] = drivingTest.timestamp, ['points'] = drivingTest.points, ['points'] = drivingTest.points, ['passed'] = drivingTest.passed, ['results'] = drivingTest.results}, function(rowsChanged)
  
    if (rowsChanged and rowsChanged ~= 0) then
      exports.ghmattimysql:execute("SELECT id FROM driving_tests WHERE cid = @cid AND icid = @icid AND timestamp = @timestamp",
      {["cid"] = drivingTest.cid, ["icid"] = drivingTest.icid, ['timestamp'] = drivingTest.timestamp}, function(response)
		
        if response[1] ~= nil then
			information = {
				["ID"] = tonumber(response[1].id),
				["Họ tên"] = drivingTest.cid,
				["Giám sát"] = drivingTest.instructor,
				["Thời gian"] = os.date('(%d)-(%m)-(%Y)', drivingTest.timestamp),
				
			}	
		  -- TriggerClientEvent("player:recieveItem",source,"drivingtest", 1, true, true,{
            -- idcard = tonumber(response[1].id),
            -- cid = drivingTest.cid,
            -- instructor = drivingTest.instructor,
            -- datetime = os.date('%Y %m %d', drivingTest.timestamp),
          -- })
		  TriggerClientEvent("player:receiveItem", -1,"drivingtest",1,true,true,information)
          TriggerClientEvent("DoShortHudText",src,"You recieved a copy of the driving test.",101)
        else
          TriggerClientEvent("DoShortHudText",src,"Failed to submit the test! Please try again.",2)
        end
      end)
    else
      TriggerClientEvent("DoShortHudText",src,"Failed to submit the test! Please try again.",101)
    end
  end)
end)

RegisterServerEvent('driving:getHistory')
AddEventHandler('driving:getHistory', function(source, cid)

  
  local src = source
  
  local xPlayer = ESX.GetPlayerFromId(src)
  if not xPlayer then
    TriggerClientEvent("DoShortHudText",src,"Failed to get results, please Try again in a minute...",1)
    return
  end
  local userjob = xPlayer.job.name

  if (userjob ~= "driving instructor" and userjob ~= "police" and userjob ~= "judge") then
    return
  end

  if cid == nil then
    TriggerClientEvent("DoShortHudText",src,"Enter a persons CID to retrieve a list of past driving tests.",2)
    return
  end

  exports.ghmattimysql:execute("SELECT * FROM driving_tests WHERE cid = @cid ORDER BY id DESC LIMIT 5", {['cid'] = tonumber(cid)}, function(response)
    if (#response <= 0) then
      TriggerClientEvent("DoShortHudText", src, "No tests found under that ID",101)
    else
      local drivingTests = ""
      for i = 1,#response do
        local test = response[i]
        if (test and test.id) then
          drivingTests = drivingTests .. "\n Test ID: " .. tonumber(test.id) .." | Instructor: " .. tostring(test.instructor)
        end
      end

      TriggerClientEvent('outlawNotifyDrivingTests', -1, src, drivingTests)
      if (drivingTests == "") then
        TriggerClientEvent("chatMessage",src,"[Driving History for #cref661241-" .. cid .. "]",5, "\n - No tests found -")
      else
        TriggerClientEvent("chatMessage",src,"[Driving History for #cref661241-" .. cid .. "]",5, drivingTests)
      end
    end
  end)
end)

RegisterServerEvent('driving:getReport')
AddEventHandler('driving:getReport', function(source, tID)

  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  if not xPlayer then
    TriggerClientEvent("DoShortHudText",src,"Failed to get results, please Try again in a minute...",1)
    return
  end
  local userjob = xPlayer.job.name or "Unemployed"

  if (userjob ~= "driving instructor" and userjob ~= "police" and userjob ~= "judge") then
    return
  end

  local testID = tonumber(tID)
  if testID == nil or not is_int(testID) then
    TriggerClientEvent("DoShortHudText",src,"Enter a driving test ID number to retr'eve the report for.",2)
    return
  end

  exports.ghmattimysql:execute("SELECT * FROM driving_tests WHERE id = @testID", {['testID'] = tonumber(testID)}, function(response)
    if response[1] == nil then
      TriggerClientEvent("DoShortHudText", src, "No test was found with the ID:" ..tID,2)
    else
      TriggerClientEvent("player:recieveItem",src,"drivingtest", 1, true, {
        id = tonumber(response[1].id),
        cid = drivingTest.cid,
        instructor = drivingTest.instructor,
        date = os.date('%Y %m %d', drivingTest.timestamp),
      })
      TriggerClientEvent("DoShortHudText",src,"You recieved a copy of the driving test.",101)
    end
  end)
end)

RegisterServerEvent('driving:getResults')
AddEventHandler('driving:getResults', function(tID)


  local src = source
  local testID = tonumber(tID)
  local pass
  if testID == nil then
    TriggerClientEvent("DoShortHudText",src,"Failed to get driving test results",2)
    return
  end
  
  exports.ghmattimysql:execute("SELECT * FROM driving_tests WHERE id = @testID", {['testID'] = tonumber(testID)}, function(response)
    if response[1] == nil then
      TriggerClientEvent("DoShortHudText", src, "No test was found with the ID:" ..tID,2)
    else
	print(response[1].points)
	  print(response[1].passed)
	  if response[1].passed == '1' then 
		pass = "Đậu"
	  else
		pass = "Trượt"
	  end
	  TriggerClientEvent("chatMessage",src,"[Thông tin giấy phép #cref661241- Số " .. response[1].id .. "]",5, "\n - Kết quả-  "..pass.."")
      -- TriggerClientEvent("player:recieveItem",src,"drivingtest", 1, true,true, {
        -- ["id"] = tonumber(response[1].id),
        -- ["cid"] = response[1].cid,
        -- ["instructor"] = response[1].instructor,
        -- ["date"] = os.date('%Y %m %d', response[1].timestamp),
      -- })
	  
    end
  end)
end)

RegisterServerEvent('driving:vehicleAction')
AddEventHandler('driving:vehicleAction', function(dID, action)


  local src = source
  local driverId = tonumber(dID)

	local xPlayer = ESX.GetPlayerFromId(src)
  if not xPlayer then
    return
  end
  local userjob = xPlayer.job.name or "Unemployed"

  if (userjob ~= "driving instructor" and userjob ~= "police" and userjob ~= "judge") then
    return
  end


  -- Send action to driver
  instructorActions[src] = driverID
  TriggerClientEvent('drivingInstructor:vehicleAction', driverID, action)
end)

AddEventHandler("playerDropped", function()
  -- Prevent the chance of a driver getting stick in an action byu an instructor who disconnected

  local src = source

  local xPlayer = ESX.GetPlayerFromId(src)
  if not xPlayer then
    return
  end
  local userjob = xPlayer.job.name or "Unemployed"

  if (userjob == "police") then
    local lastActionID = instructorActions[src]
    if lastActionID and lastActionID > 0 then
      TriggerClientEvent('drivingInstructor:vehicleAction', lastActionID, 5)
      instructorActions[src] = nil
    end
  end
end)

-- AddEventHandler("np-base:characterLoaded", function(user, char)
  -- local src = source
  -- local hexId = user:getVar("hexId")
  -- local cid = user:getVar("character").id

  -- -- Check for driving inscturctor whitelist onLoad as we have no sign in location for it.
  -- checkForWhiteList(hexId, cid, "driving inscturctor", function(whiteListed)
    -- if whiteListed then
      -- local jobs = exports["np-base"]:getModule("JobManager")
      -- jobs:SetJob(user, "driving instructor", false)
    -- end
  -- end)
-- end)

RegisterServerEvent('driving:toggleInstructorMode')
AddEventHandler('driving:toggleInstructorMode', function(boolean)
  shit = not shit
  -- done. ((sway))
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  local name = GetCharacter(source)

  TriggerClientEvent('drivingInstructor:instructorToggle', src, shit, tostring(name.firstname))
end)

function checkForWhiteList(hexId, characterId, job, callback)
  if not hexId or not characterId then return end
  
  local q = [[SELECT id, owner, cid, job, rank FROM jobs_whitelist WHERE cid = @cid;]]
  local v = {['owner'] = hexId, ['cid'] = characterId}

  exports.ghmattimysql:execute(q,v, function(results)
      if not results then callback(false,false,false) return end
      local whitelist = false
      
      for k,v in pairs(results) do
          if v.job == "driving instructor" and v.rank >= 1 then police = true end
      end

      callback(whitelist)
  end)
end