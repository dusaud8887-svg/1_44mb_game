var dirToPlayer = point_direction(x, y, obj_Player.x, obj_Player.y);
move_outside_all(dirToPlayer, 50);
part_emitter_region(global.psystem, emitter, x - 15, x + 20, y, y - 30, 0, 0);
