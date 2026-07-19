remainingUses = 1 + global.anvilUses;
depth = -y - 2;
emitter = part_emitter_create(global.psystem);
part_emitter_region(global.psystem, emitter, x - 15, x + 20, y, y - 30, 0, 0);
part_emitter_stream(global.psystem, emitter, global.partType3, 2);
part_system_depth(global.psystem, -9999);
followPlayerID = instance_find(obj_Player, 0);
isInView = false;
xPos = 0;
yPos = 0;
arrowDir = 0;
canCollide = false;
alarm[0] = 60;
used = false;

function Destroy()
{
    part_emitter_destroy(global.psystem, emitter);
    instance_destroy();
}
