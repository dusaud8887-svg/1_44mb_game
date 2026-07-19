STICKERS = ds_map_create();
ATKUP = [function(arg0)
{
    arg0.damage *= 1.15;
    arg0.effectDamage *= 1.15;
    if (variable_instance_exists(arg0, "baseDamage"))
    {
        arg0.baseDamage *= 1.15;
    }
    if (variable_instance_exists(arg0, "CritMod"))
    {
        arg0.CritMod += 0.05;
    }
    else
    {
        arg0.CritMod = 0.05;
    }
}, function(arg0)
{
    arg0.damage *= 1.2;
    arg0.effectDamage *= 1.2;
    if (variable_instance_exists(arg0, "baseDamage"))
    {
        arg0.baseDamage *= 1.2;
    }
    if (variable_instance_exists(arg0, "CritMod"))
    {
        arg0.CritMod += 0.1;
    }
    else
    {
        arg0.CritMod = 0.1;
    }
}, function(arg0)
{
    arg0.damage *= 1.25;
    arg0.effectDamage *= 1.25;
    if (variable_instance_exists(arg0, "baseDamage"))
    {
        arg0.baseDamage *= 1.25;
    }
    if (variable_instance_exists(arg0, "CritMod"))
    {
        arg0.CritMod += 0.15;
    }
    else
    {
        arg0.CritMod = 0.15;
    }
}];

ATKUPRemove = function(arg0)
{
};

ds_map_set(STICKERS, "ATKUp", new Sticker("ATKUp", 
{
    optionIcon: 1938,
    optionName: global.TextContainer.ATKUPName.selectedLanguage,
    optionDescription: global.TextContainer.ATKUPDescription.selectedLanguage,
    weight: 4
}, ATKUP, ATKUPRemove));
UnitSticker = [function(arg0)
{
    arg0.damage *= 0.7;
    arg0.effectDamage *= 0.7;
    if (variable_instance_exists(arg0, "baseDamage"))
    {
        arg0.baseDamage *= 0.7;
    }
    variable_struct_set(playerCharacter.onHitEffects, "UnitSticker", 
    {
        multiplier: 1.04
    });
}, function(arg0)
{
    arg0.damage *= 0.6;
    arg0.effectDamage *= 0.6;
    if (variable_instance_exists(arg0, "baseDamage"))
    {
        arg0.baseDamage *= 0.6;
    }
    variable_struct_set(playerCharacter.onHitEffects, "UnitSticker", 
    {
        multiplier: 1.06
    });
}, function(arg0)
{
    arg0.damage *= 0.5;
    arg0.effectDamage *= 0.5;
    if (variable_instance_exists(arg0, "baseDamage"))
    {
        arg0.baseDamage *= 0.5;
    }
    variable_struct_set(playerCharacter.onHitEffects, "UnitSticker", 
    {
        multiplier: 1.08
    });
}];

UnitStickerRemove = function(arg0)
{
    variable_struct_remove(playerCharacter.onHitEffects, "UnitSticker");
};

ds_map_set(STICKERS, "UnitSticker", new Sticker("UnitSticker", 
{
    optionIcon: 431,
    optionName: global.TextContainer.UnitStickerName.selectedLanguage,
    optionDescription: global.TextContainer.UnitStickerDescription.selectedLanguage,
    weight: 1
}, UnitSticker, UnitStickerRemove));
LightnessSticker = [function(arg0)
{
    arg0.damage *= 0.8;
    arg0.effectDamage *= 0.8;
    if (variable_instance_exists(arg0, "baseDamage"))
    {
        arg0.baseDamage *= 0.8;
    }
    playerCharacter.SPD += 0.2;
}, function(arg0)
{
    arg0.damage *= 0.8;
    arg0.effectDamage *= 0.8;
    if (variable_instance_exists(arg0, "baseDamage"))
    {
        arg0.baseDamage *= 0.8;
    }
    playerCharacter.SPD += 0.3;
}, function(arg0)
{
    arg0.damage *= 0.8;
    arg0.effectDamage *= 0.8;
    if (variable_instance_exists(arg0, "baseDamage"))
    {
        arg0.baseDamage *= 0.8;
    }
    playerCharacter.SPD += 0.4;
}];

LightnessStickerRemove = function(arg0)
{
};

ds_map_set(STICKERS, "LightnessSticker", new Sticker("LightnessSticker", 
{
    optionIcon: 1379,
    optionName: global.TextContainer.LightnessStickerName.selectedLanguage,
    optionDescription: global.TextContainer.LightnessStickerDescription.selectedLanguage,
    weight: 3
}, LightnessSticker, LightnessStickerRemove));
KnockbackSticker = [function(arg0)
{
    if (arg0.knockback != false)
    {
        arg0.knockback.duration = floor(arg0.knockback.duration * 1.3);
        arg0.knockback.speed = floor(arg0.knockback.speed * 1.3);
    }
    else
    {
        arg0.knockback = 
        {
            duration: 5,
            speed: 5
        };
    }
}, function(arg0)
{
    if (arg0.knockback != false)
    {
        arg0.knockback.duration = floor(arg0.knockback.duration * 1.5);
        arg0.knockback.speed = floor(arg0.knockback.speed * 1.5);
    }
    else
    {
        arg0.knockback = 
        {
            duration: 8,
            speed: 8
        };
    }
}, function(arg0)
{
    if (arg0.knockback != false)
    {
        arg0.knockback.duration = floor(arg0.knockback.duration * 2);
        arg0.knockback.speed = floor(arg0.knockback.speed * 2);
    }
    else
    {
        arg0.knockback = 
        {
            duration: 12,
            speed: 12
        };
    }
}];
ds_map_set(STICKERS, "KnockbackSticker", new Sticker("KnockbackSticker", 
{
    optionIcon: 839,
    optionName: global.TextContainer.KnockbackStickerName.selectedLanguage,
    optionDescription: global.TextContainer.KnockbackStickerDescription.selectedLanguage,
    weight: 3
}, KnockbackSticker));

DetermineOrientation = function(arg0)
{
    switch (arg0.projOrientation)
    {
        case "none":
            exit;
            break;
        case "circle":
            arg0.stepDirection = 360 / arg0.attackCount;
            exit;
            break;
        case "frontSpread":
            arg0.startDirection = -((arg0.stepDirection / 2) * (arg0.attackCount - 1));
            break;
    }
};

ProjUp = [function(arg0)
{
    if (arg0.weaponType == "MultiShot")
    {
        arg0.attackCount += 1;
        arg0.splitCount = arg0.attackCount;
        DetermineOrientation(arg0);
    }
}, function(arg0)
{
    if (arg0.weaponType == "MultiShot")
    {
        arg0.attackCount += 2;
        arg0.splitCount = arg0.attackCount;
        DetermineOrientation(arg0);
    }
}];

ProjRemove = function(arg0)
{
};

ds_map_set(STICKERS, "ProjUp", new Sticker("ProjUp", 
{
    optionIcon: 2128,
    optionName: global.TextContainer.ProjUpName.selectedLanguage,
    optionDescription: global.TextContainer.ProjUpDescription.selectedLanguage,
    weight: 1
}, ProjUp, ProjRemove, 2));
SizeUp = [function(arg0)
{
    arg0.image_xscale *= 1.15;
    arg0.image_yscale *= 1.15;
    if (variable_instance_exists(arg0, "radius"))
    {
        arg0.radius *= 1.15;
    }
    if (variable_instance_exists(arg0, "baseSize"))
    {
        arg0.baseSize *= 1.15;
    }
}, function(arg0)
{
    arg0.image_xscale *= 1.2;
    arg0.image_yscale *= 1.2;
    if (variable_instance_exists(arg0, "radius"))
    {
        arg0.radius *= 1.2;
    }
    if (variable_instance_exists(arg0, "baseSize"))
    {
        arg0.baseSize *= 1.2;
    }
}, function(arg0)
{
    arg0.image_xscale *= 1.25;
    arg0.image_yscale *= 1.25;
    if (variable_instance_exists(arg0, "radius"))
    {
        arg0.radius *= 1.25;
    }
    if (variable_instance_exists(arg0, "baseSize"))
    {
        arg0.baseSize *= 1.25;
    }
}];

SizeUpRemove = function(arg0)
{
};

ds_map_set(STICKERS, "SizeUp", new Sticker("SizeUp", 
{
    optionIcon: 967,
    optionName: global.TextContainer.SizeUpName.selectedLanguage,
    optionDescription: global.TextContainer.SizeUpDescription.selectedLanguage,
    weight: 4
}, SizeUp, SizeUpRemove));
HasteUp = [function(arg0)
{
    arg0.attackTime = floor(arg0.attackTime * 0.85);
}, function(arg0)
{
    arg0.attackTime = floor(arg0.attackTime * 0.8);
}, function(arg0)
{
    arg0.attackTime = floor(arg0.attackTime * 0.75);
}];

HasteUpRemove = function(arg0)
{
};

ds_map_set(STICKERS, "HasteUp", new Sticker("HasteUp", 
{
    optionIcon: 1644,
    optionName: global.TextContainer.HasteUpName.selectedLanguage,
    optionDescription: global.TextContainer.HasteUpDescription.selectedLanguage,
    weight: 2
}, HasteUp, HasteUpRemove));
CritUp = [function(arg0)
{
    arg0.bonusCrit += 10;
}, function(arg0)
{
    arg0.bonusCrit += 20;
}, function(arg0)
{
    arg0.bonusCrit += 30;
}];

CritUpRemove = function(arg0)
{
};

ds_map_set(STICKERS, "CritUp", new Sticker("CritUp", 
{
    optionIcon: 1233,
    optionName: global.TextContainer.CritUpName.selectedLanguage,
    optionDescription: global.TextContainer.CritUpDescription.selectedLanguage,
    weight: 2
}, CritUp, CritUpRemove));
StunSticker = [function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "Stun", 
    {
        chance: 10,
        freezeTime: 60
    });
    arg0.eraseAttacks = true;
    arg0.eraseChance = 20;
}, function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "Stun", 
    {
        chance: 20,
        freezeTime: 60
    });
    arg0.eraseAttacks = true;
    arg0.eraseChance = 30;
}, function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "Stun", 
    {
        chance: 30,
        freezeTime: 60
    });
    arg0.eraseAttacks = true;
    arg0.eraseChance = 40;
}];

StunStickerRemove = function(arg0)
{
    if (variable_struct_exists(arg0.onHitEffects, "Stun"))
    {
        variable_struct_remove(arg0.onHitEffects, "Stun");
    }
};

ds_map_set(STICKERS, "StunSticker", new Sticker("StunSticker", 
{
    optionIcon: 1095,
    optionName: global.TextContainer.StunStickerName.selectedLanguage,
    optionDescription: global.TextContainer.StunStickerDescription.selectedLanguage,
    weight: 2
}, StunSticker, StunStickerRemove));
LifeStealSticker = [function(arg0)
{
    playerCharacter.scripts.LifeStealSticker = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 60
        }
    };
    variable_struct_set(arg0.onHitEffects, "LifeStealSticker", 
    {
        chance: 15,
        heal: 0.05
    });
}, function(arg0)
{
    playerCharacter.scripts.LifeStealSticker = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 60
        }
    };
    variable_struct_set(arg0.onHitEffects, "LifeStealSticker", 
    {
        chance: 15,
        heal: 0.1
    });
}, function(arg0)
{
    playerCharacter.scripts.LifeStealSticker = 
    {
        Script: function(arg0, arg1)
        {
            var timer;
            if (arg1.timer > 0)
            {
                arg1.timer--;
            }
        },
        
        config: 
        {
            timer: 0,
            maxTimer: 60
        }
    };
    variable_struct_set(arg0.onHitEffects, "LifeStealSticker", 
    {
        chance: 15,
        heal: 0.15
    });
}];

LifeStealStickerRemove = function(arg0)
{
    if (variable_struct_exists(arg0.onHitEffects, "LifeStealSticker"))
    {
        variable_struct_remove(arg0.onHitEffects, "LifeStealSticker");
        variable_struct_remove(arg0.StampVars, "lifeStolen");
    }
};

ds_map_set(STICKERS, "LifeStealSticker", new Sticker("LifeStealSticker", 
{
    optionIcon: 1297,
    optionName: global.TextContainer.LifeStealStickerName.selectedLanguage,
    optionDescription: global.TextContainer.LifeStealStickerDescription.selectedLanguage,
    weight: 1
}, LifeStealSticker, LifeStealStickerRemove));
SlowDownSticker = [function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "SlowDownSticker", 
    {
        chance: 20,
        amount: 0.15,
        mult: 0.3
    });
}, function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "SlowDownSticker", 
    {
        chance: 25,
        amount: 0.2,
        mult: 0.4
    });
}, function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "SlowDownSticker", 
    {
        chance: 30,
        amount: 0.25,
        mult: 0.5
    });
}];

SlowDownStickerRemove = function(arg0)
{
    if (variable_struct_exists(arg0.onHitEffects, "SlowDownSticker"))
    {
        variable_struct_remove(arg0.onHitEffects, "SlowDownSticker");
    }
};

ds_map_set(STICKERS, "SlowDownSticker", new Sticker("SlowDownSticker", 
{
    optionIcon: 1333,
    optionName: global.TextContainer.SlowDownStickerName.selectedLanguage,
    optionDescription: global.TextContainer.SlowDownStickerDescription.selectedLanguage,
    weight: 4
}, SlowDownSticker, SlowDownStickerRemove));
WeakenSticker = [function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "WeakenSticker", 
    {
        chance: 20,
        amount: 0.2,
        amount2: 5
    });
}, function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "WeakenSticker", 
    {
        chance: 25,
        amount: 0.25,
        amount2: 7
    });
}, function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "WeakenSticker", 
    {
        chance: 30,
        amount: 0.3,
        amount2: 10
    });
}];

WeakenStickerRemove = function(arg0)
{
    if (variable_struct_exists(arg0.onHitEffects, "WeakenSticker"))
    {
        variable_struct_remove(arg0.onHitEffects, "WeakenSticker");
    }
};

ds_map_set(STICKERS, "WeakenSticker", new Sticker("WeakenSticker", 
{
    optionIcon: 1863,
    optionName: global.TextContainer.WeakenStickerName.selectedLanguage,
    optionDescription: global.TextContainer.WeakenStickerDescription.selectedLanguage,
    weight: 4
}, WeakenSticker, WeakenStickerRemove));
GreedSticker = [function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "GreedSticker", 
    {
        chance: 3
    });
}, function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "GreedSticker", 
    {
        chance: 4
    });
}, function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "GreedSticker", 
    {
        chance: 5
    });
}];

GreedStickerRemove = function(arg0)
{
    if (variable_struct_exists(arg0.onHitEffects, "GreedSticker"))
    {
        variable_struct_remove(arg0.onHitEffects, "GreedSticker");
    }
};

ds_map_set(STICKERS, "GreedSticker", new Sticker("GreedSticker", 
{
    optionIcon: 28,
    optionName: global.TextContainer.GreedStickerName.selectedLanguage,
    optionDescription: global.TextContainer.GreedStickerDescription.selectedLanguage,
    weight: 4
}, GreedSticker, GreedStickerRemove));
ColdSticker = [function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "ColdSticker", 
    {
        mult: 0.5,
        chance: 25,
        resist: 300
    });
}, function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "ColdSticker", 
    {
        mult: 0.6,
        chance: 25,
        resist: 300
    });
}, function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "ColdSticker", 
    {
        mult: 0.7,
        chance: 25,
        resist: 300
    });
}];

ColdStickerRemove = function(arg0)
{
    if (variable_struct_exists(arg0.onHitEffects, "ColdSticker"))
    {
        variable_struct_remove(arg0.onHitEffects, "ColdSticker");
    }
};

ds_map_set(STICKERS, "ColdSticker", new Sticker("ColdSticker", 
{
    optionIcon: 881,
    optionName: global.TextContainer.ColdStickerName.selectedLanguage,
    optionDescription: global.TextContainer.ColdStickerDescription.selectedLanguage,
    weight: 3
}, ColdSticker, ColdStickerRemove));
BombSticker = [function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "BombSticker", 
    {
        chance: 10
    });
    if (instance_exists(obj_Player) && !variable_struct_exists(obj_Player.scripts, "BombSticker"))
    {
        obj_Player.scripts.BombSticker = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 3
            }
        };
    }
}, function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "BombSticker", 
    {
        chance: 20
    });
    if (instance_exists(obj_Player) && !variable_struct_exists(obj_Player.scripts, "BombSticker"))
    {
        obj_Player.scripts.BombSticker = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 3
            }
        };
    }
}, function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "BombSticker", 
    {
        chance: 30
    });
    if (instance_exists(obj_Player) && !variable_struct_exists(obj_Player.scripts, "BombSticker"))
    {
        obj_Player.scripts.BombSticker = 
        {
            Script: function(arg0, arg1)
            {
                var timer;
                if (arg1.timer > 0)
                {
                    arg1.timer--;
                }
            },
            
            config: 
            {
                timer: 0,
                maxTimer: 3
            }
        };
    }
}];

BombStickerRemove = function(arg0)
{
    if (variable_struct_exists(arg0.onHitEffects, "BombSticker"))
    {
        variable_struct_remove(arg0.onHitEffects, "BombSticker");
    }
};

ds_map_set(STICKERS, "BombSticker", new Sticker("BombSticker", 
{
    optionIcon: 1831,
    optionName: global.TextContainer.BombStickerName.selectedLanguage,
    optionDescription: global.TextContainer.BombStickerDescription.selectedLanguage,
    weight: 3
}, BombSticker, BombStickerRemove));
SoloSticker = [function(arg0)
{
    var emptySlots = 6 - numberOfOwnedWeapons;
    arg0.damage = arg0.damage + (arg0.damage * (0.05 * emptySlots));
    if (variable_instance_exists(arg0, "baseDamage"))
    {
        arg0.baseDamage = arg0.baseDamage + (arg0.baseDamage * (0.05 * emptySlots));
    }
    arg0.effectDamage = arg0.effectDamage + (arg0.effectDamage * 0.05 * emptySlots);
}, function(arg0)
{
    var emptySlots = 6 - numberOfOwnedWeapons;
    arg0.damage = arg0.damage + (arg0.damage * (0.1 * emptySlots));
    if (variable_instance_exists(arg0, "baseDamage"))
    {
        arg0.baseDamage = arg0.baseDamage + (arg0.baseDamage * (0.1 * emptySlots));
    }
    arg0.effectDamage = arg0.effectDamage + (arg0.effectDamage * 0.1 * emptySlots);
}, function(arg0)
{
    var emptySlots = 6 - numberOfOwnedWeapons;
    arg0.damage = arg0.damage + (arg0.damage * (0.15 * emptySlots));
    if (variable_instance_exists(arg0, "baseDamage"))
    {
        arg0.baseDamage = arg0.baseDamage + (arg0.baseDamage * (0.15 * emptySlots));
    }
    arg0.effectDamage = arg0.effectDamage + (arg0.effectDamage * 0.15 * emptySlots);
}];

SoloStickerRemove = function(arg0)
{
};

ds_map_set(STICKERS, "SoloSticker", new Sticker("SoloSticker", 
{
    optionIcon: 1326,
    optionName: global.TextContainer.SoloStickerName.selectedLanguage,
    optionDescription: global.TextContainer.SoloStickerDescription.selectedLanguage,
    weight: 3 + ds_map_find_value(global.PlayerSave, "weaponLimit")
}, SoloSticker, SoloStickerRemove));
CopySticker = [function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "CopySticker", {});
    if (instance_exists(obj_Player) && !variable_struct_exists(obj_Player.scripts, "CopySticker"))
    {
        obj_Player.scripts.CopySticker = 
        {
            Script: function(arg0, arg1)
            {
                if (arg1.currentTarget != -1 && instance_exists(arg1.currentTarget) && arg1.currentTarget.isEnemy)
                {
                }
                else
                {
                    arg1.currentTarget = -1;
                }
            },
            
            config: 
            {
                currentTarget: -1,
                damage: 0.2
            }
        };
        
        obj_Player.customDrawScriptAbove.CopySticker = function(arg0)
        {
            if (obj_Player.scripts.CopySticker.config.currentTarget != -1)
            {
                if (instance_exists(obj_Player.scripts.CopySticker.config.currentTarget))
                {
                    draw_sprite_ext(spr_FocusTarget, 0, obj_Player.scripts.CopySticker.config.currentTarget.x, obj_Player.scripts.CopySticker.config.currentTarget.y - 16, obj_Player.scripts.CopySticker.config.currentTarget.image_xscale, obj_Player.scripts.CopySticker.config.currentTarget.image_yscale, 0, c_white, 0.8);
                }
            }
        };
    }
}, function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "CopySticker", {});
    if (instance_exists(obj_Player) && !variable_struct_exists(obj_Player.scripts, "CopySticker"))
    {
        obj_Player.scripts.CopySticker = 
        {
            Script: function(arg0, arg1)
            {
                if (instance_exists(arg1.currentTarget))
                {
                }
                else
                {
                    arg1.currentTarget = -1;
                }
            },
            
            config: 
            {
                currentTarget: -1,
                damage: 0.3
            }
        };
        
        obj_Player.customDrawScriptAbove.CopySticker = function(arg0)
        {
            if (obj_Player.scripts.CopySticker.config.currentTarget != -1)
            {
                if (instance_exists(obj_Player.scripts.CopySticker.config.currentTarget))
                {
                    draw_sprite_ext(spr_FocusTarget, 0, obj_Player.scripts.CopySticker.config.currentTarget.x, obj_Player.scripts.CopySticker.config.currentTarget.y - 16, obj_Player.scripts.CopySticker.config.currentTarget.image_xscale, obj_Player.scripts.CopySticker.config.currentTarget.image_yscale, 0, c_white, 0.8);
                }
            }
        };
    }
    obj_Player.scripts.CopySticker.config.damage = 0.3;
}, function(arg0)
{
    variable_struct_set(arg0.onHitEffects, "CopySticker", {});
    if (instance_exists(obj_Player) && !variable_struct_exists(obj_Player.scripts, "CopySticker"))
    {
        obj_Player.scripts.CopySticker = 
        {
            Script: function(arg0, arg1)
            {
                if (instance_exists(arg1.currentTarget))
                {
                }
                else
                {
                    arg1.currentTarget = -1;
                }
            },
            
            config: 
            {
                currentTarget: -1,
                damage: 0.4
            }
        };
        
        obj_Player.customDrawScriptAbove.CopySticker = function(arg0)
        {
            if (obj_Player.scripts.CopySticker.config.currentTarget != -1)
            {
                if (instance_exists(obj_Player.scripts.CopySticker.config.currentTarget))
                {
                    draw_sprite_ext(spr_FocusTarget, 0, obj_Player.scripts.CopySticker.config.currentTarget.x, obj_Player.scripts.CopySticker.config.currentTarget.y - 16, obj_Player.scripts.CopySticker.config.currentTarget.image_xscale, obj_Player.scripts.CopySticker.config.currentTarget.image_yscale, 0, c_white, 0.8);
                }
            }
        };
    }
    obj_Player.scripts.CopySticker.config.damage = 0.4;
}];

CopyStickerRemove = function(arg0)
{
};

ds_map_set(STICKERS, "CopySticker", new Sticker("CopySticker", 
{
    optionIcon: 130,
    optionName: global.TextContainer.CopyStickerName.selectedLanguage,
    optionDescription: global.TextContainer.CopyStickerDescription.selectedLanguage,
    weight: 3 + ds_map_find_value(global.PlayerSave, "weaponLimit")
}, CopySticker, CopyStickerRemove));
RainbowSticker = [function(arg0)
{
    arg0.afterImageColor = [255, make_color_rgb(217, 48, 101), 4235519, 65535, 32768, 16711680];
    arg0.afterImageSequence = 0;
}, function(arg0)
{
    arg0.afterImageColor = [255, make_color_rgb(217, 48, 101), 4235519, 65535, 32768, 16711680];
    arg0.afterImageSequence = 0;
}, function(arg0)
{
    arg0.afterImageColor = [255, make_color_rgb(217, 48, 101), 4235519, 65535, 32768, 16711680];
    arg0.afterImageSequence = 0;
}];

RainbowStickerRemove = function(arg0)
{
    arg0.afterImageColor = false;
};

ds_map_set(STICKERS, "RainbowSticker", new Sticker("RainbowSticker", 
{
    optionIcon: 247,
    optionName: global.TextContainer.RainbowStickerName.selectedLanguage,
    optionDescription: global.TextContainer.RainbowStickerDescription.selectedLanguage,
    weight: 2
}, RainbowSticker, RainbowStickerRemove));
TrumpetSticker = [function(arg0)
{
    arg0.originalSound = [arg0.playSound, arg0.soundPitch, arg0.soundCD, arg0.soundChannel];
    if (global.charSelected.id == "kaela")
    {
        arg0.playSound = [40, 129];
    }
    else
    {
        arg0.playSound = [3, 278, 157];
    }
    arg0.soundPitch = true;
    arg0.soundCD = 8;
    arg0.soundChannel = "trumpet";
}, function(arg0)
{
    arg0.originalSound = [arg0.playSound, arg0.soundPitch, arg0.soundCD, arg0.soundChannel];
    if (global.charSelected.id == "kaela")
    {
        arg0.playSound = [185, 191];
    }
    else
    {
        arg0.playSound = [219, 167, 118];
    }
    arg0.soundPitch = true;
    arg0.soundCD = 6;
    arg0.soundChannel = "trumpet";
}, function(arg0)
{
    arg0.originalSound = [arg0.playSound, arg0.soundPitch, arg0.soundCD, arg0.soundChannel];
    if (global.charSelected.id == "kaela")
    {
        arg0.playSound = [221, 172];
    }
    else
    {
        arg0.playSound = [286, 215, 32];
    }
    arg0.soundPitch = true;
    arg0.soundCD = 4;
    arg0.soundChannel = "trumpet";
}];

TrumpetStickerRemove = function(arg0)
{
    arg0.playSound = arg0.originalSound[0];
    arg0.soundPitch = arg0.originalSound[1];
    arg0.soundCD = arg0.originalSound[2];
    arg0.soundChannel = arg0.originalSound[3];
};

ds_map_set(STICKERS, "TrumpetSticker", new Sticker("TrumpetSticker", 
{
    optionIcon: 427,
    optionName: global.TextContainer.TrumpetStickerName.selectedLanguage,
    optionDescription: global.TextContainer.TrumpetStickerDescription.selectedLanguage,
    weight: 2
}, TrumpetSticker, TrumpetStickerRemove));
ReverseSticker = [function(arg0)
{
    arg0.reverse = 180;
}, function(arg0)
{
    arg0.reverse = 0;
}, function(arg0)
{
    arg0.reverse = 180;
}];

ReverseStickerRemove = function(arg0)
{
};

ds_map_set(STICKERS, "ReverseSticker", new Sticker("ReverseSticker", 
{
    optionIcon: 906,
    optionName: global.TextContainer.ReverseStickerName.selectedLanguage,
    optionDescription: global.TextContainer.ReverseStickerDescription.selectedLanguage,
    weight: 3
}, ReverseSticker, ReverseStickerRemove));
