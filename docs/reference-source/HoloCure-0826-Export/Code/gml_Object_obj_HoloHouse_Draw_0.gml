inView = x > (camera_get_view_x(view_camera[0]) - 100) && x < (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + 100) && y > (camera_get_view_y(view_camera[0]) - 100) && y < (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 100 + abs(bbox_top - bbox_bottom));
depth = -y;
draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
gpu_set_blendmode(bm_normal);
shader_reset();
