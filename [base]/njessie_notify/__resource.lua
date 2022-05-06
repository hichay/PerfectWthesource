client_script('client/client.lua') --your NUI Lua File

ui_page('html/index.html') --THIS IS IMPORTENT

--[[The following is for the files which are need for you UI (like, pictures, the HTML file, css and so on) ]]--
files({
    'html/index.html',
    
    'html/js/script.js',
    'html/js/toastr.min.js',

    'html/css/toastr.min.css',
    'html/css/style.css',
    'html/css/button.css',
    'html/css/label.min.css',
    'html/css/semantic.min.css'
})