if (collision_rectangle(x - 100, y - 100, x + 100, y + 100, obj_Player, false, true))
{
    watching++;
}
else
{
    watching = 0;
}
if (watching >= 1)
{
    watching = 0;
    DoAchievement("huh");
}
