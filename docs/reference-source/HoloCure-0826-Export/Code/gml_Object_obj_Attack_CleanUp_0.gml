if (instance_exists(creator))
{
    if (variable_instance_exists(id, "emitter"))
    {
        part_emitter_destroy(global.psystem, emitter);
    }
}
