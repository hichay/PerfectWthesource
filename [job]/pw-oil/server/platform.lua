PLATFORM = {}

function PLATFORM:Init(index, data, owner)
    local o = data
    setmetatable(o, {__index = PLATFORM})
    o.Quantity = Config.DefaultQuantity
    o.Workers = {}
    o.Owner = owner
    o.index = index
    return o
end

function PLATFORM:Join(player)
    table.insert(self.Workers, {source = player.source, id = player.id, name = player.name})
    self:Sync()
end

function PLATFORM:Leave(playerId)
    for k , v in ipairs(self.Workers) do 
        if v.source == playerId then 
            table.remove(self.Workers, k)
            self:Sync()
            break
        end
    end
end

function PLATFORM:Drill()
    if self.Quantity > 0 then 
        self.Quantity = self.Quantity - 1
        self:Sync()
        return true
    else
        return false
    end
end

function PLATFORM:Sync()
    for k, v in pairs(self.Workers) do 
        TriggerClientEvent('lr_oil:client:syncPlatform', v.source, self)
    end
end