var roll = irandom(99);
if (roll < 50 && !isFishing && !isWatering)
{
    moving = !moving;
}
roll = irandom(99);
if (roll < 50 && !isFishing)
{
    direction = irandom(359);
}
alarm[0] = 120 + irandom(300);
