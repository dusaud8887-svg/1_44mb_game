move_towards_point(320, 180, 15);
direction += ranDir;
if (distance_to_point(320, 180) < 10)
{
    instance_destroy();
}
