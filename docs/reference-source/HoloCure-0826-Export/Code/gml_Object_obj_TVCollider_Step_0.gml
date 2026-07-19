if (collision_rectangle(x - 63, y - 39, x + 63, y + 39, obj_Player, false, true))
{
    watching++;
}
else
{
    watching = 0;
}
if (watching >= 600)
{
    watching = 0;
    DoAchievement("lookImOnTV");
}
