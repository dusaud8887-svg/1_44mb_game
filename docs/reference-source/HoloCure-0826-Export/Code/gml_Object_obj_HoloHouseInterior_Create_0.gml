gameTick = 0;
buildingMode = false;
gridWidth = 27;
gridHeight = 13;
gridWall = 5;
interiorGrid = array_create(gridWidth, -1);
interiorWall = array_create(gridWidth, -1);
for (var i = 0; i < gridWidth; i++)
{
    interiorGrid[i] = array_create(gridHeight, -1);
}
for (var i = 0; i < gridWidth; i++)
{
    interiorWall[i] = array_create(gridWall, -1);
}

function loadInterior()
{
    show_debug_message("loading furniture");
    if (ds_map_find_value(global.PlayerSave, "holoHouseFloor") != -1)
    {
        for (var i = 0; i < gridHeight; i++)
        {
            for (var j = 0; j < gridWidth; j++)
            {
                if (array_get(array_get(ds_map_find_value(global.PlayerSave, "holoHouseFloor"), j), i) != -1)
                {
                    var furnData = ds_map_find_value(global.FurnitureLibrary, array_get(array_get(array_get(ds_map_find_value(global.PlayerSave, "holoHouseFloor"), j), i), 0).furnitureID);
                    if (is_undefined(furnData))
                    {
                    }
                    else
                    {
                        var furniture;
                        if (furnData.isSolid)
                        {
                            furniture = instance_create_depth(obj_HoloHouseInterior.x + (j * 16), obj_HoloHouseInterior.y + (i * 16), depth, obj_Furniture);
                        }
                        else
                        {
                            furniture = instance_create_depth(obj_HoloHouseInterior.x + (j * 16), obj_HoloHouseInterior.y + (i * 16), depth, obj_Furniture2);
                        }
                        furniture.sprite_index = array_get(furnData.sprites, array_get(array_get(array_get(ds_map_find_value(global.PlayerSave, "holoHouseFloor"), j), i), 1));
                        furniture.sprites = furnData.sprites;
                        furniture.currentRotation = array_get(array_get(array_get(ds_map_find_value(global.PlayerSave, "holoHouseFloor"), j), i), 1);
                        furniture.furnitureData = furnData;
                        furniture.origin = array_get(array_get(array_get(ds_map_find_value(global.PlayerSave, "holoHouseFloor"), j), i), 2);
                        furniture.spriteWidth = furnData.spriteWidth;
                        furniture.spriteHeight = furnData.spriteHeight;
                        furniture.scripts = {};
                        furniture.customDrawScriptAbove = {};
                        furniture.isSolid = furnData.isSolid;
                        variable_struct_copy(furnData.scripts, furniture.scripts);
                        variable_struct_copy(furnData.customDrawScriptAbove, furniture.customDrawScriptAbove);
                        obj_HoloHouseManager.placingObject = furnData;
                        obj_HoloHouseManager.currentRotation = furniture.currentRotation;
                        obj_HoloHouseManager.gridCursor = [j, i];
                        obj_HoloHouseManager.SetGrid("place", furniture);
                    }
                }
            }
        }
    }
    if (ds_map_find_value(global.PlayerSave, "holoHouseWall") != -1)
    {
        for (var i = 0; i < gridWall; i++)
        {
            for (var j = 0; j < gridWidth; j++)
            {
                if (array_get(array_get(ds_map_find_value(global.PlayerSave, "holoHouseWall"), j), i) != -1)
                {
                    var furnData = ds_map_find_value(global.FurnitureLibrary, array_get(array_get(array_get(ds_map_find_value(global.PlayerSave, "holoHouseWall"), j), i), 0).furnitureID);
                    if (is_undefined(furnData))
                    {
                    }
                    else
                    {
                        var furniture;
                        if (furnData.isSolid)
                        {
                            furniture = instance_create_depth(obj_HoloHouseInterior.x + (j * 16), obj_HoloHouseInterior.y + ((i - 5) * 16), depth, obj_Furniture);
                        }
                        else
                        {
                            furniture = instance_create_depth(obj_HoloHouseInterior.x + (j * 16), obj_HoloHouseInterior.y + ((i - 5) * 16), depth, obj_Furniture2);
                        }
                        furniture.sprite_index = array_get(furnData.sprites, array_get(array_get(array_get(ds_map_find_value(global.PlayerSave, "holoHouseWall"), j), i), 1));
                        furniture.sprites = furnData.sprites;
                        furniture.currentRotation = array_get(array_get(array_get(ds_map_find_value(global.PlayerSave, "holoHouseWall"), j), i), 1);
                        furniture.furnitureData = furnData;
                        furniture.scripts = {};
                        furniture.customDrawScriptAbove = {};
                        furniture.isSolid = furnData.isSolid;
                        variable_struct_copy(furnData.scripts, furniture.scripts);
                        variable_struct_copy(furnData.customDrawScriptAbove, furniture.customDrawScriptAbove);
                        furniture.origin = array_get(array_get(array_get(ds_map_find_value(global.PlayerSave, "holoHouseWall"), j), i), 2);
                        obj_HoloHouseManager.placingObject = furnData;
                        obj_HoloHouseManager.currentRotation = furniture.currentRotation;
                        obj_HoloHouseManager.gridCursor = [j, i - 5];
                        obj_HoloHouseManager.SetGrid("place", furniture);
                    }
                }
            }
        }
    }
}

loadInterior();
