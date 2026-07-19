if (followPlayerID != -4)
{
    arrowDir = point_direction(x, y, x, y);
    x = followPlayerID.x;
    y = followPlayerID.y - (15 * followPlayerID.image_yscale);
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
        draw_sprite_ext(sprite_index, 0, _view_center_x + _x2, _view_center_y + _y2, image_xscale, image_yscale, 0, c_white, image_alpha);
    }
    else
    {
        draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_white, image_alpha);
    }
}
