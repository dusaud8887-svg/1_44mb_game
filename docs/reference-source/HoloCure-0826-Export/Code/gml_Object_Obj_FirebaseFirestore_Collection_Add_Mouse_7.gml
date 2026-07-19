randomize();
var map = ds_map_create();
ds_map_set(map, "value", choose("Opera", "YoYoGames", "GameMaker", "Firebase"));
ds_map_set(map, "points", irandom(999));
var json = json_encode(map);
ds_map_destroy(map);
FirebaseFirestore("Collection").Set(json);
