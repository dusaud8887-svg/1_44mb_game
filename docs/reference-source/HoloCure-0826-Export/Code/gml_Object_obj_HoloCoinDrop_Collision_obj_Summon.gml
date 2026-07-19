if (!initialSpawn && obj_Summon.pickupExp)
{
    global.currentRunMoneyGained += ((global.moneyMultiplier + obj_Player.moneyGain) * amountVal * global.stageCoinBonus);
    if (global.moneyHeal)
    {
        Heal(227, 3, 1, true, false);
    }
    obj_Player.OnPickUp(227, "HoloCoin", true);
    soundPlay([280], "money", 5, 4);
    instance_destroy();
}
