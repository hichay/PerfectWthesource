Yo, thanks for buy my motel script.

You need to know about mx-motels :[

    // Supported list;

    - Mysql : ghmattimysql - mysql-async 

    - Languages : Turkish - English

    - Inventory : qb-inventory - disc-inventoryhud, linden_inventory
    
    * if you want to add extra language => "langs" folder

    * To edit motels or add extra motels => server => "BuildData.lua"

    * Total motel rooms : 127

    * Total motel : 8

    * You can add motel owner and employees

    ** Motels are run by players, not automatic.

    // Things to do;
  
    * If you are using esx_skin, add "dressing" and "property" columns to the datastore table in the database. and restart server
    
    * Standard logsystem has less detail. We recommend using mx-logsystem for more details.

    * Stash options

    if u are using disc-inventoryhud go to disc-inventoryhud > server > stash.lua add

    Citizen.CreateThread(function()
    TriggerEvent('disc-inventoryhud:RegisterInventory', {
        name = 'motel',
        label = 'Stash',
        slots = 500,
        maxweight = Config.StashMaxWeight
    })
  end)

  fast inventory options 

  qb: [
      inventorySettings = {             
        maxweight = 4000000,                            
        slots = 500,
    },
  ]

  disc: [
    inventorySettings = {     
        type = 'motel',                        
        owner = '',
        slots = 80,
        weight = 50
    }
  ]

  linden: [
    inventorySettings = {     
        id = 'stash',
        slots = 80,
        owner = '',
    },
  ]

    * Notify Events lists [
        mythic {
          event = 'mythic_notify:client:SendAlert',               
          arg = {type = 'inform', text = '%s', length = 2500},   
          arg2 = 2
        }       
        
        np {
          event = 'notification',
          arg = %s,   
          arg2 = 2
        }

        Default {
          event = 'mx-motels:Notification',                      
          arg = {text = '%s', ms = 6000},             
          arg2 = 2
        }
    ]

    * If you are using gcphone apply the steps: 

    go to esx_addons_gcphone > server.lua

    and add

```
    RegisterServerEvent('esx_addons_gcphone:motelSendMessage')
    AddEventHandler('esx_addons_gcphone:motelSendMessage', function(source, number, msg, coords)
      local src = source
      getPhoneNumber(src, function (phone) 
        notifyAlertMotel(number, src, {
          message = msg,
          coords = coords,
          numero = phone,
        })
      end)
    end)

    function notifyAlertMotel(number, player, alert) 
      local mess = '#' .. alert.numero  .. ' : ' .. alert.message
      if alert.coords ~= nil then
          mess = mess .. ' ' .. alert.coords.x .. ', ' .. alert.coords.y 
      end
      getPhoneNumber(player, function (n)
          if n ~= nil then
            TriggerEvent('gcPhone:_internalAddMessage', number, n, mess, 0, function (smsMess)
              TriggerClientEvent("gcPhone:receiveMessage", player, smsMess)
            end)
          end
      end)
    end
```


    * If you are using linden_inventory and metasystem, apply the steps:
    
    Add this to ur linden_inventory/shared/items.lua

    ```lua
        ['motelkey'] = {
    		  label = 'Motel Key',
    		  weight = 0.250,
    		  stack = true,
    		  close = true,
    		  client = {
    		  	usetime = 0,
    		  	event = 'mx-motels:UseKey'
    		  }
    	},
    ```

    * If you are using qb-core, apply the steps:

    motelkey ​​add your item list

  Example:
  	["motelkey"] 					 = {["name"] = "motelkey", 			 	  	  	["label"] = "Motel Key", 					["weight"] = 0, 		["type"] = "item", 		["image"] = "motelkey.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["description"] = "Motel Key."},
    
    go to qb-inventory > html > js > app.js

    and add 

    else if (itemData.name == 'motelkey') {
            $(".item-info-title").html('<p>'+itemData.label+'</p>');
            $(".item-info-description").html('<p>Motel Key: ' + itemData.info.worth + '</p>');

  
  To buy mx-logsystem
    https://moxha.tebex.io
]