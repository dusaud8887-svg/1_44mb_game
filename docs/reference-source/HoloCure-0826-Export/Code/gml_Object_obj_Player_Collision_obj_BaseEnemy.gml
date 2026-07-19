if (other.hitCDTimer <= 0 && isAlive)
{
    var dmgObj = obj_AttackController.CalculateDamage(self, other, 
    {
        damage: 0
    });
    var damage = dmgObj[0];
    TakeDamage(damage, other);
    other.hitCDTimer = other.hitCD;
}
