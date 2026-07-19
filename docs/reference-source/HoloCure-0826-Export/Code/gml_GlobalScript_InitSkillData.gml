function InitSkillData()
{
    global.SkillData = {};
    variable_struct_set(global.SkillData, "FPSMastery", 
    {
        ATK: [0.2, 0.4, 0.6],
        Haste: 10
    });
    variable_struct_set(global.SkillData, "DetectiveEye", 
    {
        crit: [10, 20, 30],
        KO: 2
    });
    variable_struct_set(global.SkillData, "Bubba", 
    {
        ATK: [1, 2, 3],
        stun: 120
    });
    variable_struct_set(global.SkillData, "ShortHeight", 
    {
        dodgeChance: [15, 25, 35],
        SPD: [0.3, 0.4, 0.5]
    });
    variable_struct_set(global.SkillData, "SharkBite", 
    {
        chance: [10, 15, 20],
        vuln: [6, 9, 12]
    });
    variable_struct_set(global.SkillData, "Death", 
    {
        chance: [20, 25, 30],
        deathChance: [5, 8, 10],
        damage: [0.6, 0.9, 1.2]
    });
    variable_struct_set(global.SkillData, "TheRapper", 
    {
        distance: [100, 125, 150],
        amount: [10, 15, 20],
        crit: 10
    });
    variable_struct_set(global.SkillData, "Workaholic", 
    {
        ATK: [0.02, 0.03, 0.04],
        SPD: 0.02
    });
    variable_struct_set(global.SkillData, "TheVoid", 
    {
        distance: [75, 100, 125],
        SPD: [0.1, 0.15, 0.2],
        damage: [0.5, 0.75, 1]
    });
    variable_struct_set(global.SkillData, "Cult", 
    {
        multiplier: [2, 3, 4]
    });
    variable_struct_set(global.SkillData, "TheAncientOne", 
    {
        chance: [25, 50, 75]
    });
    variable_struct_set(global.SkillData, "Trailblazer", 
    {
        SPD: [0.1, 0.15, 0.2],
        damage: [0.3, 0.5, 0.75]
    });
    variable_struct_set(global.SkillData, "Dancer", 
    {
        ATK: [0.02, 0.03, 0.04]
    });
    variable_struct_set(global.SkillData, "PhoenixShield", 
    {
        stack: [1, 2, 3]
    });
    variable_struct_set(global.SkillData, "HalfAngel", 
    {
        chance: [10, 15, 20],
        heal: [1, 2, 3]
    });
    variable_struct_set(global.SkillData, "HalfDemon", 
    {
        ATK: [0.03, 0.05, 0.07]
    });
    variable_struct_set(global.SkillData, "Hope", 
    {
        crit: [5, 10, 15],
        chance: [10, 15, 20],
        heal: [0.1, 0.15, 0.2]
    });
    variable_struct_set(global.SkillData, "Civilization", 
    {
        ATK: [0.01, 0.015, 0.02],
        ATK2: 0.01,
        History: 100
    });
    variable_struct_set(global.SkillData, "Friend", 
    {
        damage: [0.5, 0.65, 0.8]
    });
    variable_struct_set(global.SkillData, "History", 
    {
        ATK: [0.3, 0.45, 0.6],
        heal: 0.1
    });
    variable_struct_set(global.SkillData, "Perfection", 
    {
        weight: [0.2, 0.33, 0.5],
        weight2: [10, 15, 20]
    });
    variable_struct_set(global.SkillData, "Kroniicopter", 
    {
        haste: [10, 15, 20],
        SPD: [0.1, 0.15, 0.2]
    });
    variable_struct_set(global.SkillData, "LunarConstruction", 
    {
        damage: [3, 4, 5],
        blocks: 5
    });
    variable_struct_set(global.SkillData, "MoonSong", 
    {
        damage: [1, 1.25, 1.5],
        size: [2, 2.35, 2.7]
    });
    variable_struct_set(global.SkillData, "Hoshinova", 
    {
        ATK: [0.2, 0.4, 0.6],
        DEF: [0.85, 0.85, 0.85]
    });
    variable_struct_set(global.SkillData, "Deez", 
    {
        chance: [10, 15, 20],
        damage: 0.25
    });
    variable_struct_set(global.SkillData, "NonstopNuts", 
    {
        chance: [15, 20, 25],
        damage: [0.6, 0.8, 1]
    });
    variable_struct_set(global.SkillData, "DLC", 
    {
        dropChance: [0.2, 0.25, 0.3],
        damage: [0.3, 0.35, 0.4]
    });
    variable_struct_set(global.SkillData, "Erofi", 
    {
        heal: [0.01, 0.02, 0.03],
        distance: 50
    });
    variable_struct_set(global.SkillData, "AlienBrainwashing", 
    {
        timer: 900,
        damage: [2, 3, 4],
        maxTargets: [10, 15, 20],
        crit: 1
    });
    variable_struct_set(global.SkillData, "Polyglot", 
    {
        weight1: [0.25, 0.5, 0.75],
        weight2: [10, 20, 30],
        damage: 2
    });
    variable_struct_set(global.SkillData, "Ninjutsu", 
    {
        damage: [1, 1.5, 2]
    });
    variable_struct_set(global.SkillData, "Undead", 
    {
        cooldown: 10,
        duration: 10,
        weight: [3, 2, 1],
        ATK: 0.02
    });
    variable_struct_set(global.SkillData, "SimpOfAllTime", 
    {
        damage: 5,
        weight: [0.3, 0.4, 0.5]
    });
    variable_struct_set(global.SkillData, "WindMagic", 
    {
        haste: [1, 2, 3],
        chance: [20, 25, 30],
        damage: [1, 1.5, 2]
    });
    variable_struct_set(global.SkillData, "AttentionPlease", 
    {
        crit: [1, 2, 3],
        distance: 150,
        SPD: 10
    });
    variable_struct_set(global.SkillData, "LadyOfPeafowl", 
    {
        maxStacks: [30, 50, 70]
    });
    variable_struct_set(global.SkillData, "LivingWeapon", 
    {
        damage: [0.4, 0.5, 0.6],
        ATK: [0.04, 0.06, 0.08]
    });
    variable_struct_set(global.SkillData, "Slumber", 
    {
        SPD: 0.75,
        heal: [0.09, 0.12, 0.15]
    });
    variable_struct_set(global.SkillData, "CuttingDeep", 
    {
        PUR: [20, 40, 60],
        chance: [15, 20, 25]
    });
    variable_struct_set(global.SkillData, "MaterialGrind", 
    {
        chance: [2, 4, 6]
    });
    variable_struct_set(global.SkillData, "NoPressure", 
    {
        distance: [125, 125, 125],
        size: 2,
        debuff: 0.2,
        damage: [0.75, 1, 1.25]
    });
    variable_struct_set(global.SkillData, "TheBlacksmith", 
    {
        damage: [3, 4, 5],
        chance: [3, 3, 3]
    });
    variable_struct_set(global.SkillData, "SecretAgent", 
    {
        chance: [15, 20, 25],
        multiplier: [0.3, 0.5, 0.7],
        cooldown: 20
    });
    variable_struct_set(global.SkillData, "CatReflexes", 
    {
        crit: [5, 10, 15],
        crit2: 5
    });
    variable_struct_set(global.SkillData, "DataCollection", 
    {
        bonusEXP: [0.5, 0.5, 0.5],
        chance: [15, 20, 25]
    });
    variable_struct_set(global.SkillData, "RainCloud", 
    {
        number: [1, 2, 3],
        damage: [1, 1.2, 1.5]
    });
    variable_struct_set(global.SkillData, "Praise", 
    {
        ATK: [0.3, 0.4, 0.5]
    });
    variable_struct_set(global.SkillData, "Tantrum", 
    {
        heal: 0.1,
        damage: [4, 5, 6]
    });
}
