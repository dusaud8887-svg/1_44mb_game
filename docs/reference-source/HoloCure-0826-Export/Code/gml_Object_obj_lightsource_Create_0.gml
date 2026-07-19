depth = -y + 300;
clones = false;
var light = glr_light_create(971, 0, x, y, 4235519, 0.1);
glr_light_set_layer(light, 5);
glr_light_set_shadow_strength(light, 0);
global.lightingExists = true;
