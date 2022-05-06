---------------------------------------------------------------
---Star Leaks https://discord.gg/xTHKYXN-----------------------
--------------------EXTRA WORLD SUCKS--------------------------

if ESX and type(ESX) == "table" and ESX.RegisterUsableItem then
  ESX.RegisterUsableItem("bironlack_spray_paint",function(source)
    local modifier = 2 -- divider overall paint time by this number. higher = better "paint"... or however you put it.
    TriggerClientEvent("Graffiti:Draw",source,{
      width   = 800,
      height  = 400,
      txd     = Graffiti.NewUid(),
      tx      = Graffiti.NewUid(),
      url     = "https://i.ibb.co/BN4Gs0k/Png-Item-625994.png"
    },modifier)
  end)

  ESX.RegisterUsableItem("general_spray_paint",function(source)
    local modifier = 1
    TriggerClientEvent("Graffiti:Draw",source,{
      width   = 800,
      height  = 400,
      txd     = Graffiti.NewUid(),
      tx      = Graffiti.NewUid(),
      url     = "https://i.ibb.co/BN4Gs0k/Png-Item-625994.png"
    },modifier)
  end)

  ESX.RegisterUsableItem("sponge",function(source)
    TriggerClientEvent("Graffiti:Clean",source)
  end)
end

Graffiti      = {}
Graffiti.Art  = {}
Graffiti.Uids = {}

Graffiti.NewUid = function()
  for i=1,100000,1 do
    if not Graffiti.Uids[i] then
      Graffiti.Uids[i] = true
      return "random_"..i
    end
  end
end

Graffiti.Login = function()
  TriggerClientEvent("Graffiti:Start",source,Graffiti.Art)
end

Graffiti.Created = function(art)
  art.txd = art.txd .. "_real"
  art.tx  = art.tx  .. "_real"
  table.insert(Graffiti.Art,art)
  TriggerClientEvent("Graffiti:Register",-1,art)
end

Graffiti.Remove = function(art)  
  for k,v in ipairs(Graffiti.Art) do
    if v.txd == art.txd then
      table.remove(Graffiti.Art,k)
      break
    end
  end
  TriggerClientEvent("Graffiti:Removed",-1,art)
end

Graffiti.Overwrite = function(artwork,closest)
  Graffiti.Remove(closest)
  artwork.txd = Graffiti.NewUid()
  artwork.tx  = Graffiti.NewUid()
  Wait(500)
  Graffiti.Created(artwork)
end

---------------------------------------------------------------
---Star Leaks https://discord.gg/xTHKYXN-----------------------
--------------------EXTRA WORLD SUCKS--------------------------
---------------------------------------------------------------
---Star Leaks https://discord.gg/xTHKYXN-----------------------
--------------------EXTRA WORLD SUCKS--------------------------
---------------------------------------------------------------
---Star Leaks https://discord.gg/xTHKYXN-----------------------
--------------------EXTRA WORLD SUCKS--------------------------
