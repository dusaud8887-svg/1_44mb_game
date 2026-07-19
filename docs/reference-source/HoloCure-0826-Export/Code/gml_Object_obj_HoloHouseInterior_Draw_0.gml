gameTick++;
currentAlpha = 0.2 + (0.4 * abs(sin(gameTick / 20)));
if (buildingMode)
{
    for (var i = 0; i < gridWidth; i++)
    {
        for (var j = 0; j < gridHeight; j++)
        {
            if (interiorGrid[i][j] == -1)
            {
                draw_set_alpha(abs(currentAlpha));
                draw_sprite(spr_HoloHouse_grid, 0, x + (i * 16), y + (j * 16));
                draw_set_alpha(1);
            }
        }
        for (var j = 0; j < gridWall; j++)
        {
            if (interiorWall[i][j] == -1)
            {
                draw_set_alpha(currentAlpha);
                draw_sprite(spr_HoloHouse_grid, 0, x + (i * 16), (y - (gridWall * 16)) + (j * 16));
                draw_set_alpha(1);
            }
        }
    }
}
