player = -1;
depth = -y - 2;
isInView = false;
pickable = false;
level = 0;
buffConfig = {};
SPD = 0;
picked = false;

function Set(arg0)
{
    pickable = true;
    level = arg0;
    buffConfig = 
    {
        buffIcon: 746,
        weight: 0.3 + (level * 0.1)
    };
}
