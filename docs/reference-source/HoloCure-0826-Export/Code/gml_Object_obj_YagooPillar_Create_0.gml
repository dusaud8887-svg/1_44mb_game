if (room == rm_GrassPlains_Night)
{
    sprite_index = BG_yagoohead_night;
}
if (room == rm_HoloOffice_SunSet)
{
    sprite_index = BG_yagoohead_sunset;
}
event_inherited();
meshJson = "[[-13,-4],[-5,-2],[6,-2],[12,-3],[14,-6],[11,-8],[11,-23],[-10,-23],[-10,-8],[-13,-7]]";
shadowStrength = 0.3;
clones = false;
event_inherited();
HP = 5 + random(5);
currentHP = HP;
SPD = 0;
ATK = -1;
haste = 0;
breakable = true;
brokenPieces = 1548;
foodChance = 99;
