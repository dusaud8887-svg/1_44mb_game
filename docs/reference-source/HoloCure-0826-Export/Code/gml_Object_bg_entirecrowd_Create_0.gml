for (var i = 0; i < 1500; i++)
{
    var randDir = irandom(359);
    var guy = instance_create_depth(x + (1.25 * lengthdir_x(560 + irandom(250), randDir)), y + lengthdir_y(560 + irandom(250), randDir), depth, bg_crowdguy);
    guy.image_xscale = -1 + (2 * (guy.x < 1250));
}
