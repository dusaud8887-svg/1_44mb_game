var size = ds_map_size(global.soundPlayingList);
var key = ds_map_find_first(global.soundPlayingList);
if (size > 0)
{
    for (var i = 0; i < size; i++)
    {
        ds_map_set(global.soundPlayingList, key, ds_map_find_value(global.soundPlayingList, key) - 1);
        var prevkey = key;
        key = ds_map_find_next(global.soundPlayingList, key);
        if (ds_map_find_value(global.soundPlayingList, prevkey) == 0)
        {
            ds_map_delete(global.soundPlayingList, prevkey);
        }
    }
}
