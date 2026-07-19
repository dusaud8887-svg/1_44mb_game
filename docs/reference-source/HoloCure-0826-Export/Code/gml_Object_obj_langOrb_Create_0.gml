player = -1;
depth = -y - 2;
isInView = false;
stat = 0;
level = 1;
image_speed = 0;
buffConfig = 
{
    stat: stat,
    level: level,
    buffIcon: -1
};
destroyTimer = 6000;
SPD = 0;
picked = false;
canGet = false;
originY = y;

function Set()
{
    var buffStat = [2032, 1623, 676, 293, 353];
    image_index = stat;
    buffConfig = 
    {
        reapply: true,
        stat: stat,
        level: level,
        buffIcon: buffStat[stat]
    };
    canGet = true;
}
