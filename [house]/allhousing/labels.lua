local labels = {
  ['en'] = {
    ['Entry']       = "Entry",
    ['Exit']        = "Exit",
    ['Garage']      = "Garage",
    ['Wardrobe']    = "Wardrobe",
    ['Inventory']   = "Inventory",
    ['InventoryLocation']   = "Inventory",

    ['LeavingHouse']      = "Rời nhà",

    ['AccessHouseMenu']   = "Access the house menu",

    ['InteractDrawText']  = "["..Config.TextColors[Config.MarkerSelection].."E~s~] ",
    ['InteractHelpText']  = "~INPUT_PICKUP~ ",

    ['AcceptDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."G~s~] ",
    ['AcceptHelpText']    = "~INPUT_DETONATE~ ",

    ['FurniDrawText']     = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",
    ['CancelDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",

    ['VehicleStored']     = "Vehicle stored",
    ['CantStoreVehicle']  = "You can't store this vehicle",

    ['HouseNotOwned']     = "Bạn không sở hữu căn nhà này",
    ['InvitedInside']     = "Chấp nhận lời mời vào căn nhà",
    ['MovedTooFar']       = "Bạn đã di chuyển ra quá xa khỏi khu vực cửa nhà",
    ['KnockAtDoor']       = "Ai đó đang gõ cửa nhà bạn",

    ['TrackMessage']      = "Track message",

    ['Unlocked']          = "Nhà đã được mở khoá",
    ['Locked']            = "Nhà đã được khoá lại",

    ['WardrobeSet']       = "Wardrobe set",
    ['InventorySet']      = "Inventory set",

    ['ToggleFurni']       = "Toggle furniture UI",

    ['GivingKeys']        = "Giving keys to player",
    ['TakingKeys']        = "Taking keys from player",

    ['GarageSet']         = "Garage location set",
    ['GarageTooFar']      = "Garage is too far away",

    ['PurchasedHouse']    = "You brought the house for $%d",
    ['CantAffordHouse']   = "You can't afford this house",

    ['MortgagedHouse']    = "You mortgaged the house for $%d",

    ['NoLockpick']        = "You don't have a lockpick",
    ['LockpickFailed']    = "You failed to crack the lock",
    ['LockpickSuccess']   = "You successfully cracked the lock",

    ['NotifyRobbery']     = "Someone is attempting to rob a house at %s",

    ['ProgressLockpicking'] = "Lockpicking Door",

    ['InvalidShell']        = "Invalid house shell: %s, please report to your server owner.",
    ['ShellNotLoaded']      = "Shell would not load: %s, please report to your server owner.",
    ['BrokenOffset']        = "Offset is messed up for house with ID %s, please report to your server owner.",

    ['UpgradeHouse']        = "Upgrade house to: %s",
    ['CantAffordUpgrade']   = "You can't afford this upgrade",

    ['SetSalePrice']        = "Set sale price",
    ['InvalidAmount']       = "Invalid amount entered",
    ['InvalidSale']         = "You can't sell a house that you still owe money on",
    ['InvalidMoney']        = "You don't have enough money",

    ['EvictingTenants']     = "Evicting tenants",

    ['NoOutfits']           = "You don't have any outfits stored",

    ['EnterHouse']          = "Vào nhà",
    ['KnockHouse']          = "Gõ cửa",
    ['RaidHouse']           = "Raid House",
    ['BreakIn']             = "Break In",
    ['InviteInside']        = "Mời vào nhà",
    ['HouseKeys']           = "Quản lý chìa khoá",
    ['UpgradeHouse2']       = "Upgrade House",
    ['UpgradeShell']        = "Upgrade Shell",
    ['SellHouse']           = "Bán lại căn nhà",
    ['FurniUI']             = "Trang trí nội thất",
    ['SetWardrobe']         = "Đặt vị trí tủ quần áo",
    ['SetInventory']        = "Đặt vị trí tủ đồ cá nhân",
    ['SetGarage']           = "Set Garage",
    ['LockDoor']            = "Khoá nhà",
    ['UnlockDoor']          = "Mở khoá nhà",
    ['LeaveHouse']          = "Rời khỏi nhà",
    ['Mortgage']            = "Mortgage",
    ['Buy']                 = "Mua nhà",
    ['View']                = "Tham quan nhà",
    ['Upgrades']            = "Upgrades",
    ['MoveGarage']          = "Move Garage",

    ['GiveKeys']            = "Đưa chìa khoá",
    ['TakeKeys']            = "Lấy lại chìa khoá",

    ['MyHouse']             = "My House",
    ['PlayerHouse']         = "Player House",
    ['EmptyHouse']          = "Empty House",

    ['NoUpgrades']          = "No upgrades available",
    ['NoVehicles']          = "No vehicles",
    ['NothingToDisplay']    = "Nothing to display",

    ['ConfirmSale']         = "Yes, sell my house",
    ['CancelSale']          = "No, don't sell my house",
    ['SellingHouse']        = "Sell House ($%d)",

    ['MoneyOwed']           = "Money Owed: $%s",
    ['LastRepayment']       = "Last Repayment: %s",
    ['PayMortgage']         = "Pay Mortgage",
    ['MortgageInfo']        = "Mortgage Info",

    ['SetEntry']            = "Set Entry",
    ['CancelGarage']        = "Cancel Garage",
    ['UseInterior']         = "Use Interior",
    ['UseShell']            = "Use Shell",
    ['InteriorType']        = "Set Interior Type",
    ['SetInterior']         = "Select Current Interior",
    ['SelectDefaultShell']  = "Select default house shell",
    ['ToggleShells']        = "Toggle shells available for this property",
    ['AvailableShells']     = "Available Shells",
    ['Enabled']             = "~g~ENABLED~s~",
    ['Disabled']            = "~r~DISABLED~s~",
    ['NewDoor']             = "Add New Door",
    ['Done']                = "Done",
    ['Doors']               = "Doors",
    ['Interior']            = "Interior",

    ['CreationComplete']    = "House creation complete.",

    ['HousePurchased'] = "Your house was purchased for $%d",
    ['HouseEarning']   = ", you earnt $%d from the sale."
  }
}

Labels = labels[Config.Locale]

