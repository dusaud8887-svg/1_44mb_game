if (enable)
{
    if (instance_number(obj_ItemCrate) < spawnLimit)
    {
        if (spawnTimer > 0)
        {
            spawnTimer--;
        }
    }
    if (spawnTimer == 0 && instance_number(obj_ItemCrate) < spawnLimit)
    {
        spawnTimer = 600 + irandom(600);
        var player = instance_find(obj_Player, 0);
        var randDir = irandom(359);
        var xLen = lengthdir_x(500 + irandom(500), randDir);
        var yLen = lengthdir_y(500 + irandom(500), randDir);
        var spawnX = player.x + xLen;
        var spawnY = player.y + yLen;
        if (global.leftBorder != -1)
        {
            var playXArea = global.rightBorder - global.leftBorder;
            spawnX = global.leftBorder + irandom(playXArea);
        }
        if (global.topBorder != -1)
        {
            var playYArea = global.bottomBorder - global.topBorder;
            spawnY = global.topBorder + irandom(playYArea);
        }
        var crate = instance_create_layer(spawnX, spawnY, "Instances", obj_ItemCrate);
        crate.Spawn();
    }
}
