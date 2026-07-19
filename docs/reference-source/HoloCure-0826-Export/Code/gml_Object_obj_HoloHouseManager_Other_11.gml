Inventory = function(arg0, arg1, arg2, arg3, arg4, arg5 = 0, arg6 = {}) constructor
{
    id = arg0;
    inventoryIcon = arg1.inventoryIcon;
    inventoryName = arg1.inventoryName;
    inventoryDescription = variable_struct_exists(arg1, "inventoryDescription") ? arg1.inventoryDescription : global.TextContainer.stockTooltip.selectedLanguage;
    inventoryID = arg0;
    sprites = arg2;
    inventoryNumber = arg3;
    inventoryType = arg4;
    inventoryValue = arg5;
    config = arg6;
};

if (!variable_global_exists("InventoryLibrary"))
{
    INVENTORY = ds_map_create();
}
else
{
    ds_map_destroy(global.InventoryLibrary);
    global.InventoryLibrary = -1;
    INVENTORY = ds_map_create();
}
var orderNum = 0;
var _newInventory = "shrimp";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1202,
    inventoryName: global.TextContainer.i_shrimp.selectedLanguage
}, 846, orderNum, "fish", 50, 
{
    spawnRate: [40, 20, 10, 7, 1, 5],
    catchMultiplier: [1, 1, 2, 2, 3, 4],
    tier: 0
}));
orderNum++;
_newInventory = "clownfish";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 716,
    inventoryName: global.TextContainer.i_clownfish.selectedLanguage
}, 2092, orderNum, "fish", 100, 
{
    spawnRate: [30, 20, 15, 7, 2, 6],
    catchMultiplier: [1, 1, 2, 2, 3, 3],
    tier: 0
}));
orderNum++;
_newInventory = "tuna";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1767,
    inventoryName: global.TextContainer.i_tuna.selectedLanguage
}, 521, orderNum, "fish", 150, 
{
    spawnRate: [30, 25, 15, 8, 2, 7],
    catchMultiplier: [1, 1, 2, 2, 2, 3],
    tier: 0
}));
orderNum++;
_newInventory = "koifish";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1703,
    inventoryName: global.TextContainer.i_koi.selectedLanguage
}, 1974, orderNum, "fish", 200, 
{
    spawnRate: [0, 15, 15, 10, 4, 8],
    catchMultiplier: [1, 1, 1, 2, 2, 3],
    tier: 1
}));
orderNum++;
_newInventory = "lobster";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1080,
    inventoryName: global.TextContainer.i_lobster.selectedLanguage
}, 1505, orderNum, "fish", 250, 
{
    spawnRate: [0, 15, 15, 13, 8, 9],
    catchMultiplier: [1, 1, 1, 2, 2, 2],
    tier: 1
}));
orderNum++;
_newInventory = "eel";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1837,
    inventoryName: global.TextContainer.i_eel.selectedLanguage
}, 255, orderNum, "fish", 300, 
{
    spawnRate: [0, 5, 15, 14, 10, 10],
    catchMultiplier: [1, 1, 1, 2, 2, 2],
    tier: 1
}));
orderNum++;
_newInventory = "pufferfish";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 805,
    inventoryName: global.TextContainer.i_pufferfish.selectedLanguage
}, 1000, orderNum, "fish", 350, 
{
    spawnRate: [0, 0, 9, 14, 15, 10],
    catchMultiplier: [1, 1, 1, 1, 2, 2],
    tier: 2
}));
orderNum++;
_newInventory = "mantaray";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 925,
    inventoryName: global.TextContainer.i_mantaray.selectedLanguage
}, 878, orderNum, "fish", 400, 
{
    spawnRate: [0, 0, 6, 12, 17, 10],
    catchMultiplier: [1, 1, 1, 1, 1, 2],
    tier: 2
}));
orderNum++;
_newInventory = "turtle";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 420,
    inventoryName: global.TextContainer.i_turtle.selectedLanguage
}, 2319, orderNum, "fish", 450, 
{
    spawnRate: [0, 0, 0, 8, 20, 10],
    catchMultiplier: [1, 1, 1, 1, 1, 2],
    tier: 2
}));
orderNum++;
_newInventory = "squid";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1941,
    inventoryName: global.TextContainer.i_squid.selectedLanguage
}, 453, orderNum, "fish", 500, 
{
    spawnRate: [0, 0, 0, 7, 15, 10],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 3
}));
orderNum++;
_newInventory = "shark";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 768,
    inventoryName: global.TextContainer.i_shark.selectedLanguage
}, 1790, orderNum, "fish", 750, 
{
    spawnRate: [0, 0, 0, 0, 5, 10],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 3
}));
orderNum++;
_newInventory = "axolotl";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1537,
    inventoryName: global.TextContainer.i_axolotl.selectedLanguage
}, 1061, orderNum, "fish", 2000, 
{
    spawnRate: [0, 0, 0, 0, 1, 5],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 4
}));
orderNum++;
_newInventory = "goldenshrimp";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1719,
    inventoryName: global.TextContainer.i_golden.selectedLanguage + " " + global.TextContainer.i_shrimp.selectedLanguage
}, 530, orderNum, "fish", 5000, 
{
    spawnRate: [0, 0, 0, 0, 0, 0],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 4
}));
orderNum++;
_newInventory = "goldenclownfish";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1248,
    inventoryName: global.TextContainer.i_golden.selectedLanguage + " " + global.TextContainer.i_clownfish.selectedLanguage
}, 1090, orderNum, "fish", 10000, 
{
    spawnRate: [0, 0, 0, 0, 0, 0],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 4
}));
orderNum++;
_newInventory = "goldentuna";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 263,
    inventoryName: global.TextContainer.i_golden.selectedLanguage + " " + global.TextContainer.i_tuna.selectedLanguage
}, 2443, orderNum, "fish", 15000, 
{
    spawnRate: [0, 0, 0, 0, 0, 0],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 4
}));
orderNum++;
_newInventory = "goldenkoifish";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 2037,
    inventoryName: global.TextContainer.i_golden.selectedLanguage + " " + global.TextContainer.i_koi.selectedLanguage
}, 1420, orderNum, "fish", 20000, 
{
    spawnRate: [0, 0, 0, 0, 0, 0],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 4
}));
orderNum++;
_newInventory = "goldenlobster";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 274,
    inventoryName: global.TextContainer.i_golden.selectedLanguage + " " + global.TextContainer.i_lobster.selectedLanguage
}, 873, orderNum, "fish", 25000, 
{
    spawnRate: [0, 0, 0, 0, 0, 0],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 4
}));
orderNum++;
_newInventory = "goldeneel";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 2357,
    inventoryName: global.TextContainer.i_golden.selectedLanguage + " " + global.TextContainer.i_eel.selectedLanguage
}, 1647, orderNum, "fish", 30000, 
{
    spawnRate: [0, 0, 0, 0, 0, 0],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 4
}));
orderNum++;
_newInventory = "goldenpufferfish";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 433,
    inventoryName: global.TextContainer.i_golden.selectedLanguage + " " + global.TextContainer.i_pufferfish.selectedLanguage
}, 866, orderNum, "fish", 35000, 
{
    spawnRate: [0, 0, 0, 0, 0, 0],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 4
}));
orderNum++;
_newInventory = "goldenmantaray";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 463,
    inventoryName: global.TextContainer.i_golden.selectedLanguage + " " + global.TextContainer.i_mantaray.selectedLanguage
}, 2104, orderNum, "fish", 40000, 
{
    spawnRate: [0, 0, 0, 0, 0, 0],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 4
}));
orderNum++;
_newInventory = "goldenturtle";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1979,
    inventoryName: global.TextContainer.i_golden.selectedLanguage + " " + global.TextContainer.i_turtle.selectedLanguage
}, 333, orderNum, "fish", 45000, 
{
    spawnRate: [0, 0, 0, 0, 0, 0],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 4
}));
orderNum++;
_newInventory = "goldensquid";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1723,
    inventoryName: global.TextContainer.i_golden.selectedLanguage + " " + global.TextContainer.i_squid.selectedLanguage
}, 2028, orderNum, "fish", 50000, 
{
    spawnRate: [0, 0, 0, 0, 0, 0],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 4
}));
orderNum++;
_newInventory = "goldenshark";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 903,
    inventoryName: global.TextContainer.i_golden.selectedLanguage + " " + global.TextContainer.i_shark.selectedLanguage
}, 335, orderNum, "fish", 75000, 
{
    spawnRate: [0, 0, 0, 0, 0, 0],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 4
}));
orderNum++;
_newInventory = "goldenaxolotl";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1439,
    inventoryName: global.TextContainer.i_golden.selectedLanguage + " " + global.TextContainer.i_axolotl.selectedLanguage
}, 306, orderNum, "fish", 200000, 
{
    spawnRate: [0, 0, 0, 0, 0, 0],
    catchMultiplier: [1, 1, 1, 1, 1, 1],
    tier: 4
}));
orderNum++;
_newInventory = "beginnersRod";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 457,
    inventoryName: global.TextContainer.fishingRods.selectedLanguage[0][0],
    inventoryDescription: global.TextContainer.fishingRods.selectedLanguage[0][1]
}, -1, orderNum, "rod", 0));
orderNum++;
_newInventory = "dadsRod";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1115,
    inventoryName: global.TextContainer.fishingRods.selectedLanguage[1][0],
    inventoryDescription: global.TextContainer.fishingRods.selectedLanguage[1][1]
}, -1, orderNum, "rod", 3000));
orderNum++;
_newInventory = "blacksmithRod";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 836,
    inventoryName: global.TextContainer.fishingRods.selectedLanguage[2][0],
    inventoryDescription: global.TextContainer.fishingRods.selectedLanguage[2][1]
}, -1, orderNum, "rod", 15000));
orderNum++;
_newInventory = "atlanticRod";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 297,
    inventoryName: global.TextContainer.fishingRods.selectedLanguage[3][0],
    inventoryDescription: global.TextContainer.fishingRods.selectedLanguage[3][1]
}, -1, orderNum, "rod", 50000));
orderNum++;
_newInventory = "turkeyRod";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 2309,
    inventoryName: global.TextContainer.fishingRods.selectedLanguage[4][0],
    inventoryDescription: global.TextContainer.fishingRods.selectedLanguage[4][1]
}, -1, orderNum, "rod", 250000));
orderNum++;
_newInventory = "goldenRod";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 434,
    inventoryName: global.TextContainer.fishingRods.selectedLanguage[5][0],
    inventoryDescription: global.TextContainer.fishingRods.selectedLanguage[5][1]
}, -1, orderNum, "rod", 1000000));
orderNum++;
_newInventory = "wheat";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 2174,
    inventoryName: global.TextContainer.i_wheat.selectedLanguage[0],
    inventoryDescription: global.TextContainer.i_wheat.selectedLanguage[0]
}, -1, orderNum, "crop", 50, 
{
    tier: 0
}));
orderNum++;
_newInventory = "wheatSeed";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 270,
    inventoryName: global.TextContainer.i_wheat.selectedLanguage[1],
    inventoryDescription: global.TextContainer.i_wheat.selectedLanguage[1]
}, -1, orderNum, "seed", 100, 
{
    plantSprite: 70,
    growthTime: 18000,
    cropID: "wheat"
}));
orderNum++;
_newInventory = "tomato";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1927,
    inventoryName: global.TextContainer.i_tomato.selectedLanguage[0],
    inventoryDescription: global.TextContainer.i_tomato.selectedLanguage[0]
}, -1, orderNum, "crop", 100, 
{
    tier: 0
}));
orderNum++;
_newInventory = "tomatoSeed";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 782,
    inventoryName: global.TextContainer.i_tomato.selectedLanguage[1],
    inventoryDescription: global.TextContainer.i_tomato.selectedLanguage[1]
}, -1, orderNum, "seed", 150, 
{
    plantSprite: 1192,
    growthTime: 21600,
    cropID: "tomato"
}));
orderNum++;
_newInventory = "potato";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 2230,
    inventoryName: global.TextContainer.i_potato.selectedLanguage[0],
    inventoryDescription: global.TextContainer.i_potato.selectedLanguage[0]
}, -1, orderNum, "crop", 150, 
{
    tier: 0
}));
orderNum++;
_newInventory = "potatoSeed";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1650,
    inventoryName: global.TextContainer.i_potato.selectedLanguage[1],
    inventoryDescription: global.TextContainer.i_potato.selectedLanguage[1]
}, -1, orderNum, "seed", 200, 
{
    plantSprite: 167,
    growthTime: 23400,
    cropID: "potato"
}));
orderNum++;
_newInventory = "rice";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 781,
    inventoryName: global.TextContainer.i_rice.selectedLanguage[0],
    inventoryDescription: global.TextContainer.i_rice.selectedLanguage[0]
}, -1, orderNum, "crop", 200, 
{
    tier: 1
}));
orderNum++;
_newInventory = "riceSeed";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 2391,
    inventoryName: global.TextContainer.i_rice.selectedLanguage[1],
    inventoryDescription: global.TextContainer.i_rice.selectedLanguage[1]
}, -1, orderNum, "seed", 250, 
{
    plantSprite: 139,
    growthTime: 25200,
    cropID: "rice"
}));
orderNum++;
_newInventory = "onion";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1111,
    inventoryName: global.TextContainer.i_onion.selectedLanguage[0],
    inventoryDescription: global.TextContainer.i_onion.selectedLanguage[0]
}, -1, orderNum, "crop", 250, 
{
    tier: 1
}));
orderNum++;
_newInventory = "onionseed";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 2304,
    inventoryName: global.TextContainer.i_onion.selectedLanguage[1],
    inventoryDescription: global.TextContainer.i_onion.selectedLanguage[1]
}, -1, orderNum, "seed", 300, 
{
    plantSprite: 2436,
    growthTime: 27000,
    cropID: "onion"
}));
orderNum++;
_newInventory = "carrot";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1040,
    inventoryName: global.TextContainer.i_carrot.selectedLanguage[0],
    inventoryDescription: global.TextContainer.i_carrot.selectedLanguage[0]
}, -1, orderNum, "crop", 300, 
{
    tier: 1
}));
orderNum++;
_newInventory = "carrotseed";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1437,
    inventoryName: global.TextContainer.i_carrot.selectedLanguage[1],
    inventoryDescription: global.TextContainer.i_carrot.selectedLanguage[1]
}, -1, orderNum, "seed", 350, 
{
    plantSprite: 317,
    growthTime: 28800,
    cropID: "carrot"
}));
orderNum++;
_newInventory = "greenbeans";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 202,
    inventoryName: global.TextContainer.i_greenbeans.selectedLanguage[0],
    inventoryDescription: global.TextContainer.i_greenbeans.selectedLanguage[0]
}, -1, orderNum, "crop", 350, 
{
    tier: 2
}));
orderNum++;
_newInventory = "greenbeansseed";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 2320,
    inventoryName: global.TextContainer.i_greenbeans.selectedLanguage[1],
    inventoryDescription: global.TextContainer.i_greenbeans.selectedLanguage[1]
}, -1, orderNum, "seed", 400, 
{
    plantSprite: 382,
    growthTime: 30600,
    cropID: "greenbeans"
}));
orderNum++;
_newInventory = "peppers";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 2348,
    inventoryName: global.TextContainer.i_peppers.selectedLanguage[0],
    inventoryDescription: global.TextContainer.i_peppers.selectedLanguage[0]
}, -1, orderNum, "crop", 400, 
{
    tier: 2
}));
orderNum++;
_newInventory = "peppersseed";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 229,
    inventoryName: global.TextContainer.i_peppers.selectedLanguage[1],
    inventoryDescription: global.TextContainer.i_peppers.selectedLanguage[1]
}, -1, orderNum, "seed", 450, 
{
    plantSprite: 2060,
    growthTime: 32400,
    cropID: "peppers"
}));
orderNum++;
_newInventory = "strawberry";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 2236,
    inventoryName: global.TextContainer.i_strawberry.selectedLanguage[0],
    inventoryDescription: global.TextContainer.i_strawberry.selectedLanguage[0]
}, -1, orderNum, "crop", 450, 
{
    tier: 2
}));
orderNum++;
_newInventory = "strawberryseed";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1005,
    inventoryName: global.TextContainer.i_strawberry.selectedLanguage[1],
    inventoryDescription: global.TextContainer.i_strawberry.selectedLanguage[1]
}, -1, orderNum, "seed", 500, 
{
    plantSprite: 1388,
    growthTime: 34200,
    cropID: "strawberry"
}));
orderNum++;
_newInventory = "corn";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 99,
    inventoryName: global.TextContainer.i_corn.selectedLanguage[0],
    inventoryDescription: global.TextContainer.i_corn.selectedLanguage[0]
}, -1, orderNum, "crop", 500, 
{
    tier: 3
}));
orderNum++;
_newInventory = "cornseed";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 2465,
    inventoryName: global.TextContainer.i_corn.selectedLanguage[1],
    inventoryDescription: global.TextContainer.i_corn.selectedLanguage[1]
}, -1, orderNum, "seed", 550, 
{
    plantSprite: 377,
    growthTime: 36000,
    cropID: "corn"
}));
orderNum++;
_newInventory = "radish";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1859,
    inventoryName: global.TextContainer.i_radish.selectedLanguage[0],
    inventoryDescription: global.TextContainer.i_radish.selectedLanguage[0]
}, -1, orderNum, "crop", 550, 
{
    tier: 3
}));
orderNum++;
_newInventory = "radishseed";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1606,
    inventoryName: global.TextContainer.i_radish.selectedLanguage[1],
    inventoryDescription: global.TextContainer.i_radish.selectedLanguage[1]
}, -1, orderNum, "seed", 600, 
{
    plantSprite: 1136,
    growthTime: 39600,
    cropID: "radish"
}));
orderNum++;
_newInventory = "garlic";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 2162,
    inventoryName: global.TextContainer.i_garlic.selectedLanguage[0],
    inventoryDescription: global.TextContainer.i_garlic.selectedLanguage[0]
}, -1, orderNum, "crop", 600, 
{
    tier: 3
}));
orderNum++;
_newInventory = "garlicseed";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 289,
    inventoryName: global.TextContainer.i_garlic.selectedLanguage[1],
    inventoryDescription: global.TextContainer.i_garlic.selectedLanguage[1]
}, -1, orderNum, "seed", 650, 
{
    plantSprite: 835,
    growthTime: 43200,
    cropID: "garlic"
}));
orderNum++;
_newInventory = "standardsoil";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 514,
    inventoryName: global.TextContainer.farmSoils.selectedLanguage[0][0],
    inventoryDescription: global.TextContainer.farmSoils.selectedLanguage[0][1]
}, -1, orderNum, "soil", 200, 
{
    tag: global.TextContainer.farmSoils.selectedLanguage[0][2]
}));
orderNum++;
_newInventory = "expeditedsoil";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 1556,
    inventoryName: global.TextContainer.farmSoils.selectedLanguage[1][0],
    inventoryDescription: global.TextContainer.farmSoils.selectedLanguage[1][1]
}, -1, orderNum, "soil", 750, 
{
    tag: global.TextContainer.farmSoils.selectedLanguage[1][2]
}));
orderNum++;
_newInventory = "enhancedsoil";
ds_map_set(INVENTORY, _newInventory, new Inventory(_newInventory, 
{
    inventoryIcon: 2424,
    inventoryName: global.TextContainer.farmSoils.selectedLanguage[2][0],
    inventoryDescription: global.TextContainer.farmSoils.selectedLanguage[2][1]
}, -1, orderNum, "soil", 1500, 
{
    tag: global.TextContainer.farmSoils.selectedLanguage[2][2]
}));
orderNum++;
global.InventoryLibrary = INVENTORY;
