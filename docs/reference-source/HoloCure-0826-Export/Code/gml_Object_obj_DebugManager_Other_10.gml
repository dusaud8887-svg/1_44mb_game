function ShowPlayerStats()
{
    if (!instance_exists(obj_PlayerManager))
    {
        return false;
    }
    var hudcontainer = obj_PlayerManager.hudcontainer;
    if (!instance_exists(obj_Player))
    {
        draw_text_scribble(hudcontainer[0] + 12, hudcontainer[0] + 100, "PLAYER DOESN'T EXIST");
        return false;
    }
    var player = 227;
    draw_text_scribble(hudcontainer[0] + 12, hudcontainer[0] + 90, "PLAYER STATS: ");
    draw_text_scribble(hudcontainer[0] + 12, hudcontainer[0] + 100, "CurrentHP: " + string(player.currentHP));
    draw_text_scribble(hudcontainer[0] + 12, hudcontainer[0] + 110, "HP: " + string(player.HP));
    draw_text_scribble(hudcontainer[0] + 12, hudcontainer[0] + 120, "ATK: " + string(player.ATK));
    draw_text_scribble(hudcontainer[0] + 12, hudcontainer[0] + 130, "crit: " + string(player.crit));
    draw_text_scribble(hudcontainer[0] + 12, hudcontainer[0] + 140, "SPD: " + string(player.SPD));
    draw_text_scribble(hudcontainer[0] + 12, hudcontainer[0] + 150, "haste: " + string(player.haste));
    draw_text_scribble(hudcontainer[0] + 12, hudcontainer[0] + 160, "pickupRange: " + string(player.pickupRange));
    draw_text_scribble(hudcontainer[0] + 12, hudcontainer[0] + 170, "attackCount: " + string(player.attackCount));
    draw_text_scribble(hudcontainer[0] + 12, hudcontainer[0] + 180, "hitLimit: " + string(player.hitLimit));
}

function ShowMonsterSpeed(arg0)
{
    draw_text_scribble(arg0.x, arg0.y, string(arg0.SPD));
}
