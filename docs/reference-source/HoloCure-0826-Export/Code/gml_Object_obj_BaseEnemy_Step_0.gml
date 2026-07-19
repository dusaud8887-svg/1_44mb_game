event_inherited();
if (lifeTime > 0)
{
    lifeTime--;
}
if (lifeTime == 0)
{
    instance_destroy();
    var ghost = instance_create_depth(x, y, depth - 1, obj_EnemyDead);
    ghost.sprite_index = sprite_index;
    ghost.image_index = image_index;
    ghost.image_speed = 0;
    ghost.moving = false;
    ghost.image_xscale = image_xscale;
    ghost.image_yscale = image_yscale;
    isDead = true;
}
if (!isDead)
{
    obj_MobManager.MoveToPosition(227, self);
}
depth = -y;
if (hitCDTimer > 0)
{
    hitCDTimer--;
}
