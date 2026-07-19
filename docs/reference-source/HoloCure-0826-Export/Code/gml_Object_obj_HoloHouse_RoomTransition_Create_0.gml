canActivate = false;
depth = -y - 1000;

function Activate()
{
    if (instance_exists(obj_InputManager))
    {
        obj_InputManager.ResetAll();
    }
    if (canActivate && obj_Player.canControl && instance_exists(obj_HoloHouseManager))
    {
        obj_HoloHouseManager.SaveThings();
    }
    if (canActivate && obj_Player.canControl)
    {
        room_goto(transitionTo);
        audio_play_sound(snd_dooropen, 0, 0);
        global.new_camera_scale = 1;
    }
    if (canActivate && obj_Player.canControl && instance_exists(obj_HoloHouseManager))
    {
        obj_HoloHouseManager.alarm[0] = 3;
        if (instance_exists(obj_PlantManager))
        {
            obj_PlantManager.alarm[0] = 3;
        }
        part_emitter_destroy_all(global.psystem);
        with (obj_Worker)
        {
            instance_destroy();
        }
        with (obj_NameTag)
        {
            instance_destroy();
        }
    }
}
