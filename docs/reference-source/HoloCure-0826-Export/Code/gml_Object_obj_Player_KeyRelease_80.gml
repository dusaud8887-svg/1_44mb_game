if (charName == global.TextContainer.ameName.selectedLanguage && instance_exists(obj_Summon))
{
    var pet = instance_find(obj_Summon, 0);
    if (distance_to_object(pet) < 50)
    {
        petting = false;
        stopAttacks = false;
        sprite_index = idleSprite;
        pet.stopAttacks = false;
        pet.sprite_index = spr_Ame_bubba;
        global.new_camera_scale = 1;
    }
}
