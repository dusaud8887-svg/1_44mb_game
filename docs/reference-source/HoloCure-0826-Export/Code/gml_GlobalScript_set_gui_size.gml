function set_gui_size(arg0, arg1 = (HEIGHT * arg0) / WIDTH)
{
    display_set_gui_size(arg0, arg1);
    global.width_gui = arg0;
    global.height_gui = arg1;
}
