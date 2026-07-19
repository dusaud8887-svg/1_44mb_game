if (!initialSpawn)
{
    amountVal = round((followPlayerID.HP * other.foodMultiplier) / 100);
    Heal(followPlayerID, amountVal, 0, true, true);
    instance_destroy();
    global.burgersEaten++;
    if (global.burgersEaten >= 50)
    {
        DoAchievement("50hamburgers");
    }
}
