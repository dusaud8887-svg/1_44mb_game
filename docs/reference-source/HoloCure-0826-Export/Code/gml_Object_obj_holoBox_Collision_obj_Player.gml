var playerMan = instance_find(obj_PlayerManager, 0);
if (!playerMan.gotBox && !playerMan.gotAnvil && !playerMan.gotGoldenAnvil)
{
    playerMan.getBox();
    if (global.bgmPlay > 0)
    {
        audio_pause_sound(global.bgmPlay);
    }
    instance_destroy();
}
