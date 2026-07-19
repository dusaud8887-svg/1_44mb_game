var playerMan = instance_find(obj_PlayerManager, 0);
with (playerMan)
{
    instance_destroy();
}
room_goto(rm_HiScores);
