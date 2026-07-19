function draw_text_scribble_ext(arg0, arg1, arg2, arg3, arg4 = 15, arg5 = undefined, arg6 = 1)
{
    var _font = draw_get_font();
    _font = !font_exists(_font) ? global.__scribble_default_font : font_get_name(_font);
    var _element = scribble(arg2).origin(0, 1).line_spacing(arg4).align(draw_get_halign(), draw_get_valign()).starting_format(_font, 16777215).blend(draw_get_color(), arg6).wrap(arg3);
    if (arg5 != undefined)
    {
        _element.reveal(arg5);
    }
    _element.draw(arg0, arg1);
    return _element;
}
