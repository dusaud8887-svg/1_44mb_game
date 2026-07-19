event_inherited();
alarm[1] = 30;
emitter = part_emitter_create(global.psystem);
range = 20;
radius = 125;
alarm[2] = 480;
audio_play_sound(snd_dice, 10, 0);
if (!variable_instance_exists(self, "target"))
{
    targets = ds_list_create();
    numTargets = collision_circle_list(x, y, radius, obj_Enemy, false, true, targets, true);
    targets = obj_AttackController.RemoveFriendly(targets);
    numTargets = ds_list_size(targets);
    if (numTargets == 0)
    {
        target = "noTarget";
        direction = irandom(360);
        speed = 4 + random(5);
    }
    else
    {
        randomIndex = floor(random(numTargets));
        target = ds_list_find_value(targets, randomIndex);
    }
}
if (target != "noTarget" && instance_exists(target))
{
    direction = (point_direction(x, y, target.x, target.y) - 30) + random(60);
    speed = 4 + random(5);
}
