if (!picked && !initialSpawn)
{
    if (id > other.id)
    {
        expVal += other.expVal;
        ChangeColor();
        with (other)
        {
            instance_destroy();
        }
    }
}
