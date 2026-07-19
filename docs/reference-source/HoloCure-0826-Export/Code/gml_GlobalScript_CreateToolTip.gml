function CreateToolTip(arg0, arg1, arg2)
{
    variable_struct_set(global.TextContainer, arg0 + "Name", arg1);
    variable_struct_set(global.TextContainer, arg0 + "Description", arg2);
}
