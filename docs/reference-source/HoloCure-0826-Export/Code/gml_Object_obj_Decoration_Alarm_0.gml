if (global.lightFX)
{
    if (amIinView)
    {
        if (!instance_exists(obj_StageManager) || (instance_exists(obj_StageManager) && obj_StageManager.enemyAmount < 100))
        {
            var particle = instance_create_depth(x, y - 17, depth - 1, obj_flowerPart);
            particle.direction = 25 + random(35);
            particle.speed = 0.5 + random(1);
            particle.drawCol = particle_color;
        }
    }
}
alarm[0] = 30 + floor(random(30));
