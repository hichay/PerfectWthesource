fx_version 'cerulean'
game 'gta5'

ui_page 'html/ui.html'

client_scripts {'@es_extended/locale.lua', 'config.lua', 'client/main.lua'}

server_scripts {'@mysql-async/lib/MySQL.lua', '@es_extended/locale.lua', 'config.lua', 'server/main.lua'}

files {'html/vendor/animate/animate.css', 'html/ui.html',
       'html/vendor/jquery/jquery.js', 'html/vendor/jquery-browser-mobile/jquery.browser.mobile.js',
       'html/vendor/popper/umd/popper.min.js', 'html/vendor/bootstrap/js/bootstrap.js', 'html/vendor/common/common.js',
       'html/vendor/nanoscroller/nanoscroller.js', 'html/vendor/magnific-popup/jquery.magnific-popup.js',
       'html/vendor/jquery-placeholder/jquery.placeholder.js', 'html/js/theme.js', 'html/js/custom.js',
       'html/js/theme.init.js', 'html/js/examples/examples.dashboard.js', 'html/vendor/bootstrap/css/bootstrap.css',
       'html/vendor/animate/animate.css', 'html/vendor/font-awesome/css/all.min.css',
       'html/vendor/magnific-popup/magnific-popup.css',
       'html/vendor/bootstrap-datepicker/css/bootstrap-datepicker3.css', 'html/vendor/jquery-ui/jquery-ui.css',
       'html/vendor/jquery-ui/jquery-ui.theme.css', 'html/vendor/bootstrap-multiselect/css/bootstrap-multiselect.css',
       'html/vendor/morris/morris.css', 'html/css/skins/default.css', 'html/css/custom.css', 'html/css/theme.css'}

dependencies {'es_extended'}
