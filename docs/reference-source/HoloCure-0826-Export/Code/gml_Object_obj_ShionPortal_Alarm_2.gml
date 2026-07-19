var vfx = instance_create_depth(x, y, depth - 2, obj_vfx);
vfx.sprite_index = sprite_index;
vfx.add = true;
vfx.duration = 60;
vfx.alarm[1] = 1;
vfx.vspeed = -2;
vfx.image_alpha = 0.5;
alarm[2] = 30;
