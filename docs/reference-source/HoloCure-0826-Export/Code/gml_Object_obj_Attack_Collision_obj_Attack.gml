if (other.isEnemy != isEnemy && eraseCD == 0)
{
    if (other.eraseAttacks)
    {
        var roll = irandom(99);
        eraseCD = 60;
        if (roll < other.eraseChance)
        {
            instance_destroy();
        }
    }
}
