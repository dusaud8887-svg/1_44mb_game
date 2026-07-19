event_inherited();

function ChangeColor()
{
    if (expVal >= 200)
    {
        sprite_index = spr_EXP6;
    }
    else if (expVal >= 100)
    {
        sprite_index = spr_EXP5;
    }
    else if (expVal >= 50)
    {
        sprite_index = spr_EXP4;
    }
    else if (expVal >= 20)
    {
        sprite_index = spr_EXP3;
    }
    else if (expVal > 10)
    {
        sprite_index = spr_EXP2;
    }
}

ChangeColor();
