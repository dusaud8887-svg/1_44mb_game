player = -1;
depth = -y - 2;
isInView = false;
followPlayerID = instance_find(obj_Player, 0);
range = 40;
if (!variable_instance_exists(id, "expVal"))
{
    expVal = 0;
}
SPD = 0;
picked = false;
damage = 0.5;
initialSpawn = true;
alarm[0] = 30;
