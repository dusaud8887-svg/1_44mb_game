if (canCollide)
{
    var playerMan = instance_find(obj_PlayerManager, 0);
    playerMan.getAnvil(id);
    canCollide = false;
    alarm[0] = 60;
}
