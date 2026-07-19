var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]) - 400;
layer_x("sky_parallax", cam_x * 0.4);
layer_x("building_parallax", cam_x * 0.3);
layer_y("sky_parallax", cam_y * 0.1);
layer_y("building_parallax", cam_y * 0.1);
