if (variable_global_exists("soundPlayingList") && ds_exists(global.soundPlayingList, ds_type_map))
{
    ds_map_destroy(global.soundPlayingList);
    global.soundPlayingList = -1;
}
global.soundPlayingList = ds_map_create();
