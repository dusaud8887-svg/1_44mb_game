if (variable_instance_exists(id, "emitter"))
{
    part_emitter_destroy(global.psystem, emitter);
}
audio_stop_sound(snd_cookingpot);
