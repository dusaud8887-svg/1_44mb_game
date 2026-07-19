Furniture = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6 = 100, arg7 = 3, arg8 = {}, arg9 = {}, arg10 = true) constructor
{
    id = arg0;
    furnitureIcon = arg1.furnitureIcon;
    furnitureName = arg1.furnitureName;
    furnitureDescription = variable_struct_exists(arg1, "furnitureDescription") ? arg1.furnitureDescription : global.TextContainer.stockTooltip.selectedLanguage;
    furnitureID = arg0;
    furnitureUnlocked = true;
    sprites = arg2;
    furnitureNumber = arg3;
    furnitureType = arg4;
    gridData = arg5;
    if (is_array(gridData))
    {
        spriteWidth = arg5[0] * 16;
        spriteHeight = arg7;
    }
    else
    {
        spriteWidth = -1;
        spriteHeight = -1;
    }
    scripts = arg8;
    customDrawScriptAbove = arg9;
    furnitureCost = arg6;
    isSolid = arg10;
};

if (!variable_global_exists("FurnitureLibrary"))
{
    FURNITURES = ds_map_create();
}
else
{
    ds_map_destroy(global.FurnitureLibrary);
    global.FurnitureLibrary = -1;
    FURNITURES = ds_map_create();
}
var orderNum = 0;
var _newFurn = "woodenBed";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 818,
    furnitureName: global.TextContainer.f_woodenBed.selectedLanguage[0]
}, [500, 1351, 1729, 179], orderNum, "beds", [2, 3], 0));
orderNum++;
_newFurn = "woodenBedB";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1687,
    furnitureName: global.TextContainer.f_woodenBedB.selectedLanguage[0]
}, [1566, 174, 698, 1332], orderNum, "beds", [2, 3], 1000));
orderNum++;
_newFurn = "woodenBedC";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1847,
    furnitureName: global.TextContainer.f_woodenBedC.selectedLanguage[0]
}, [684, 50, 2448, 1590], orderNum, "beds", [2, 3], 1000));
orderNum++;
_newFurn = "woodenBedD";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 169,
    furnitureName: global.TextContainer.f_woodenBedD.selectedLanguage[0]
}, [666, 1371, 1686, 411], orderNum, "beds", [2, 3], 1000));
orderNum++;
_newFurn = "marblebed";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1958,
    furnitureName: global.TextContainer.f_Marble_Bed.selectedLanguage[0]
}, [1853, 205, 911, 2415], orderNum, "beds", [2, 3], 50000));
orderNum++;
_newFurn = "futon";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2363,
    furnitureName: global.TextContainer.f_futon.selectedLanguage[0]
}, [2194, 423, 1856, 2119], orderNum, "beds", [2, 3], 100000, -1, undefined, undefined, false));
orderNum++;
_newFurn = "couchA";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2079,
    furnitureName: global.TextContainer.f_couchA.selectedLanguage[0]
}, [654, 523, 1083, 1731], orderNum, "living", [3, 1], 0));
orderNum++;
_newFurn = "foxburger";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 946,
    furnitureName: global.TextContainer.f_foxBurger.selectedLanguage[0]
}, [757, 140, 588, 680], orderNum, "living", [2, 2], 300000));
orderNum++;
_newFurn = "nightstandA";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1025,
    furnitureName: global.TextContainer.f_nightstandA.selectedLanguage[0]
}, [1484, 210, 2398, 1651], orderNum, "beds", [1, 1], 0));
orderNum++;
_newFurn = "nightstandB";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 472,
    furnitureName: global.TextContainer.f_nightstandB.selectedLanguage[0]
}, [364, 1740, 2462, 1758], orderNum, "beds", [1, 1], 3000));
orderNum++;
_newFurn = "woodenDresserA";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 755,
    furnitureName: global.TextContainer.f_woodendresserA.selectedLanguage[0]
}, [1714, 614, 376, 2259], orderNum, "beds", [2, 1], 5000));
orderNum++;
_newFurn = "woodendesk";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 57,
    furnitureName: global.TextContainer.f_woodenDesk.selectedLanguage[0]
}, [927, 1819, 1795, 1159], orderNum, "beds", [2, 1], 3000));
orderNum++;
_newFurn = "woodenPCdesk";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 178,
    furnitureName: global.TextContainer.f_woodenPC.selectedLanguage[0]
}, [1653, 1250, 1303, 897], orderNum, "beds", [2, 1], 5000));
orderNum++;
_newFurn = "marbledesk";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 863,
    furnitureName: global.TextContainer.f_Marble_Desk.selectedLanguage[0]
}, [2395, 208, 933, 2168], orderNum, "beds", [2, 1], 20000));
orderNum++;
_newFurn = "marblelaptopdesk";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 438,
    furnitureName: global.TextContainer.f_Marble_LaptopDesk.selectedLanguage[0]
}, [565, 2218, 1389, 2273], orderNum, "beds", [3, 1], 40000));
orderNum++;
_newFurn = "beanbag";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1543,
    furnitureName: global.TextContainer.f_beanbag.selectedLanguage[0]
}, [1501, 1906, 1678, 2148], orderNum, "beds", [2, 1], 25000));
orderNum++;
_newFurn = "officechair";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1119,
    furnitureName: global.TextContainer.f_OfficeChair.selectedLanguage[0]
}, [352, 632, 1419, 2253], orderNum, "beds", [1, 1], 20000));
orderNum++;
_newFurn = "gamerchaira";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1933,
    furnitureName: global.TextContainer.f_GamerChairA.selectedLanguage[0]
}, [2362, 2022, 177, 1912], orderNum, "beds", [1, 1], 75000));
orderNum++;
_newFurn = "gamerchairb";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 327,
    furnitureName: global.TextContainer.f_GamerChairB.selectedLanguage[0]
}, [63, 2154, 2323, 1184], orderNum, "beds", [1, 1], 75000));
orderNum++;
_newFurn = "gamerchairc";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 188,
    furnitureName: global.TextContainer.f_GamerChairC.selectedLanguage[0]
}, [1086, 1508, 875, 522], orderNum, "beds", [1, 1], 75000));
orderNum++;
_newFurn = "gamerchaird";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1925,
    furnitureName: global.TextContainer.f_GamerChairD.selectedLanguage[0]
}, [304, 608, 583, 935], orderNum, "beds", [1, 1], 75000));
orderNum++;
_newFurn = "gamerchaire";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1620,
    furnitureName: global.TextContainer.f_GamerChairE.selectedLanguage[0]
}, [1824, 1274, 902, 1265], orderNum, "beds", [1, 1], 75000));
orderNum++;
_newFurn = "gamerchairf";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 121,
    furnitureName: global.TextContainer.f_GamerChairF.selectedLanguage[0]
}, [1242, 879, 1055, 113], orderNum, "beds", [1, 1], 75000));
orderNum++;
_newFurn = "gamerchairg";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2376,
    furnitureName: global.TextContainer.f_GamerChairG.selectedLanguage[0]
}, [1021, 1613, 1531, 1175], orderNum, "beds", [1, 1], 75000));
orderNum++;
_newFurn = "gamerchairH";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1049,
    furnitureName: global.TextContainer.f_GamerChairH.selectedLanguage[0]
}, [891, 1622, 81, 1206], orderNum, "beds", [1, 1], 20000));
orderNum++;
_newFurn = "vanity";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2158,
    furnitureName: global.TextContainer.f_vanity.selectedLanguage[0]
}, [16, 1870, 1626, 392], orderNum, "beds", [2, 1], 15000));
orderNum++;
_newFurn = "bodypillow";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1995,
    furnitureName: global.TextContainer.f_bodyPillow.selectedLanguage[0]
}, [426, 1438, 531, 1380], orderNum, "beds", [1, 2], 100000));
orderNum++;
_newFurn = "woodenDiningTable";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2390,
    furnitureName: global.TextContainer.f_Wooden_DiningTable.selectedLanguage[0]
}, [1724, 1724, 571, 571], orderNum, "kitchen", [3, 2], 0));
orderNum++;
_newFurn = "marbleTable";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1716,
    furnitureName: global.TextContainer.f_marble_DiningTable.selectedLanguage[0]
}, [1196, 2422, 1196, 2422], orderNum, "kitchen", [3, 3], 50000));
orderNum++;
_newFurn = "woodenDiningChair";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2118,
    furnitureName: global.TextContainer.f_Wooden_DiningChair.selectedLanguage[0]
}, [172, 1366, 629, 1693], orderNum, "kitchen", [1, 1], 0));
orderNum++;
_newFurn = "marblechair";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 492,
    furnitureName: global.TextContainer.f_Marble_Chair.selectedLanguage[0]
}, [952, 735, 587, 622], orderNum, "kitchen", [1, 1], 25000));
orderNum++;
_newFurn = "stoolA1";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2289,
    furnitureName: global.TextContainer.f_stoolA1.selectedLanguage[0]
}, [1477, 1477, 1477, 1477], orderNum, "kitchen", [1, 1], 1000, -1));
orderNum++;
_newFurn = "woodentable";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 358,
    furnitureName: global.TextContainer.f_Wooden_Table.selectedLanguage[0]
}, [513, 2342, 1393, 1533], orderNum, "living", [2, 2], 15000, -1));
orderNum++;
_newFurn = "marbletable";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2208,
    furnitureName: global.TextContainer.f_Marble_Table.selectedLanguage[0]
}, [993, 12, 2207, 648], orderNum, "living", [2, 2], 60000, -1));
orderNum++;
_newFurn = "glasstable";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2405,
    furnitureName: global.TextContainer.f_glassTable.selectedLanguage[0]
}, [1799, 679, 714, 1998], orderNum, "living", [3, 2], 100000, -1));
orderNum++;
_newFurn = "easterntable";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1880,
    furnitureName: global.TextContainer.f_easternTable.selectedLanguage[0]
}, [1829, 1996, 1629, 2328], orderNum, "living", [2, 2], 150000, -1));
orderNum++;
_newFurn = "floorcushion";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2263,
    furnitureName: global.TextContainer.f_floorCushion.selectedLanguage[0]
}, [1204, 1204, 1204, 1204], orderNum, "living", [1, 1], 50000, -1, undefined, undefined, false));
orderNum++;
_newFurn = "woodentallcabinet";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2397,
    furnitureName: global.TextContainer.f_Wooden_TallCabinet.selectedLanguage[0]
}, [2031, 2249, 559, 93], orderNum, "living", [1, 1], 20000));
orderNum++;
_newFurn = "standinglampA";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2027,
    furnitureName: global.TextContainer.f_lamp.selectedLanguage[0]
}, [112, 112, 112, 112], orderNum, "living", [1, 1], 2000, -1));
orderNum++;
_newFurn = "fireplace";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1717,
    furnitureName: global.TextContainer.f_fireplace.selectedLanguage[0]
}, [454, 2325, 1984, 2015], orderNum, "living", [3, 1], 30000));
orderNum++;
_newFurn = "TVStand";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 294,
    furnitureName: global.TextContainer.f_TVStand.selectedLanguage[0]
}, [338, 2226, 2355, 2206], orderNum, "living", [3, 1], 20000));
orderNum++;
_newFurn = "crttv";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 601,
    furnitureName: global.TextContainer.f_CRTTV.selectedLanguage[0]
}, [1519, 213, 1525, 756], orderNum, "living", [2, 1], 100000));
orderNum++;
_newFurn = "retroconsole";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2321,
    furnitureName: global.TextContainer.f_retroConsole.selectedLanguage[0]
}, [39, 972, 562, 1676], orderNum, "living", [1, 1], 150000, -1));
orderNum++;
_newFurn = "vrset";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 68,
    furnitureName: global.TextContainer.f_VRSet.selectedLanguage[0]
}, [85, 195, 123, 703], orderNum, "living", [1, 1], 150000, -1));
orderNum++;
_newFurn = "woodenbookshelf";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 146,
    furnitureName: global.TextContainer.f_bookshelfA.selectedLanguage[0]
}, [744, 1247, 87, 1584], orderNum, "living", [1, 1], 3000));
orderNum++;
_newFurn = "marblebookshelf";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2407,
    furnitureName: global.TextContainer.f_Marble_bookshelf.selectedLanguage[0]
}, [2266, 1234, 718, 1708], orderNum, "living", [1, 1], 30000));
orderNum++;
_newFurn = "displaycase";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1871,
    furnitureName: global.TextContainer.f_displayCase.selectedLanguage[0]
}, [958, 84, 1392, 1668], orderNum, "living", [1, 1], 100000));
orderNum++;
_newFurn = "kitchenCounterA";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1421,
    furnitureName: global.TextContainer.f_kitchencounterA.selectedLanguage[0]
}, [838, 2337, 584, 1120], orderNum, "kitchen", [1, 1], 5000, -1));
orderNum++;
_newFurn = "Microwave";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 945,
    furnitureName: global.TextContainer.f_Microwave.selectedLanguage[0]
}, [1132, 1628, 1348, 1516], orderNum, "kitchen", [1, 1], 15000, -1));
orderNum++;
_newFurn = "marbleCounter";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 638,
    furnitureName: global.TextContainer.f_kitchencounterB.selectedLanguage[0]
}, [1530, 1818, 2426, 2235], orderNum, "kitchen", [1, 1], 30000, -1));
orderNum++;
_newFurn = "marblesink";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 788,
    furnitureName: global.TextContainer.f_sinkcounterA.selectedLanguage[0]
}, [2182, 1449, 944, 1030], orderNum, "kitchen", [1, 1], 50000, -1));
orderNum++;
_newFurn = "fridge";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 38,
    furnitureName: global.TextContainer.f_Fridge.selectedLanguage[0]
}, [2191, 2176, 917, 1702], orderNum, "kitchen", [1, 1], 5000));
orderNum++;
_newFurn = "stove";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1534,
    furnitureName: global.TextContainer.f_stove.selectedLanguage[0]
}, [1227, 1363, 1144, 586], orderNum, "kitchen", [1, 1], 5000, -1));
orderNum++;
_newFurn = "woodenCrate";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2129,
    furnitureName: global.TextContainer.f_WoodenCrate.selectedLanguage[0]
}, [1158, 1158, 1158, 1158], orderNum, "decor", [1, 1], 5000, -1));
orderNum++;
_newFurn = "woodenbarrel";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 595,
    furnitureName: global.TextContainer.f_WoodenBarrel.selectedLanguage[0]
}, [1931, 1931, 1931, 1931], orderNum, "decor", [1, 1], 5000, -1));
orderNum++;
_newFurn = "boxA";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1902,
    furnitureName: global.TextContainer.f_BoxA.selectedLanguage[0]
}, [1923, 605, 1634, 1634], orderNum, "decor", [1, 1], 5000, -1));
orderNum++;
_newFurn = "BoxB";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2157,
    furnitureName: global.TextContainer.f_BoxB.selectedLanguage[0]
}, [1744, 53, 307, 307], orderNum, "decor", [1, 1], 5000, -1));
orderNum++;
_newFurn = "TreasureChestA";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1669,
    furnitureName: global.TextContainer.f_TreasureChestA.selectedLanguage[0]
}, [1341, 2423, 515, 1044], orderNum, "decor", [1, 1], 20000, -1));
orderNum++;
_newFurn = "plantpotA";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 284,
    furnitureName: global.TextContainer.f_plantpotA.selectedLanguage[0]
}, [198, 198, 198, 198], orderNum, "decor", [1, 1], 2000, -1));
orderNum++;
_newFurn = "plantpotB";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1899,
    furnitureName: global.TextContainer.f_plantpotB.selectedLanguage[0]
}, [1474, 1474, 1474, 1474], orderNum, "decor", [1, 1], 20000, -1));
orderNum++;
_newFurn = "plantpotC";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1448,
    furnitureName: global.TextContainer.f_plantpotC.selectedLanguage[0]
}, [2416, 1869, 9, 230], orderNum, "decor", [1, 1], 20000, -1));
orderNum++;
_newFurn = "berryplant";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2334,
    furnitureName: global.TextContainer.f_berryplant.selectedLanguage[0]
}, [2199, 885, 1965, 1968], orderNum, "decor", [1, 1], 150000, -1));
orderNum++;
_newFurn = "marblestump";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1926,
    furnitureName: global.TextContainer.f_Marble_Stump.selectedLanguage[0]
}, [1079, 1092, 1581, 1955], orderNum, "decor", [1, 1], 20000, -1));
orderNum++;
_newFurn = "dumbell";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1244,
    furnitureName: global.TextContainer.f_dumbells.selectedLanguage[0]
}, [1582, 579, 152, 1568], orderNum, "decor", [1, 1], 50000, -1));
orderNum++;
_newFurn = "exerciseball";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 701,
    furnitureName: global.TextContainer.f_exerciseBall.selectedLanguage[0]
}, [1905, 1905, 1905, 1905], orderNum, "decor", [1, 1], 50000, -1));
orderNum++;
_newFurn = "boxingdummy";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1672,
    furnitureName: global.TextContainer.f_boxingDummy.selectedLanguage[0]
}, [1834, 2432, 1834, 2432], orderNum, "decor", [1, 1], 200000, -1));
orderNum++;
_newFurn = "vampirecoffin";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2430,
    furnitureName: global.TextContainer.f_coffin.selectedLanguage[0]
}, [1502, 1878, 158, 1660], orderNum, "decor", [1, 1], 250000, 30));
orderNum++;
_newFurn = "baegemite";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2412,
    furnitureName: global.TextContainer.f_baegemite.selectedLanguage[0]
}, [633, 1946, 1010, 849], orderNum, "decor", [1, 1], 200000, -1));
orderNum++;
_newFurn = "taikodrums";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1062,
    furnitureName: global.TextContainer.f_taikodrum.selectedLanguage[0]
}, [2181, 1194, 2009, 1753], orderNum, "decor", [2, 3], 300000));
orderNum++;
_newFurn = "shrinebox";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 941,
    furnitureName: global.TextContainer.f_shrineBox.selectedLanguage[0]
}, [1666, 748, 193, 653], orderNum, "decor", [2, 1], 250000, -1));
orderNum++;
_newFurn = "KFPbucket";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1765,
    furnitureName: global.TextContainer.f_KFPbucket.selectedLanguage[0]
}, [1324, 1956, 811, 1476], orderNum, "decor", [1, 1], 200000, -1));
orderNum++;
_newFurn = "sharkplush";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 58,
    furnitureName: global.TextContainer.f_sharkplush.selectedLanguage[0]
}, [1498, 18, 656, 360], orderNum, "decor", [1, 2], 300000));
orderNum++;
_newFurn = "nekoplush";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2075,
    furnitureName: global.TextContainer.f_neko.selectedLanguage[0]
}, [2110, 526, 8, 790], orderNum, "decor", [3, 1], 300000));
orderNum++;
_newFurn = "achandoll";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 254,
    furnitureName: global.TextContainer.f_AchanDoll.selectedLanguage[0]
}, [200, 2222, 1098, 859], orderNum, "decor", [1, 1], 100000, -1));
orderNum++;
_newFurn = "completegrass";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 749,
    furnitureName: global.TextContainer.f_completeTrophy.selectedLanguage[0]
}, [932, 932, 932, 932], orderNum, "decor", [2, 2], 1));
orderNum++;
_newFurn = "woodendivider";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1748,
    furnitureName: global.TextContainer.f_WoodenDivider.selectedLanguage[0]
}, [0, 0, 525, 525], orderNum, "structure", [1, 1], 10000, 1));
orderNum++;
_newFurn = "marblepartition";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2400,
    furnitureName: global.TextContainer.f_Marble_Partition.selectedLanguage[0]
}, [1632, 1445, 1529, 761], orderNum, "structure", [2, 1], 30000, 10));
orderNum++;
_newFurn = "easterndivider";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1243,
    furnitureName: global.TextContainer.f_easternDivider.selectedLanguage[0]
}, [97, 1682, 1131, 1131], orderNum, "structure", [1, 1], 100000, 20));
orderNum++;
_newFurn = "woodenwall";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2308,
    furnitureName: global.TextContainer.f_WoodenWall.selectedLanguage[0]
}, [258, 1515, 2385, 1367], orderNum, "structure", [2, 1], 2000, 64));
orderNum++;
_newFurn = "woodenhalfwall";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 563,
    furnitureName: global.TextContainer.f_WoodenHalfWall.selectedLanguage[0]
}, [660, 292, 1989, 894], orderNum, "structure", [2, 1], 3000, 16));
orderNum++;
_newFurn = "woodencolumn";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1306,
    furnitureName: global.TextContainer.f_WoodenColumn.selectedLanguage[0]
}, [1225, 1225, 56, 56], orderNum, "structure", [1, 1], 5000, 64));
orderNum++;
_newFurn = "marblecolumn";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2317,
    furnitureName: global.TextContainer.f_MarbleColumn.selectedLanguage[0]
}, [456, 456, 456, 456], orderNum, "structure", [1, 1], 50000, 64));
orderNum++;
_newFurn = "woodendoor";
var customScript = 
{
    DoorOpen: 
    {
        Script: function(arg0, arg1, arg2)
        {
            if (point_distance(arg0.x, arg0.y, arg1.x + ((arg1.furnitureData.gridData[0] * 16) / 2), arg1.y + ((arg1.furnitureData.gridData[1] * 16) / 2)) < 40)
            {
                if (arg2.state == 0)
                {
                    switch (arg1.sprite_index)
                    {
                        case furn_Wooden_DoorClosed1:
                            arg1.sprite_index = furn_Wooden_DoorOpen1;
                            break;
                        case furn_Wooden_DoorClosed2:
                            arg1.sprite_index = furn_Wooden_DoorOpen2;
                            break;
                        case furn_Wooden_DoorClosed3:
                            arg1.sprite_index = furn_Wooden_DoorOpen3;
                            break;
                        case furn_Wooden_DoorClosed4:
                            arg1.sprite_index = furn_Wooden_DoorOpen4;
                            break;
                    }
                    audio_play_sound(snd_dooropen, 0, 0);
                    arg2.state = 1;
                }
            }
            else if (arg2.state == 1)
            {
                switch (arg1.sprite_index)
                {
                    case furn_Wooden_DoorOpen1:
                        arg1.sprite_index = furn_Wooden_DoorClosed1;
                        break;
                    case furn_Wooden_DoorOpen2:
                        arg1.sprite_index = furn_Wooden_DoorClosed2;
                        break;
                    case furn_Wooden_DoorOpen3:
                        arg1.sprite_index = furn_Wooden_DoorClosed3;
                        break;
                    case furn_Wooden_DoorOpen4:
                        arg1.sprite_index = furn_Wooden_DoorClosed4;
                        break;
                }
                audio_play_sound(snd_doorclose, 0, 0);
                arg2.state = 0;
            }
        },
        
        config: 
        {
            state: 0
        }
    }
};
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 845,
    furnitureName: global.TextContainer.f_WoodenDoor.selectedLanguage[0]
}, [1261, 1846, 1868, 2132], orderNum, "structure", [2, 1], 5000, 64, customScript, undefined, false));
orderNum++;
_newFurn = "bathstool";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1426,
    furnitureName: global.TextContainer.f_Bathstool.selectedLanguage[0]
}, [736, 736, 518, 518], orderNum, "wash", [1, 1], 10000, -1));
orderNum++;
_newFurn = "sink";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 687,
    furnitureName: global.TextContainer.f_sink.selectedLanguage[0]
}, [1901, 1281, 23, 621], orderNum, "wash", [1, 1], 20000, -1));
orderNum++;
_newFurn = "bathtub";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 485,
    furnitureName: global.TextContainer.f_Bathtub.selectedLanguage[0]
}, [2356, 6, 532, 2437], orderNum, "wash", [2, 3], 15000, -1));
orderNum++;
_newFurn = "toilet";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 948,
    furnitureName: global.TextContainer.f_Toilet.selectedLanguage[0]
}, [2402, 2373, 1671, 732], orderNum, "wash", [1, 1], 10000, -1));
orderNum++;
_newFurn = "washingmachine";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1258,
    furnitureName: global.TextContainer.f_WashingMachine.selectedLanguage[0]
}, [1178, 1720, 2420, 1699], orderNum, "wash", [1, 1], 50000, -1));
orderNum++;
_newFurn = "laundrybasket";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1166,
    furnitureName: global.TextContainer.f_laundrybasket.selectedLanguage[0]
}, [776, 443, 1993, 1657], orderNum, "wash", [2, 1], 20000, -1));
orderNum++;
_newFurn = "clock";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2102,
    furnitureName: global.TextContainer.f_Clock.selectedLanguage[0]
}, [1541, 1541, 1541, 1541], orderNum, "wall", [1, 1], 3000));
orderNum++;
_newFurn = "kroniclock";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1735,
    furnitureName: global.TextContainer.f_kroniClock.selectedLanguage[0]
}, [2189, 2189, 2189, 2189], orderNum, "wall", [1, 1], 200000));
orderNum++;
_newFurn = "paintingA";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2145,
    furnitureName: global.TextContainer.f_paintingA.selectedLanguage[0]
}, [1198, 1198, 1198, 1198], orderNum, "wall", [1, 1], 2000));
orderNum++;
_newFurn = "paintingC";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 368,
    furnitureName: global.TextContainer.f_paintingC.selectedLanguage[0]
}, [1844, 1844, 1844, 1844], orderNum, "wall", [1, 2], 30000));
orderNum++;
_newFurn = "paintingB";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 227,
    furnitureName: global.TextContainer.f_paintingB.selectedLanguage[0]
}, [557, 557, 557, 557], orderNum, "wall", [2, 2], 50000));
orderNum++;
_newFurn = "paintingD";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1589,
    furnitureName: global.TextContainer.f_paintingD.selectedLanguage[0]
}, [340, 340, 340, 340], orderNum, "wall", [3, 2], 75000));
orderNum++;
_newFurn = "wallmirror";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2243,
    furnitureName: global.TextContainer.f_wallMirror.selectedLanguage[0]
}, [44, 44, 44, 44], orderNum, "wall", [1, 2], 20000));
orderNum++;
_newFurn = "lantern";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1879,
    furnitureName: global.TextContainer.f_lantern.selectedLanguage[0]
}, [1401, 1401, 1401, 1401], orderNum, "wall", [1, 1], 10000));
orderNum++;
_newFurn = "hangingvine";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2214,
    furnitureName: global.TextContainer.f_hangingVines.selectedLanguage[0]
}, [624, 624, 624, 624], orderNum, "wall", [2, 3], 50000));
orderNum++;
_newFurn = "mountedSword";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2105,
    furnitureName: global.TextContainer.f_mountedSword.selectedLanguage[0]
}, [1509, 1683, 1509, 1683], orderNum, "wall", [1, 1], 30000));
orderNum++;
_newFurn = "demonSword";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 905,
    furnitureName: global.TextContainer.f_demonSword.selectedLanguage[0]
}, [2156, 2156, 2156, 2156], orderNum, "wall", [2, 1], 200000));
orderNum++;
_newFurn = "window";
customDraw = 
{
    WindowLight: function(arg0)
    {
        gpu_set_blendmode(bm_add);
        draw_sprite(furn_windowLight, 0, arg0.x, arg0.y);
        gpu_set_blendmode(bm_normal);
    }
};
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 763,
    furnitureName: global.TextContainer.f_window.selectedLanguage[0]
}, [1009, 1009, 1009, 1009], orderNum, "wall", [2, 2], 5000, undefined, undefined, customDraw));
orderNum++;
_newFurn = "goldenfish1";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1096,
    furnitureName: global.TextContainer.f_goldTrophy1.selectedLanguage[0]
}, [80, 80, 80, 80], orderNum, "wall", [2, 2], 0));
orderNum++;
_newFurn = "goldenfish2";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 628,
    furnitureName: global.TextContainer.f_goldTrophy2.selectedLanguage[0]
}, [888, 888, 888, 888], orderNum, "wall", [2, 2], 0));
orderNum++;
_newFurn = "goldenfish3";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1315,
    furnitureName: global.TextContainer.f_goldTrophy3.selectedLanguage[0]
}, [471, 471, 471, 471], orderNum, "wall", [2, 2], 0));
orderNum++;
_newFurn = "goldenfish4";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2152,
    furnitureName: global.TextContainer.f_goldTrophy4.selectedLanguage[0]
}, [1164, 1164, 1164, 1164], orderNum, "wall", [2, 2], 0));
orderNum++;
_newFurn = "goldenfish5";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2121,
    furnitureName: global.TextContainer.f_goldTrophy5.selectedLanguage[0]
}, [554, 554, 554, 554], orderNum, "wall", [2, 2], 0));
orderNum++;
_newFurn = "goldenfish6";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 604,
    furnitureName: global.TextContainer.f_goldTrophy6.selectedLanguage[0]
}, [1930, 1930, 1930, 1930], orderNum, "wall", [2, 2], 0));
orderNum++;
_newFurn = "goldenfish7";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1054,
    furnitureName: global.TextContainer.f_goldTrophy7.selectedLanguage[0]
}, [2372, 2372, 2372, 2372], orderNum, "wall", [2, 2], 0));
orderNum++;
_newFurn = "goldenfish8";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1943,
    furnitureName: global.TextContainer.f_goldTrophy8.selectedLanguage[0]
}, [2205, 2205, 2205, 2205], orderNum, "wall", [2, 2], 0));
orderNum++;
_newFurn = "goldenfish9";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 813,
    furnitureName: global.TextContainer.f_goldTrophy9.selectedLanguage[0]
}, [185, 185, 185, 185], orderNum, "wall", [2, 2], 0));
orderNum++;
_newFurn = "goldenfish10";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2076,
    furnitureName: global.TextContainer.f_goldTrophy10.selectedLanguage[0]
}, [954, 954, 954, 954], orderNum, "wall", [2, 2], 0));
orderNum++;
_newFurn = "goldenfish11";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1352,
    furnitureName: global.TextContainer.f_goldTrophy11.selectedLanguage[0]
}, [1885, 1885, 1885, 1885], orderNum, "wall", [2, 2], 0));
orderNum++;
_newFurn = "goldenfish12";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 220,
    furnitureName: global.TextContainer.f_goldTrophy12.selectedLanguage[0]
}, [1246, 1246, 1246, 1246], orderNum, "wall", [2, 2], 0));
orderNum++;
_newFurn = "hardcoretrophy";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 55,
    furnitureName: global.TextContainer.f_hardcoreTrophy.selectedLanguage[0]
}, [408, 408, 408, 408], orderNum, "wall", [2, 2], 0));
orderNum++;
_newFurn = "woodenFloor";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2265,
    furnitureName: global.TextContainer.fl_wooden.selectedLanguage[0]
}, -1, orderNum, "interior", "floor", 0));
orderNum++;
_newFurn = "woodenFloor2";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 750,
    furnitureName: global.TextContainer.fl_wooden2.selectedLanguage[0]
}, -1, orderNum, "interior", "floor", 10000));
orderNum++;
_newFurn = "stoneFloor";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1193,
    furnitureName: global.TextContainer.fl_stoneFloor.selectedLanguage[0]
}, -1, orderNum, "interior", "floor", 100000));
orderNum++;
_newFurn = "redCarpetFloor";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 120,
    furnitureName: global.TextContainer.fl_redCarpet.selectedLanguage[0]
}, -1, orderNum, "interior", "floor", 25000));
orderNum++;
_newFurn = "blueCarpetFloor";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1342,
    furnitureName: global.TextContainer.fl_blueCarpet.selectedLanguage[0]
}, -1, orderNum, "interior", "floor", 25000));
orderNum++;
_newFurn = "pinkCarpetFloor";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 534,
    furnitureName: global.TextContainer.fl_pinkCarpet.selectedLanguage[0]
}, -1, orderNum, "interior", "floor", 25000));
orderNum++;
_newFurn = "concreteFloor";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 589,
    furnitureName: global.TextContainer.fl_concrete.selectedLanguage[0]
}, -1, orderNum, "interior", "floor", 50000));
orderNum++;
_newFurn = "marbleFloor";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2227,
    furnitureName: global.TextContainer.fl_marble.selectedLanguage[0]
}, -1, orderNum, "interior", "floor", 50000));
orderNum++;
_newFurn = "tiledFloor";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 747,
    furnitureName: global.TextContainer.fl_tiled.selectedLanguage[0]
}, -1, orderNum, "interior", "floor", 25000));
orderNum++;
_newFurn = "tatamiFloor";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1130,
    furnitureName: global.TextContainer.fl_tatami.selectedLanguage[0]
}, -1, orderNum, "interior", "floor", 100000));
orderNum++;
_newFurn = "woodenWall";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2080,
    furnitureName: global.TextContainer.w_wooden.selectedLanguage[0]
}, -1, orderNum, "interior", "wall", 0));
orderNum++;
_newFurn = "flatWall";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1881,
    furnitureName: global.TextContainer.w_flat.selectedLanguage[0]
}, -1, orderNum, "interior", "wall", 10000));
orderNum++;
_newFurn = "stripedWall";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1186,
    furnitureName: global.TextContainer.w_striped.selectedLanguage[0]
}, -1, orderNum, "interior", "wall", 10000));
orderNum++;
_newFurn = "skyWall";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1810,
    furnitureName: global.TextContainer.w_sky.selectedLanguage[0]
}, -1, orderNum, "interior", "wall", 50000));
orderNum++;
_newFurn = "polkaWallA";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 394,
    furnitureName: global.TextContainer.w_polkaA.selectedLanguage[0]
}, -1, orderNum, "interior", "wall", 75000));
orderNum++;
_newFurn = "polkaWallB";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1180,
    furnitureName: global.TextContainer.w_polkaB.selectedLanguage[0]
}, -1, orderNum, "interior", "wall", 75000));
orderNum++;
_newFurn = "polkaWallC";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 238,
    furnitureName: global.TextContainer.w_polkaC.selectedLanguage[0]
}, -1, orderNum, "interior", "wall", 75000));
orderNum++;
_newFurn = "oceanWall";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 837,
    furnitureName: global.TextContainer.w_ocean.selectedLanguage[0]
}, -1, orderNum, "interior", "wall", 100000));
orderNum++;
_newFurn = "modernWall";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 2452,
    furnitureName: global.TextContainer.w_modern.selectedLanguage[0]
}, -1, orderNum, "interior", "wall", 100000));
orderNum++;
_newFurn = "stoneWall";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 1553,
    furnitureName: global.TextContainer.w_stone.selectedLanguage[0]
}, -1, orderNum, "interior", "wall", 100000));
orderNum++;
_newFurn = "easternWall";
ds_map_set(FURNITURES, _newFurn, new Furniture(_newFurn, 
{
    furnitureIcon: 248,
    furnitureName: global.TextContainer.w_eastern.selectedLanguage[0]
}, -1, orderNum, "interior", "wall", 100000));
orderNum++;
global.FurnitureLibrary = FURNITURES;
