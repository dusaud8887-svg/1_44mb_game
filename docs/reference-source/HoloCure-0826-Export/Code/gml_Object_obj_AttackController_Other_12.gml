Modifier = function(arg0, arg1, arg2) constructor
{
    id = arg0;
    OnApply = arg2;
    optionDescription = variable_struct_exists(arg1, "optionDescription") ? arg1.optionDescription : global.TextContainer.stockTooltip.selectedLanguage;
    optionID = arg0;
    weight = variable_struct_exists(arg1, "weight") ? arg1.weight : 1;
    
    function Apply(arg0)
    {
        if (OnApply != undefined)
        {
            if (typeof(OnApply) == "array")
            {
                self.OnApply(arg0);
            }
            else
            {
                self.OnApply(arg0);
            }
        }
    }
};

if (!variable_global_exists("AttackModifiers"))
{
    MODIFIERS = ds_map_create();
}
else
{
    ds_map_destroy(global.AttackModifiers);
    global.AttackModifiers = -1;
    MODIFIERS = ds_map_create();
}

ATKUP = function(arg0)
{
    arg0.damage *= 1.15;
};

ds_map_set(MODIFIERS, "Damage", new Modifier("Damage", 
{
    optionDescription: global.TextContainer.DamageModDescription.selectedLanguage,
    weight: 5
}, ATKUP));

ATKUP2 = function(arg0)
{
    arg0.damage *= 1.25;
};

ds_map_set(MODIFIERS, "DamagePlus", new Modifier("DamagePlus", 
{
    optionDescription: global.TextContainer.DamagePlusModDescription.selectedLanguage,
    weight: 1
}, ATKUP2));

SizeUP = function(arg0)
{
    arg0.image_xscale *= 1.15;
    arg0.image_yscale *= 1.15;
};

ds_map_set(MODIFIERS, "Size", new Modifier("Size", 
{
    optionDescription: global.TextContainer.SizeModDescription.selectedLanguage,
    weight: 5
}, SizeUP));

CritUP = function(arg0)
{
    if (variable_instance_exists(arg0, "CritMod"))
    {
        arg0.CritMod += 0.1;
    }
    else
    {
        arg0.CritMod = 0.1;
    }
};

ds_map_set(MODIFIERS, "Crit", new Modifier("Crit", 
{
    optionDescription: global.TextContainer.CritModDescription.selectedLanguage,
    weight: 2
}, CritUP));

ProjectileUP = function(arg0)
{
    var attackCount, extraProj;
    if (arg0.weaponType == "MultiShot" && (arg0.attackCount + 1) <= arg0.maxAttackCount)
    {
        var totalArea = arg0.stepDirection * arg0.attackCount;
        arg0.attackCount++;
        arg0.splitCount = arg0.attackCount;
        var steps = totalArea / arg0.attackCount;
        arg0.stepDirection = steps;
        arg0.startDirection = (arg0.attackCount / 2) * arg0.stepDirection;
    }
    else if (arg0.weaponType == "MultiShot")
    {
        if (variable_instance_exists(arg0, "extraProj"))
        {
            arg0.extraProj++;
        }
        else
        {
            arg0.extraProj = 1;
        }
    }
};

ds_map_set(MODIFIERS, "Projectile", new Modifier("Projectile", 
{
    optionDescription: global.TextContainer.ProjectileModDescription.selectedLanguage,
    weight: 1
}, ProjectileUP));

KnockBackUP = function(arg0)
{
    if (arg0.knockback != false)
    {
        arg0.knockback.duration = floor(arg0.knockback.duration * 1.2);
        arg0.knockback.speed = floor(arg0.knockback.speed * 1.2);
    }
    else
    {
        arg0.knockback = 
        {
            duration: 4,
            speed: 4
        };
    }
};

ds_map_set(MODIFIERS, "Knockback", new Modifier("Knockback", 
{
    optionDescription: global.TextContainer.KnockbackModDescription.selectedLanguage,
    weight: 1
}, KnockBackUP));

HasteUP = function(arg0)
{
    arg0.attackTime *= 0.9;
};

ds_map_set(MODIFIERS, "Haste", new Modifier("Haste", 
{
    optionDescription: global.TextContainer.HasteModDescription.selectedLanguage,
    weight: 3
}, HasteUP));

HitRateUp = function(arg0)
{
    arg0.hitCD = max(5, floor(arg0.hitCD * 0.8));
};

ds_map_set(MODIFIERS, "HitRate", new Modifier("HitRate", 
{
    optionDescription: global.TextContainer.HitCDModDescription.selectedLanguage,
    weight: 3
}, HitRateUp));
global.AttackModifiers = MODIFIERS;
