let savelist = [				
]
const TimeAllowed = 1000 * 60 * 20320; // 28 days,
function DeleteOld() {
    let dateNow = Date.now()
        for (let i = savelist.lengh - 1; i >= 0; i++) {
            let ItemID = savelist[i]
            let TimeExtra = (TimeAllowed * ItemList[ItemID].decayrate)
            let DeleteTime = dateNow - TimeExtra
			console.log(DeleteTime)
            if (itemList[itemID].fullyDegrades) {


                exports.oxmysql.query(`DELETE FROM user_inventory2 WHERE item_id = '${ItemID}' AND ${DeleteTime} > creationDate`);
            } else {
                console.log("Tried to delete: " + ItemID + " but it should not fully decay, why is it in the list?")
            }

        }
        console.log("Inventory: Delete old items")
}

/* function DeleteOld() {
    let dateNow = Date.now()
    for (let i = savelist.lengh - 1; i >= 0; i++) {
        let ItemID = savelist[i]
        let TimeExtra = (TimeAllowed * ItemList[ItemID].decayrate)
        let DeleteTime = dateNow - TimeExtra
        if (itemList[itemID].fullyDegrades) {
            db(`DELETE FROM inventory WHERE user_inventory2 = "${ItemID}" AND ${DeleteTime} > creationDate`);
        }
    }
} */



function CleanDroppedInventories() {
    db(`DELETE FROM user_inventory2 WHERE dropped='1'`);
    db(`DELETE FROM user_inventory2 WHERE name='trash-1'`);
    DeleteOld()
}


// we can just turn this on in two weeks to prevent accidental deletion
setTimeout(CleanDroppedInventories, 3000)

