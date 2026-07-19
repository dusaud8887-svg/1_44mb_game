depth = -y + 300;
clones = false;
var light = glr_light_create(2064, 0, x, y, make_color_rgb(157, 213, 255), 0.08);
glr_light_set_layer(light, 5);
glr_light_set_shadow_strength(light, 1);
global.lightingExists = true;
lifetime = 0;
