var fish = instance_create_depth(obj_Player.x, obj_Player.y - 16, obj_Player.depth - 10, obj_GetFish);
fish.sprite_index = theFish.sprites;
audio_play_sound(snd_fishGet, 0, 0);
inventory_add(theFish.id, catchNumber);
DoAchievement("stealfish");
SavePlayerSave();
instance_destroy();
