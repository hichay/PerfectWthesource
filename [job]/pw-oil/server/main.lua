ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MAIN = {}
local datajobtable = {}
local dataew = {}

function MAIN:Init()
    local o = {}
    setmetatable(o, {__index = MAIN})
    o.Platforms = {}
    o:InitPlatform()
    o:EventHander()
    return o
end

function MAIN:InitPlatform()
    for k, v in ipairs(Config.Platforms) do 
        self.Platforms[k] = PLATFORM:Init(k, v, nil)
    end
end

function MAIN:EventHander()
    ESX.RegisterServerCallback('pw-oil:callback:getPlatformData', function(source, cb, index)
		
        local rPlayer = ESX.GetPlayerFromId(source)
        self.Platforms[index]:Join(rPlayer)
        return self.Platforms[index]
		
    end)
    RegisterNetEvent('pw-oil:server:Drill', function(index, product)
        if self.Platforms[index]:Drill() then
            local rPlayer = ESX.GetPlayerFromId(source)
            --rPlayer.props.AddInventoryItem(product, 1)
            --TriggerEvent('log:discord', rPlayer, 'addinventoryitem', ('%s %s'):format(product, 1), 'Khoan dầu')
            AddSkillExp(1)
        else
            local rPlayer = ESX.GetPlayerFromId(source)
            rPlayer.props.ShowNotification('Dàn khoan này đã cạn !', 5000)
        end
    end)
    RegisterNetEvent('pw-oil:server:leavePlatform', function(index)
        self.Platforms[index]:Leave(source)
    end)
    --[[ RegisterNetEvent('pw-oil:server:sellResource', function(name, value)
        if value == nil or value < 0 then return end
        local price = GlobalState[name] or 0
        local rPlayer = ESX.GetPlayerFromId(source)
        if rPlayer.props.RemoveInventoryItem(name, value) then 
            rPlayer.props.AddMoney('money', price * value)
            TriggerEvent('log:discord', rPlayer, 'removeinventoryitem', ('%s %s'):format(name, value), 'Bán nguyên liệu thô')
            TriggerEvent('log:discord', rPlayer, 'addmoney', ('%s %s'):format('money', price * value), 'Bán nguyên liệu thô')
        end
    end) ]]
end

Citizen.CreateThread(function()
    while ESX == nil do 
        Wait(100)
    end
    MAIN:Init()
end)
RPC.register('pw-oil:testrpc',function(src)  
    
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM exp_jobs_player WHERE identifier = @identifier AND job = @job',
    {
        ['@identifier'] = xPlayer.identifier,
        ['@job'] = 'oil',
    },
    function(result)
        if not result[1] then
            MySQL.Async.insert('INSERT INTO exp_jobs_player (identifier,exp,job,level,max_exp) VALUES (@identifier,@exp,@job,@level,@max_exp)',
            {
                ['@identifier'] = xPlayer.identifier,
                ['@exp'] = 0,
                ['@level'] = 1,
                ['@max_exp'] = Config.Levels['oil'][1],
                ['@job'] = 'oil',
            })
        elseif result[1] then
            --table.insert(exp = result[1].exp, level = result[1].level, max_exp = result[1].max_exp)
            --table.insert(dataew,{exp = result[1].exp, level = result[1].level, max_exp = result[1].max_exp})
            --TriggerClientEvent('table',-1,datajobtable)
           
            --cb(datajobtable)
            dataew = {exp = result[1].exp, level = result[1].level, max_exp = result[1].max_exp}
        end    
        
                 
    end)
    return dataew
end)
ESX.RegisterServerCallback('pw-oil:getPleyerExpOil', function(source, cb)
--RPC.register('pw-oil:getPleyerExpOil',function(src)    
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM exp_jobs_player WHERE identifier = @identifier AND job = @job',
    {
        ['@identifier'] = xPlayer.identifier,
        ['@job'] = 'oil',
    },
    function(result)
        if not result[1] then
            MySQL.Async.insert('INSERT INTO exp_jobs_player (identifier,exp,job,level,max_exp) VALUES (@identifier,@exp,@job,@level,@max_exp)',
            {
                ['@identifier'] = xPlayer.identifier,
                ['@exp'] = 0,
                ['@level'] = 1,
                ['@max_exp'] = Config.Levels['oil'][1],
                ['@job'] = 'oil',
            })
        elseif result[1] then
            
            datajobtable = {exp = result[1].exp, level = result[1].level, max_exp = result[1].max_exp}
            --TriggerClientEvent('table',-1,datajobtable)
            --return datajobtable
            
            cb(datajobtable)
        end                 
    end)
end)

function AddSkillExp(expnumber)
    local xPlayer = ESX.GetPlayerFromId(source)
    local row = MySQL.single.await('SELECT * FROM exp_jobs_player WHERE identifier = ? AND job = ?', {xPlayer.identifier , 'oil'})
    local newexp = row.exp + expnumber
    if newexp > row.max_exp then
        newlevel = row.level + 1
        MySQL.Async.execute('UPDATE exp_jobs_player SET exp = @exp, level = @level, max_exp = @max_exp WHERE identifier = @identifier AND job = @job', {
            ['@identifier'] = xPlayer.identifier,
            ['@exp']   = 0,
            ['@level']   = newlevel,
            ['@max_exp']   = Config.Levels['oil'][newlevel],
            ['@job'] = 'oil',
        })
    else 
        MySQL.Async.execute('UPDATE exp_jobs_player SET exp = @exp WHERE identifier = @identifier AND job = @job', {
            ['@identifier'] = xPlayer.identifier,
            ['@exp']   = newexp,
            ['@job'] = 'oil',
        })


    end
end