Config        = {}
Config.Locale = 'en'

Config.EnableESXIdentity = true -- only turn this on if you are using esx_identity and want to use RP names
Config.OnlyFirstname     = false
Config.Job = {
    police = {
        label = "^4Cảnh Sát | ^2",
        template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(64, 101, 243, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>'
    },
    ambulance = {
        label = "^1Bác sĩ | ^2",
        template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(255, 5, 171, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>'
    },
    mechanic = {
        label = "^3Cứu Hộ | ^2",
        template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(255, 255, 255, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>'
    },
    army = {
        label = "^2Quân Đội | ^2",
        template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(255, 255, 255, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>'
    },
    admin = {
        label = "ADMIN | ",
        template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(243, 64, 64, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>'
    },
    --------------------------------------------------
    
    DD = {
        label = "^4Devil Ducks | ",
        template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(243, 64, 64, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>'
    },
}