dir = 0;
dir2 = 0;
log = false;
dist = 200;

function SetPosition()
{
    dir2 += 1;
    if (dir2 > 360)
    {
        dir2 -= 360;
    }
    var edge = obj_StageManager._FindEdgeSpawnCoordinate(dir2, 
    {
        width: 0,
        height: 0
    });
    with (directional_test)
    {
        x = edge.x;
        y = edge.y;
    }
    dir = point_direction(obj_Player.x, obj_Player.y, edge.x, edge.y);
    x = obj_Player.x + lengthdir_x(dist, dir);
    y = obj_Player.y + lengthdir_y(dist, dir);
}
