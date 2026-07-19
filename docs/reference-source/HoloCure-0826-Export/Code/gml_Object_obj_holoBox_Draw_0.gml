arrowDir = point_direction(followPlayerID.x, followPlayerID.y, x, y);
var _l = camera_get_view_x(view_camera[0]);
var _t = camera_get_view_y(view_camera[0]);
var _r = camera_get_view_x(view_camera[0]) + 640;
var _b = camera_get_view_y(view_camera[0]) + 360;
var _edge_x = 300;
var _edge_y = 160;
var _view_center_x = (_l + _r) / 2;
var _view_center_y = (_t + _b) / 2;
if (!isInView)
{
    var _x1 = x - _view_center_x;
    var _y1 = y - _view_center_y;
    var _x2, _y2;
    if (abs(_x1 / _edge_x) > abs(_y1 / _edge_y))
    {
        _x2 = sign(_x1) * _edge_x;
        _y2 = (_x2 / _x1) * _y1;
    }
    else
    {
        _y2 = sign(_y1) * _edge_y;
        _x2 = (_y2 / _y1) * _x1;
    }
    draw_sprite_ext(spr_chestpointer, 0, _view_center_x + _x2, _view_center_y + _y2, 1, 1, arrowDir, c_white, 1);
}
else
{
    draw_sprite_ext(spr_chestpointer, 0, x, y - 90, 1, 1, 270, c_white, 1);
}
gpu_set_blendmode(bm_add);
draw_sprite_ext(spr_ItemLight, 0, x, y, 1, 1, 0, c_white, 0.9);
gpu_set_blendmode(bm_normal);
draw_sprite(spr_holozonBox, 0, x, y);
