depth = -y;
noWarp = true;
playerFollow = instance_find(obj_Player, 0);
amIinView = true;
lastViewCheck = 30;
depth = -y;
if (global.wrappingStage)
{
    if (x <= 1280)
    {
        var clone = instance_copy(false);
        clone.x += room_width - 1280;
        clone.depth = -y;
    }
    if (x >= (room_width - 1280))
    {
        var clone = instance_copy(false);
        clone.x -= room_width - 1280;
        clone.depth = -y;
    }
    if (y <= 1280)
    {
        var clone = instance_copy(false);
        clone.y += room_height - 1280;
        clone.depth = -y;
    }
    if (y >= (room_height - 1280))
    {
        var clone = instance_copy(false);
        clone.y -= room_height - 1280;
        clone.depth = -y;
    }
    if (x <= 1280 && y <= 1280)
    {
        var clone = instance_copy(false);
        clone.x += room_width - 1280;
        clone.y += room_height - 1280;
        clone.depth = -y;
    }
    if (x <= 1280 && y >= (room_height - 1280))
    {
        var clone = instance_copy(false);
        clone.x += room_width - 1280;
        clone.y -= room_height - 1280;
        clone.depth = -y;
    }
    if (x >= (room_width - 1280) && y <= 1280)
    {
        var clone = instance_copy(false);
        clone.x -= room_width - 1280;
        clone.y += room_height - 1280;
        clone.depth = -y;
    }
    if (x >= (room_width - 1280) && y >= (room_height - 1280))
    {
        var clone = instance_copy(false);
        clone.x -= room_width - 1280;
        clone.y -= room_height - 1280;
        clone.depth = -y;
    }
}
