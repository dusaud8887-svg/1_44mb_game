if (room == rm_GrassPlains_Night)
{
    sprite_index = BG_yagoohead_night;
}
event_inherited();
HP = 5 + random(5);
currentHP = HP;
SPD = 0;
ATK = -1;
haste = 0;
breakable = true;
brokenPieces = -1;
foodChance = 75;
moneyChance = 20;
