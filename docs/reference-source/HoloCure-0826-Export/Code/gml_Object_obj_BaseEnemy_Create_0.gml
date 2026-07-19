event_inherited();
directionMoving = direction;
isDead = false;

function DropExp()
{
    if (expvalue > 0)
    {
        var dropexp = instance_create_depth(x, y - 20, depth, obj_PreCreate);
        dropexp.expVal = expvalue;
        dropexp.direction = floor(random(360));
        dropexp.speed = 2 + random(3);
        with (dropexp)
        {
            instance_change(obj_EXP, true);
        }
    }
    var rand = random(500);
    if (rand < 1)
    {
        instance_create_depth(x, y - 20, depth, obj_Hamburger);
    }
    rand = random(50);
    if (rand < 1)
    {
        var money = instance_create_depth(x, y - 20, depth, obj_HoloCoinDrop);
        money.amountVal = 5;
    }
}

function Die()
{
    DropExp();
    instance_destroy();
    global.enemyDefeated++;
    var ghost = instance_create_depth(x, y, depth - 1, obj_EnemyDead);
    ghost.sprite_index = sprite_index;
    ghost.image_index = image_index;
    ghost.image_speed = 0;
    ghost.image_xscale = image_xscale;
    ghost.image_yscale = image_yscale;
    instance_create_depth(x, y - 20, depth - 50, obj_saved);
    isDead = true;
}
