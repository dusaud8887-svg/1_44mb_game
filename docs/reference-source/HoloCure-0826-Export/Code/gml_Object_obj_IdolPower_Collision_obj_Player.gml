if (!initialSpawn)
{
    amountVal = 30;
    followPlayerID.specialMeter += amountVal;
    soundPlay([253], "idolpower", 15, 0);
    instance_destroy();
}
