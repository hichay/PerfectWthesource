Cfg = {
    Language = "tr",                 -- Options: "tr" or "en"
    identifierType = "identifier",    -- Options: "identifier" or "citizenid" if u are using qbcore set citizenid
    gardrobe = "esx",                 -- "qb", "esx"
    generalPurchasable = true,       -- 
    stash = "pw",                    -- "disc", "qb", "linden"
    gcphone = false,                  -- readme.md 
    doorSound = true,                -- Door lock Sound
    QBCore = false,
    CustomHelpNotify = true,         -- if false will be DrawText3D
    metasystem = true,              -- Key System [Req linden_inventory]  if u are using qbcore dont set true.
    metaitem = "motelkey",           -- if the metasystem is opened. write the metaitem name.
    charinfosystem = false,           -- if u using the charinfo set true. [Req mx-base] if u are using qbcore not set true
    SqlType = "mysql",        -- Options: "mysql" or "ghmattimysql"
    autosave = true,                 -- if write the false will be player Saves when the player dropped.
    autosaveTime = 10 * 60000,       -- 1 min = 60000 10 * 60000
    saveCommand = "motel-save",      -- Save command. if u write false or nil will be removed command. [only writing to cmd]
    bill = {
        active = false,
        pos = vec3(-545.17, -203.66, 38.22),
        blip = {                     -- https://docs.fivem.net/docs/game-references/blips/
            active = false,           -- Active ?
            name = "Bill Payment Center",  -- Blip name
            scale = 0.6,                    -- Blip size
            color = 1,                      -- Blip color
            sprite = 476,                   -- Blip type
        },
    },
    receptionMethods = {
        kick = true,                 -- Motel owner remove the player room.
        changeRoom = true,           -- Motel owner change the player room.
        timeRefresh = true,          -- Motel owner refresh the player time.
        sendMessage = true,          -- Motel owner Send the player message.
        createNewKey = true,         -- Motel owner create the player room key. [Req linden_inventory]
        givePermission = true,       -- 
        giveReward = true,
        setUpdateSalary = true,      --
        updateSuspened = true,      
    },
    notify = { --readme.md
        event = 'ESX:Notify',                            -- ur notification event
        arg = '',             -- argument or false [examples: readme.md]
        arg2 = "info"
    },
    inventorySettings = {    -- readme.md 
        id = 'stash',
        slots = 80,
        owner = '',
    },
    marker = {                      -- https://docs.fivem.net/docs/game-references/markers/         
        type = 27,                         
        doors = false,               -- marker active
        stashes = true,             -- marker active
        gardrobes = true            -- marker active
    },
    Employee = {                     
      active = true,                 -- if u write to true will be motel owner can take a employeers
      autosalary = 20 * 60000,       -- if u write to false will be closed. [DEFAULT - 20 * 60000]
      reqingame = true,              -- if u set true motel employees can only get salaries while in game
      salaryMethod = 'cash',         -- 'bank' 'cash'   
    },
    society = {
        active = true,               -- If true, the motel owner can put or receive money in the motel storage
        takeRent = true,             -- If true, the money is deposited into the motel storage when the person pays the rent for the motel room.
        takeSalary = true,           -- If true, the employees' salary is paid through the motel storage.
        obligatorySalary = true,     -- If true, it allows the money in the motel storage to go to negative. If false, if the money is insufficient, there is no salary payment.
    },
    AdminOptions = {
        privateAdmin = false,         -- If it is open, you need to set yourself who can employ the motel manager, if it is closed, all admins can use it directly.
        privateAdmins = {             -- Citizenid or identifier whichever add
            "DVQ06744"
        },
        privatePermission = true,     -- If private admin is open, close it. Permissions to use.
        privatePermissions = {
            'admin',
            'superadmin',
            'god'
        },
        setMotelOwnerCommand = "setmotelowner",        -- If you set false, the command will be canceled. If you enter string it will be the command String = ""
    },
    LogSystem = "standart",          -- Options "standart" and "custom". Custom required mx-logsystem
    LogWebHooks = {
        ["Create Bill"] = "",
        ["Pay Bill"] = "",
        ["Accept Request"] = "",
        ["Reject Request"] = "",
        ["Left Motel"] = "",
        ["Pay Rent"] = "",
        ["Set Employee Salary"] = "",
        ["Give Employee Reward"] = "",
        ["Kick Employee"] = "",
        ["Create New Key"] = "",
        ["Update Permission"] = "",
        ["Take Employee"] = "",
        ["Refresh Rent Motel"] = "",
        ["Delete Motel"] = "",
        ["Deposit Money"] = "",
        ["Withdraw Money"] = "",
        ["SetMotelOwner"] = "",
        ["Change Room"] = "",
        ["Reset Rent"] = "",
        ["BuyMotel"] = "", 
    },
}

--  DON'T TOUCH IT.
_U = Langs[Cfg.Language]
