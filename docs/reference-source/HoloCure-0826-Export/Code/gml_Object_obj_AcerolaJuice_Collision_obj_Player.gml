if (canTake)
{
    audio_play_sound(snd_acerolabuff, 10, 0);
    obj_PlayerManager.UpdateBuffIfExists("AcerolaJuice", buffConfig);
    obj_AttackController.ApplyBuff(other, "AcerolaJuice", ds_map_find_value(obj_AttackController.Buffs, "AcerolaJuice"), buffConfig);
    instance_destroy();
}
