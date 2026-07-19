if (!initialSpawn)
{
    global.currentRunMoneyGained += (floor((global.moneyMultiplier + other.moneyGain) * amountVal) * global.stageCoinBonus);
    if (global.moneyHeal)
    {
        Heal(227, 3, 1, true, false);
    }
    other.OnPickUp(227, "HoloCoin", true);
    soundPlay([280], "money", 5, 4);
    instance_destroy();
}
