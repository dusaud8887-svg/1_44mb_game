audio_play_sound(snd_horror, 10, 0);
var enemiesMurdered = 0;
with (obj_Enemy)
{
    if (!miniboss && !isBoss && inView)
    {
        Die();
        enemiesMurdered++;
    }
}
var buffConfig = 
{
    weight: enemiesMurdered,
    buffIcon: 2007
};
obj_AttackController.ApplyBuff(227, "MumeiHorror", ds_map_find_value(obj_AttackController.Buffs, "MumeiHorror"), buffConfig);
alarm[1] = 30;
