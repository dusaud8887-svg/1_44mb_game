if (paused)
{
    if (buildingMode && !pickedUpMenu)
    {
        for (var i = 0; i < (obj_HoloHouseInterior.gridHeight + obj_HoloHouseInterior.gridWall); i++)
        {
            for (var j = 0; j < obj_HoloHouseInterior.gridWidth; j++)
            {
                if (MouseOverButton("tile", obj_HoloHouseInterior.x + (j * 16), (obj_HoloHouseInterior.y - (obj_HoloHouseInterior.gridWall * 16)) + (i * 16)))
                {
                    if (obj_InputManager.MouseMoved() && (gridCursor[0] != j || gridCursor[1] != i) && !openCatalog && !placing)
                    {
                        gridCursor[0] = j;
                        gridCursor[1] = i - 5;
                    }
                    if (gridCursor[0] == j && gridCursor[1] == (i - 5) && !openCatalog)
                    {
                        ClickButton();
                    }
                }
            }
        }
    }
    if (buildingMode && placingObject == -1 && !pickedUpMenu)
    {
        draw_set_alpha(0.5);
        draw_set_color(c_white);
        draw_rectangle(obj_HoloHouseInterior.x + (gridCursor[0] * 16), obj_HoloHouseInterior.y + (gridCursor[1] * 16), obj_HoloHouseInterior.x + (gridCursor[0] * 16) + 16, obj_HoloHouseInterior.y + (gridCursor[1] * 16) + 16, false);
        draw_set_alpha(1);
    }
    if (buildingMode && placingObject != -1 && !placing)
    {
        draw_set_alpha(0.8);
        var drawColor = 16777215;
        if (!ValidPlacement())
        {
            drawColor = 255;
        }
        draw_sprite_ext(placingObject.sprites[currentRotation], 0, obj_HoloHouseInterior.x + (gridCursor[0] * 16), (obj_HoloHouseInterior.y + (gridCursor[1] * 16)) - 3, 1, 1, 0, drawColor, 0.8);
        draw_set_alpha(1);
    }
    else if (buildingMode && placingObject != -1 && placing)
    {
        var drawColor = 16777215;
        if (!ValidPlacement())
        {
            drawColor = 255;
        }
        draw_sprite_ext(placingObject.sprites[currentRotation], 0, obj_HoloHouseInterior.x + (gridCursor[0] * 16), obj_HoloHouseInterior.y + (gridCursor[1] * 16), 1, 1, 0, drawColor, 1);
        draw_sprite(spr_rotation, 0, obj_HoloHouseInterior.x + (gridCursor[0] * 16) + ((placingObject.gridData[0] * 16) / 2), obj_HoloHouseInterior.y + (gridCursor[1] * 16) + ((placingObject.gridData[1] * 16) / 2));
        ClickButton();
    }
}
if (whiteFlash > 0)
{
    draw_set_alpha(whiteFlash);
    draw_rectangle_colour(0, 0, 10000, 10000, c_white, c_white, c_white, c_white, false);
    draw_set_alpha(1);
}
