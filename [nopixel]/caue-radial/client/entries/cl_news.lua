local NewsEntries, SubMenu = MenuEntries["news"], {}

local News = {
    {
        id = "newsMicrophoneBoom",
        title = "Microfone",
        icon = "#news-job-news-microphone",
        event = "camera:setMic"
    },
    {
        id = "newsCamera",
        title = "Camera",
        icon = "#news-job-news-camera",
        event = "camera:setCamera"
    },
    {
        id = "newsMicrophone",
        title = "Microphone Boom",
        icon = "#news-job-news-boom",
        event = "camera:setBoom"
    },
}

Citizen.CreateThread(function()
    for index, data in ipairs(News) do
        SubMenu[index] = data.id
        MenuItems[data.id] = {data = data}
    end

    NewsEntries[#NewsEntries+1] = {
        data = {
          id = "news",
          icon = "#news",
          title = "News",
        },
        subMenus = SubMenu,
        isEnabled = function ()
            return not exports["esx_ambulancejob"]:GetPlayerDead() and CurrentJob == "news"
        end,
    }
end)

