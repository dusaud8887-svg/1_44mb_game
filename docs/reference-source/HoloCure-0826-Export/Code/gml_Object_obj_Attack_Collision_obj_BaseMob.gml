if (variable_instance_exists(self, "ignoreTarget"))
{
    if (other != ignoreTarget)
    {
        OnCollideWithTarget(other);
    }
}
else
{
    OnCollideWithTarget(other);
}
