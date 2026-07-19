if ((!isMoving && charName == global.TextContainer.ameName.selectedLanguage) && instance_exists(obj_Summon))
{
    var pet = instance_find(obj_Summon, 0);
    if (distance_to_object(pet) < 50)
    {
        stopAttacks = true;
        petting = true;
        sprite_index = sprite3;
        pet.stopAttacks = true;
        pet.sprite_index = spr_Ame_bubbaPet;
        pet.speed = 0;
        pet.y = y;
        pet.x = x + (20 * image_xscale);
        pet.image_xscale = -image_xscale;
        global.new_camera_scale = 2;
        DoAchievement("petDog");
    }
}
