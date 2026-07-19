x = followTarget.x;
y = followTarget.y;
depth = followTarget.depth + 200;
if (time > 0)
{
    time--;
}
else
{
    instance_destroy();
}
