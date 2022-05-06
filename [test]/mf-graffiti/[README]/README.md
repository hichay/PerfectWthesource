# Installation
Extract mf-graffiti folder into your resources directory.
Open the credentials.lua file inside of the mf-graffiti folder and read the instructions provided.
Ensure all dependencies are installed prior to server launch.
Check config.lua for options that you might want to change.

# Dependencies
meta_libs
es_extended
input (NOTE: Requires updated version provided. Do NOT use old versions included with allhousing etc).

# Usage
Check server.lua for pre-defined items.
Use 'bironlack_spray_paint' or 'general_spray_paint' from your inventory to begin spray painting.
Use the 'sponge' item from your inventory to clean off spray paint.

# Adding Pre-defined Artwork
In config.lua, add to the TextureUrls table, e.g:
  TextureUrls = {
    -- define all images that can be painted here.
    {
      label   = "My Artwork",                                     -- for esx menu
      url     = "https://your_image_upload_here.png",             -- ... obvious
      width   = 400,                                              -- ^
      height  = 185,                                              -- ^
      tag     = false                                             -- if tag = true, painting this artwork will take half as long as usual.
    }
  }
---------------------------------------------------------------
---Star Leaks https://discord.gg/xTHKYXN-----------------------
--------------------EXTRA WORLD SUCKS--------------------------

