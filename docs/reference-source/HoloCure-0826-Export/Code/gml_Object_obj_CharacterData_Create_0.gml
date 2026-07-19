global.damage = 10;
if (variable_global_exists("characterData"))
{
    if (ds_map_size(global.characterData) > 0)
    {
        ds_map_destroy(global.characterData);
        global.characterData = -1;
    }
}
global.characterData = ds_map_create();
ds_map_set(global.characterData, "ame", 
{
    id: "ame",
    charName: global.TextContainer.ameName.selectedLanguage,
    port: 315,
    large_port: 869,
    sprite1: 709,
    sprite2: 606,
    sprite3: 1808,
    HP: 75,
    ATK: 1.3,
    SPD: 1.35,
    crit: 10,
    attackID: "AmePistol",
    attackIcon: 480,
    attack: global.TextContainer.ameAttackName.selectedLanguage,
    attackDesc: global.TextContainer.ameAttackDesc.selectedLanguage,
    specIcon: 2124,
    specID: "AmeTimeTraveler",
    specCD: 60,
    specName: global.TextContainer.ameSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.ameSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        FPSMastery: 0,
        DetectiveEye: 0,
        Bubba: 0
    },
    outfits: 
    {
        ameAlt1: 
        {
            outfitID: "ameAlt1",
            sprites: [
            {
                sprite1: 313,
                sprite2: 1235,
                sprite3: 1849
            }]
        },
        ameAlt2: 
        {
            outfitID: "ameAlt2",
            sprites: [
            {
                sprite1: 1821,
                sprite2: 1646,
                sprite3: 1443
            }]
        },
        ameAlt3: 
        {
            outfitID: "ameAlt3",
            sprites: [
            {
                sprite1: 1075,
                sprite2: 708,
                sprite3: 2122
            }]
        }
    },
    sizeGrade: 2
});
ds_map_set(global.characterData, "gura", 
{
    id: "gura",
    charName: global.TextContainer.guraName.selectedLanguage,
    port: 872,
    large_port: 2161,
    sprite1: 1648,
    sprite2: 1109,
    sprites: [
    {
        sprite1: 1648,
        sprite2: 1109
    }, 
    {
        sprite1: 1865,
        sprite2: 1607
    }],
    HP: 65,
    ATK: 1.1,
    SPD: 1.4,
    crit: 5,
    attackID: "GuraTridentThrust",
    attackIcon: 1595,
    attack: global.TextContainer.guraAttackName.selectedLanguage,
    attackDesc: global.TextContainer.guraAttackDesc.selectedLanguage,
    specIcon: 901,
    specID: "GuraSharkSpecial",
    specCD: 45,
    specName: global.TextContainer.guraSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.guraSpecialAttackDesc.selectedLanguage,
    flat: true,
    sizeGrade: 0,
    perks: 
    {
        ShortHeight: 0,
        PowerOfAtlantis: 0,
        SharkBite: 0
    },
    outfits: 
    {
        guraAlt1: 
        {
            outfitID: "guraAlt1",
            sprites: [
            {
                sprite1: 820,
                sprite2: 2038
            }, 
            {
                sprite1: 542,
                sprite2: 331
            }]
        },
        guraAlt2: 
        {
            outfitID: "guraAlt2",
            sprites: [
            {
                sprite1: 118,
                sprite2: 1237
            }, 
            {
                sprite1: 1110,
                sprite2: 603
            }]
        },
        guraAlt3: 
        {
            outfitID: "guraAlt3",
            sprites: [
            {
                sprite1: 828,
                sprite2: 923
            }, 
            {
                sprite1: 979,
                sprite2: 1087
            }]
        }
    }
});
ds_map_set(global.characterData, "calli", 
{
    id: "calli",
    charName: global.TextContainer.calliName.selectedLanguage,
    port: 2458,
    large_port: 135,
    sprite1: 916,
    sprite2: 256,
    HP: 70,
    ATK: 1.15,
    SPD: 1.3,
    crit: 10,
    attackID: "CalliSlash1",
    attackIcon: 1485,
    attack: global.TextContainer.calliAttackName.selectedLanguage,
    attackDesc: global.TextContainer.calliAttackDesc.selectedLanguage,
    specIcon: 2120,
    specID: "CalliSpecial",
    specCD: 80,
    specName: global.TextContainer.calliSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.calliSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Death: 0,
        TheRapper: 0,
        Workaholic: 0
    },
    sizeGrade: 3,
    outfits: 
    {
        calliAlt1: 
        {
            outfitID: "calliAlt1",
            sprites: [
            {
                sprite1: 2382,
                sprite2: 486
            }]
        },
        calliAlt2: 
        {
            outfitID: "calliAlt2",
            sprites: [
            {
                sprite1: 1155,
                sprite2: 1741
            }]
        },
        calliAlt3: 
        {
            outfitID: "calliAlt3",
            sprites: [
            {
                sprite1: 1480,
                sprite2: 1535
            }]
        }
    }
});
ds_map_set(global.characterData, "ina", 
{
    id: "ina",
    charName: global.TextContainer.inaName.selectedLanguage,
    port: 1323,
    large_port: 1838,
    sprite1: 1528,
    sprite2: 2107,
    HP: 75,
    ATK: 0.9,
    SPD: 1.5,
    crit: 1,
    attackID: "InaTentacle",
    attackIcon: 1813,
    attack: global.TextContainer.inaAttackName.selectedLanguage,
    attackDesc: global.TextContainer.inaAttackDesc.selectedLanguage,
    specIcon: 771,
    specID: "InaSpecial",
    specCD: 60,
    specName: global.TextContainer.inaSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.inaSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        TheVoid: 0,
        Cult: 0,
        TheAncientOne: 0
    },
    flat: true,
    sizeGrade: 0,
    outfits: 
    {
        inaAlt1: 
        {
            outfitID: "inaAlt1",
            sprites: [
            {
                sprite1: 1565,
                sprite2: 404
            }]
        },
        inaAlt2: 
        {
            outfitID: "inaAlt2",
            sprites: [
            {
                sprite1: 1383,
                sprite2: 354
            }]
        },
        inaAlt3: 
        {
            outfitID: "inaAlt3",
            sprites: [
            {
                sprite1: 970,
                sprite2: 1252
            }]
        }
    }
});
ds_map_set(global.characterData, "kiara", 
{
    id: "kiara",
    charName: global.TextContainer.kiaraName.selectedLanguage,
    port: 777,
    large_port: 49,
    sprite1: 2055,
    sprite2: 1784,
    HP: 90,
    ATK: 1,
    SPD: 1.4,
    crit: 5,
    attackID: "KiaraSlash",
    attackIcon: 425,
    attack: global.TextContainer.kiaraAttackName.selectedLanguage,
    attackDesc: global.TextContainer.kiaraAttackDesc.selectedLanguage,
    specIcon: 524,
    specID: "KiaraPhoenix",
    specCD: 60,
    specName: global.TextContainer.kiaraSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.kiaraSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Trailblazer: 0,
        Dancer: 0,
        PhoenixShield: 0
    },
    outfits: 
    {
        kiaraAlt1: 
        {
            outfitID: "kiaraAlt1",
            sprites: [
            {
                sprite1: 783,
                sprite2: 1822
            }]
        },
        kiaraAlt2: 
        {
            outfitID: "kiaraAlt2",
            sprites: [
            {
                sprite1: 1027,
                sprite2: 2338
            }]
        },
        kiaraAlt3: 
        {
            outfitID: "kiaraAlt3",
            sprites: [
            {
                sprite1: 2360,
                sprite2: 549
            }]
        }
    },
    sizeGrade: 2
});
ds_map_set(global.characterData, "irys", 
{
    id: "irys",
    charName: global.TextContainer.irysName.selectedLanguage,
    port: 493,
    large_port: 550,
    sprite1: 2297,
    sprite2: 951,
    HP: 55,
    ATK: 1.1,
    SPD: 1.5,
    crit: 5,
    attackID: "NephilimBlast",
    attackID2: "NephilimBlast2",
    attackIcon: 1028,
    attack: global.TextContainer.irysAttackName.selectedLanguage,
    attackDesc: global.TextContainer.irysAttackDesc.selectedLanguage,
    specIcon: 1464,
    specID: "HopeDescends",
    specCD: 60,
    specName: global.TextContainer.irysSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.irysSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        HalfAngel: 0,
        HalfDemon: 0,
        Hope: 0
    },
    outfits: 
    {
        irysAlt1: 
        {
            outfitID: "irysAlt1",
            sprites: [
            {
                sprite1: 1463,
                sprite2: 1563
            }]
        },
        irysAlt2: 
        {
            outfitID: "irysAlt2",
            sprites: [
            {
                sprite1: 1612,
                sprite2: 504
            }]
        },
        irysAlt3: 
        {
            outfitID: "irysAlt3",
            sprites: [
            {
                sprite1: 582,
                sprite2: 98
            }]
        }
    },
    sizeGrade: 2
});
ds_map_set(global.characterData, "bae", 
{
    id: "bae",
    charName: global.TextContainer.baeName.selectedLanguage,
    port: 2005,
    large_port: 43,
    sprite1: 132,
    sprite2: 2298,
    HP: 60,
    ATK: 1.1,
    SPD: 1.6,
    crit: 10,
    attackID: "PlayDice",
    attackIcon: 187,
    attack: global.TextContainer.baeAttackName.selectedLanguage,
    attackDesc: global.TextContainer.baeAttackDesc.selectedLanguage,
    specIcon: 2071,
    specID: "BaeSpecial",
    specCD: 90,
    specName: global.TextContainer.baeSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.baeSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        CRaticalHit: 0,
        DownUnder: 0,
        RatNG: 0
    },
    outfits: 
    {
        baeAlt1: 
        {
            outfitID: "baeAlt1",
            sprites: [
            {
                sprite1: 865,
                sprite2: 868
            }]
        },
        baeAlt2: 
        {
            outfitID: "baeAlt2",
            sprites: [
            {
                sprite1: 149,
                sprite2: 1469
            }]
        }
    },
    sizeGrade: 1
});
ds_map_set(global.characterData, "kronii", 
{
    id: "kronii",
    charName: global.TextContainer.kroniiName.selectedLanguage,
    port: 618,
    large_port: 199,
    sprite1: 841,
    sprite2: 682,
    HP: 70,
    ATK: 1.2,
    SPD: 1.35,
    crit: 3,
    attackID: "KroniiClock",
    attackIcon: 261,
    attack: global.TextContainer.kroniiAttackName.selectedLanguage,
    attackDesc: global.TextContainer.kroniiAttackDesc.selectedLanguage,
    specIcon: 895,
    specID: "RulerOfTime",
    specCD: 90,
    specName: global.TextContainer.kroniiSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.kroniiSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Perfection: 0,
        Kroniicopter: 0,
        TimeBubble: 0
    },
    outfits: 
    {
        kroniiAlt1: 
        {
            outfitID: "kroniiAlt1",
            sprites: [
            {
                sprite1: 1042,
                sprite2: 1279
            }]
        },
        kroniiAlt2: 
        {
            outfitID: "kroniiAlt2",
            sprites: [
            {
                sprite1: 2389,
                sprite2: 491
            }]
        }
    },
    sizeGrade: 4
});
ds_map_set(global.characterData, "fauna", 
{
    id: "fauna",
    charName: global.TextContainer.faunaName.selectedLanguage,
    port: 1939,
    large_port: 126,
    sprite1: 928,
    sprite2: 616,
    HP: 65,
    ATK: 1,
    SPD: 1.4,
    crit: 3,
    attackID: "FaunaLeaf",
    attackIcon: 1337,
    attack: global.TextContainer.faunaAttackName.selectedLanguage,
    attackDesc: global.TextContainer.faunaAttackDesc.selectedLanguage,
    specIcon: 143,
    specID: "MotherNature",
    specCD: 90,
    specName: global.TextContainer.faunaSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.faunaSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Whisperer: 0,
        Sapling: 0,
        GuardianTree: 0
    },
    outfits: 
    {
        faunaAlt1: 
        {
            outfitID: "faunaAlt1",
            sprites: [
            {
                sprite1: 192,
                sprite2: 1976
            }]
        },
        faunaAlt2: 
        {
            outfitID: "faunaAlt2",
            sprites: [
            {
                sprite1: 2454,
                sprite2: 1700
            }]
        }
    },
    sizeGrade: 2
});
ds_map_set(global.characterData, "mumei", 
{
    id: "mumei",
    charName: global.TextContainer.mumeiName.selectedLanguage,
    port: 494,
    large_port: 607,
    sprite1: 418,
    sprite2: 512,
    HP: 60,
    ATK: 0.8,
    SPD: 1.4,
    crit: 5,
    attackID: "MumeiFeather",
    attackIcon: 830,
    attack: global.TextContainer.mumeiAttackName.selectedLanguage,
    attackDesc: global.TextContainer.mumeiAttackDesc.selectedLanguage,
    specIcon: 2007,
    specID: "MumeiHorror",
    specCD: 80,
    specName: global.TextContainer.mumeiSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.mumeiSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Civilization: 0,
        Friend: 0,
        History: 0
    },
    outfits: 
    {
        mumeiAlt1: 
        {
            outfitID: "mumeiAlt1",
            sprites: [
            {
                sprite1: 2296,
                sprite2: 1088
            }]
        },
        mumeiAlt2: 
        {
            outfitID: "mumeiAlt2",
            sprites: [
            {
                sprite1: 960,
                sprite2: 1858
            }]
        }
    },
    sizeGrade: 1
});
ds_map_set(global.characterData, "sana", 
{
    id: "sana",
    charName: global.TextContainer.sanaName.selectedLanguage,
    port: 825,
    large_port: 290,
    sprite1: 1701,
    sprite2: 1229,
    HP: 80,
    ATK: 0.8,
    SPD: 1.3,
    crit: 1,
    attackID: "SanaPlanet",
    attackIcon: 812,
    attack: global.TextContainer.sanaAttackName.selectedLanguage,
    attackDesc: global.TextContainer.sanaAttackDesc.selectedLanguage,
    specIcon: 1937,
    specID: "GiantSana",
    specCD: 90,
    specName: global.TextContainer.sanaSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.sanaSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        RulerOfSpace: 0,
        Gravity: 0,
        Astrology: 0
    },
    outfits: 
    {
        sanaAlt1: 
        {
            outfitID: "sanaAlt1",
            sprites: [
            {
                sprite1: 1339,
                sprite2: 1761
            }]
        }
    },
    sizeGrade: 4
});
ds_map_set(global.characterData, "fubuki", 
{
    id: "fubuki",
    charName: global.TextContainer.fubukiName.selectedLanguage,
    port: 2239,
    large_port: 482,
    sprite1: 889,
    sprite2: 1124,
    HP: 55,
    ATK: 1,
    SPD: 1.5,
    crit: 5,
    attackID: "FubukiFoxTail",
    attackIcon: 1107,
    attack: global.TextContainer.fubukiAttackName.selectedLanguage,
    attackDesc: global.TextContainer.fubukiAttackDesc.selectedLanguage,
    specIcon: 1600,
    specID: "FubukiStorm",
    specCD: 85,
    specName: global.TextContainer.fubukiSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.fubukiSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        KonKon: 0,
        Friendzone: 0,
        FoxKing: 0
    },
    outfits: 
    {
        kurokami: 
        {
            outfitID: "kurokami",
            sprites: [
            {
                sprite1: 2450,
                sprite2: 1457
            }]
        },
        fubukiAlt1: 
        {
            outfitID: "fubukiAlt1",
            sprites: [
            {
                sprite1: 847,
                sprite2: 1997
            }]
        },
        fubukiAlt2: 
        {
            outfitID: "fubukiAlt2",
            sprites: [
            {
                sprite1: 1239,
                sprite2: 465
            }]
        }
    },
    sizeGrade: 1
});
ds_map_set(global.characterData, "okayu", 
{
    id: "okayu",
    charName: global.TextContainer.okayuName.selectedLanguage,
    port: 704,
    large_port: 696,
    sprite1: 2099,
    sprite2: 1481,
    HP: 60,
    ATK: 0.9,
    SPD: 1.4,
    crit: 5,
    attackID: "OkayuOnigiri",
    attackIcon: 1319,
    attack: global.TextContainer.okayuAttackName.selectedLanguage,
    attackDesc: global.TextContainer.okayuAttackDesc.selectedLanguage,
    specIcon: 1826,
    specID: "MoguMogu",
    specCD: 60,
    specName: global.TextContainer.okayuSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.okayuSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Yummy: 0,
        Feast: 0,
        SensitiveVoice: 0
    },
    outfits: 
    {
        okayuAlt1: 
        {
            outfitID: "okayuAlt1",
            sprites: [
            {
                sprite1: 1188,
                sprite2: 1447
            }]
        },
        okayuAlt2: 
        {
            outfitID: "okayuAlt2",
            sprites: [
            {
                sprite1: 24,
                sprite2: 2276
            }]
        }
    },
    sizeGrade: 2
});
ds_map_set(global.characterData, "korone", 
{
    id: "korone",
    charName: global.TextContainer.koroneName.selectedLanguage,
    port: 1898,
    large_port: 1060,
    sprite1: 1376,
    sprite2: 1953,
    HP: 60,
    ATK: 1.2,
    SPD: 1.4,
    crit: 1,
    attackID: "KoronePunch",
    attackIcon: 1788,
    attack: global.TextContainer.koroneAttackName.selectedLanguage,
    attackDesc: global.TextContainer.koroneAttackDesc.selectedLanguage,
    specIcon: 1285,
    specID: "KoroneYubigeddon",
    specCD: 60,
    specName: global.TextContainer.koroneSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.koroneSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        InugamiEndurance: 0,
        YubiYubi: 0,
        ChocoCoronet: 0
    },
    outfits: 
    {
        koroneAlt1: 
        {
            outfitID: "koroneAlt1",
            sprites: [
            {
                sprite1: 1377,
                sprite2: 2169
            }]
        },
        koroneAlt2: 
        {
            outfitID: "koroneAlt2",
            sprites: [
            {
                sprite1: 639,
                sprite2: 2434
            }]
        }
    },
    sizeGrade: 2
});
ds_map_set(global.characterData, "mio", 
{
    id: "mio",
    charName: global.TextContainer.mioName.selectedLanguage,
    port: 1728,
    large_port: 106,
    sprite1: 2366,
    sprite2: 918,
    HP: 70,
    ATK: 0.85,
    SPD: 1.4,
    crit: 1,
    attackID: "TarotCards",
    attackIcon: 1015,
    attack: global.TextContainer.mioAttackName.selectedLanguage,
    attackDesc: global.TextContainer.mioAttackDesc.selectedLanguage,
    specIcon: 1827,
    specID: "Hatotaurus",
    specCD: 80,
    specName: global.TextContainer.mioSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.mioSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Omen: 0,
        Mama: 0,
        CuteLaugh: 0
    },
    outfits: 
    {
        mioAlt1: 
        {
            outfitID: "mioAlt1",
            sprites: [
            {
                sprite1: 1135,
                sprite2: 1497
            }]
        },
        mioAlt2: 
        {
            outfitID: "mioAlt2",
            sprites: [
            {
                sprite1: 1156,
                sprite2: 827
            }]
        }
    },
    sizeGrade: 2
});
ds_map_set(global.characterData, "sora", 
{
    id: "sora",
    charName: global.TextContainer.soraName.selectedLanguage,
    port: 488,
    large_port: 2294,
    sprite1: 1815,
    sprite2: 2335,
    HP: 65,
    ATK: 1,
    SPD: 1.4,
    crit: 3,
    attackID: "BrightStar",
    attackIcon: 647,
    attack: global.TextContainer.soraAttackName.selectedLanguage,
    attackDesc: global.TextContainer.soraAttackDesc.selectedLanguage,
    specIcon: 1007,
    specID: "IdolDream",
    specCD: 70,
    specName: global.TextContainer.soraSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.soraSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        IdolHealing: 0,
        EnemyThen: 0,
        Ankimo: 0
    },
    outfits: 
    {
        soraAlt1: 
        {
            outfitID: "soraAlt1",
            sprites: [
            {
                sprite1: 1461,
                sprite2: 1593
            }]
        },
        soraAlt2: 
        {
            outfitID: "soraAlt2",
            sprites: [
            {
                sprite1: 1892,
                sprite2: 1152
            }]
        }
    },
    sizeGrade: 1
});
ds_map_set(global.characterData, "azki", 
{
    id: "azki",
    charName: global.TextContainer.azkiName.selectedLanguage,
    port: 1466,
    large_port: 1081,
    sprite1: 114,
    sprite2: 1207,
    HP: 75,
    ATK: 1.1,
    SPD: 1.35,
    crit: 3,
    attackID: "DivaSong",
    attackIcon: 346,
    attack: global.TextContainer.azkiAttackName.selectedLanguage,
    attackDesc: global.TextContainer.azkiAttackDesc.selectedLanguage,
    specIcon: 1099,
    specID: "FullConcert",
    specCD: 80,
    specName: global.TextContainer.azkiSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.azkiSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Performance: 0,
        VirtualDiva: 0,
        Encore: 0
    },
    outfits: 
    {
        azkiAlt1: 
        {
            outfitID: "azkiAlt1",
            sprites: [
            {
                sprite1: 2470,
                sprite2: 1257
            }]
        },
        azkiAlt2: 
        {
            outfitID: "azkiAlt2",
            sprites: [
            {
                sprite1: 422,
                sprite2: 410
            }]
        }
    },
    sizeGrade: 1
});
ds_map_set(global.characterData, "miko", 
{
    id: "miko",
    charName: global.TextContainer.mikoName.selectedLanguage,
    port: 2393,
    large_port: 819,
    sprite1: 1425,
    sprite2: 1220,
    HP: 60,
    ATK: 0.9,
    SPD: 1.4,
    crit: 1,
    attackID: "GOHEI",
    attackIcon: 2177,
    attack: global.TextContainer.mikoAttackName.selectedLanguage,
    attackDesc: global.TextContainer.mikoAttackDesc.selectedLanguage,
    specIcon: 1482,
    specID: "DemonLord",
    specCD: 50,
    specName: global.TextContainer.mikoSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.mikoSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        BabyLanguage: 0,
        ErogeHero: 0,
        Elite: 0
    },
    outfits: 
    {
        mikoAlt1: 
        {
            outfitID: "mikoAlt1",
            sprites: [
            {
                sprite1: 2101,
                sprite2: 1208
            }]
        },
        mikoAlt2: 
        {
            outfitID: "mikoAlt2",
            sprites: [
            {
                sprite1: 1895,
                sprite2: 309
            }]
        }
    },
    sizeGrade: 2
});
ds_map_set(global.characterData, "suisei", 
{
    id: "suisei",
    charName: global.TextContainer.suiseiName.selectedLanguage,
    port: 1085,
    large_port: 1860,
    sprite1: 543,
    sprite2: 1704,
    HP: 70,
    ATK: 1.3,
    SPD: 1.3,
    crit: 10,
    attackID: "AxeSwing",
    attackIcon: 1689,
    attack: global.TextContainer.suiseiAttackName.selectedLanguage,
    attackDesc: global.TextContainer.suiseiAttackDesc.selectedLanguage,
    specIcon: 127,
    specID: "SuiseiSpec",
    specCD: 65,
    specName: global.TextContainer.suiseiSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.suiseiSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Stellar: 0,
        Suicopath: 0,
        MasterOfBlocks: 0
    },
    outfits: 
    {
        suiseiAlt1: 
        {
            outfitID: "suiseiAlt1",
            sprites: [
            {
                sprite1: 1852,
                sprite2: 1916
            }]
        },
        suiseiAlt2: 
        {
            outfitID: "suiseiAlt2",
            sprites: [
            {
                sprite1: 2287,
                sprite2: 1316
            }]
        }
    },
    flat: true,
    sizeGrade: 0
});
ds_map_set(global.characterData, "roboco", 
{
    id: "roboco",
    charName: global.TextContainer.robocoName.selectedLanguage,
    port: 1908,
    large_port: 1640,
    sprite1: 939,
    sprite2: 1766,
    HP: 75,
    ATK: 1,
    SPD: 1.4,
    crit: 5,
    attackID: "RoboShot",
    attackIcon: 72,
    attack: global.TextContainer.robocoAttackName.selectedLanguage,
    attackDesc: global.TextContainer.robocoAttackDesc.selectedLanguage,
    specIcon: 459,
    specID: "HiSpec",
    specCD: 60,
    specName: global.TextContainer.robocoSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.robocoSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Computation: 0,
        HiLevel: 0,
        RoboDischarge: 0
    },
    outfits: 
    {
        robocoAlt1: 
        {
            outfitID: "robocoAlt1",
            sprites: [
            {
                sprite1: 1142,
                sprite2: 1310
            }]
        },
        robocoAlt2: 
        {
            outfitID: "robocoAlt2",
            sprites: [
            {
                sprite1: 2096,
                sprite2: 1334
            }]
        }
    },
    sizeGrade: 2
});

HaachamaCreate = function(arg0)
{
    arg0.haatoMode = 0;
    obj_AttackController.ApplyBuff(arg0, "HaatoMode", ds_map_find_value(obj_AttackController.Buffs, "HaatoMode"), 
    {
        buffIcon: 2144
    });
};

ds_map_set(global.characterData, "haato", 
{
    id: "haato",
    charName: global.TextContainer.haatoName.selectedLanguage,
    port: 1001,
    large_port: 1643,
    sprite1: 2466,
    sprite2: 232,
    HP: 55,
    ATK: 0.9,
    SPD: 1.45,
    crit: 5,
    attackID: "RedHeart",
    attackIcon: 1076,
    attack: global.TextContainer.haatoAttackName.selectedLanguage,
    attackDesc: global.TextContainer.haatoAttackDesc.selectedLanguage,
    specIcon: 2295,
    specID: "ChangeOfHeart",
    specCD: 10,
    specName: global.TextContainer.haatoSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.haatoSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        StrongestIdol: 0,
        PurityAndInsanity: 0,
        Coexistence: 0
    },
    outfits: 
    {
        haatoAlt1: 
        {
            outfitID: "haatoAlt1",
            sprites: [
            {
                sprite1: 302,
                sprite2: 1924
            }]
        }
    },
    onCreate: HaachamaCreate,
    sizeGrade: 3
});
ds_map_set(global.characterData, "mel", 
{
    id: "mel",
    charName: global.TextContainer.melName.selectedLanguage,
    port: 2086,
    large_port: 741,
    sprite1: 1311,
    sprite2: 1910,
    sprites: [
    {
        sprite1: 1311,
        sprite2: 1910
    }, 
    {
        sprite1: 1051,
        sprite2: 2057
    }],
    HP: 75,
    ATK: 1.1,
    SPD: 1.4,
    crit: 2,
    attackID: "KapuKapu",
    attackIcon: 74,
    attack: global.TextContainer.melAttackName.selectedLanguage,
    attackDesc: global.TextContainer.melAttackDesc.selectedLanguage,
    specIcon: 1511,
    specID: "Banpire",
    specCD: 100,
    specName: global.TextContainer.melSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.melSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Vampire: 0,
        AcerolaJuice: 0,
        MelMelCooking: 0
    },
    outfits: 
    {
        melAlt1: 
        {
            outfitID: "melAlt1",
            sprites: [
            {
                sprite1: 489,
                sprite2: 1875
            }, 
            {
                sprite1: 1051,
                sprite2: 2057
            }]
        }
    },
    sizeGrade: 3
});
ds_map_set(global.characterData, "matsuri", 
{
    id: "matsuri",
    charName: global.TextContainer.matsuriName.selectedLanguage,
    port: 810,
    large_port: 1654,
    sprite1: 743,
    sprite2: 2292,
    HP: 60,
    ATK: 1.2,
    SPD: 1.45,
    crit: 1,
    attackID: "Ebifrion",
    attackIcon: 2467,
    attack: global.TextContainer.matsuriAttackName.selectedLanguage,
    attackDesc: global.TextContainer.matsuriAttackDesc.selectedLanguage,
    specIcon: 661,
    specID: "MatsuriTaiko",
    specCD: 50,
    specName: global.TextContainer.matsuriSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.matsuriSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        SeisoRep: 0,
        Cheerleader: 0,
        God: 0
    },
    outfits: 
    {
        matsuriAlt1: 
        {
            outfitID: "matsuriAlt1",
            sprites: [
            {
                sprite1: 2163,
                sprite2: 1292
            }]
        }
    },
    flat: true,
    sizeGrade: 0
});
ds_map_set(global.characterData, "aki", 
{
    id: "aki",
    charName: global.TextContainer.akiName.selectedLanguage,
    port: 886,
    large_port: 1224,
    sprite1: 2195,
    sprite2: 611,
    HP: 80,
    ATK: 1.1,
    SPD: 1.5,
    crit: 1,
    attackID: "Aik",
    attackIcon: 2029,
    attack: global.TextContainer.akiAttackName.selectedLanguage,
    attackDesc: global.TextContainer.akiAttackDesc.selectedLanguage,
    specIcon: 235,
    specID: "Shallys",
    specCD: 100,
    specName: global.TextContainer.akiSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.akiSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Aromatherapy: 0,
        BellyDancing: 0,
        Mukirose: 0
    },
    outfits: 
    {
        akiAlt1: 
        {
            outfitID: "akiAlt1",
            sprites: [
            {
                sprite1: 1506,
                sprite2: 537
            }]
        }
    },
    sizeGrade: 2
});
ds_map_set(global.characterData, "subaru", 
{
    id: "subaru",
    charName: global.TextContainer.subaruName.selectedLanguage,
    port: 111,
    large_port: 1777,
    sprite1: 678,
    sprite2: 2456,
    HP: 60,
    ATK: 1.1,
    SPD: 1.5,
    crit: 5,
    attackID: "BaseballPitch",
    attackIcon: 224,
    attack: global.TextContainer.subaruAttackName.selectedLanguage,
    attackDesc: global.TextContainer.subaruAttackDesc.selectedLanguage,
    specIcon: 144,
    specID: "DuckShout",
    specCD: 70,
    specName: global.TextContainer.subaruSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.subaruSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        RelentlessOptimism: 0,
        OozoraPolice: 0,
        DuckASMR: 0
    },
    outfits: 
    {
        subaruAlt1: 
        {
            outfitID: "subaruAlt1",
            sprites: [
            {
                sprite1: 1424,
                sprite2: 1490
            }]
        }
    },
    sizeGrade: 1
});
ds_map_set(global.characterData, "choco", 
{
    id: "choco",
    charName: global.TextContainer.chocoName.selectedLanguage,
    port: 176,
    large_port: 568,
    sprite1: 1900,
    sprite2: 1969,
    HP: 65,
    ATK: 1.1,
    SPD: 1.4,
    crit: 10,
    attackID: "LoveNeedle",
    attackIcon: 1610,
    attack: global.TextContainer.chocoAttackName.selectedLanguage,
    attackDesc: global.TextContainer.chocoAttackDesc.selectedLanguage,
    specIcon: 572,
    specID: "DynamiteBody",
    specCD: 80,
    specName: global.TextContainer.chocoSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.chocoSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        DemonWhisper: 0,
        DeliciousCooking: 0,
        Nurse: 0
    },
    outfits: 
    {
        chocoAlt1: 
        {
            outfitID: "chocoAlt1",
            sprites: [
            {
                sprite1: 1215,
                sprite2: 1948
            }]
        }
    },
    sizeGrade: 4
});
ds_map_set(global.characterData, "shion", 
{
    id: "shion",
    charName: global.TextContainer.shionName.selectedLanguage,
    port: 2011,
    large_port: 1157,
    sprite1: 1290,
    sprite2: 1652,
    HP: 50,
    ATK: 1.3,
    SPD: 1.35,
    crit: 5,
    attackID: "MurasakiBolt",
    attackIcon: 153,
    attack: global.TextContainer.shionAttackName.selectedLanguage,
    attackDesc: global.TextContainer.shionAttackDesc.selectedLanguage,
    specIcon: 2155,
    specID: "KusogaKick",
    specCD: 90,
    specName: global.TextContainer.shionSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.shionSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Garlic: 0,
        CheekyBrat: 0,
        BlackMagic: 0
    },
    outfits: 
    {
        shionAlt1: 
        {
            outfitID: "shionAlt1",
            sprites: [
            {
                sprite1: 1336,
                sprite2: 1952
            }]
        }
    },
    flat: true,
    sizeGrade: 0
});
ds_map_set(global.characterData, "ayame", 
{
    id: "ayame",
    charName: global.TextContainer.ayameName.selectedLanguage,
    port: 1843,
    large_port: 252,
    sprite1: 1675,
    sprite2: 1848,
    HP: 60,
    ATK: 1.3,
    SPD: 1.3,
    crit: 10,
    attackID: "OniSlash",
    attackIcon: 2215,
    attack: global.TextContainer.ayameAttackName.selectedLanguage,
    attackDesc: global.TextContainer.ayameAttackDesc.selectedLanguage,
    specIcon: 1452,
    specID: "OniSpirit",
    specCD: 75,
    specName: global.TextContainer.ayameSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.ayameSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        AyameDefenseField: 0,
        Nakirium: 0,
        OniLady: 0
    },
    outfits: 
    {
        ayameAlt1: 
        {
            outfitID: "ayameAlt1",
            sprites: [
            {
                sprite1: 78,
                sprite2: 283
            }]
        }
    },
    sizeGrade: 1
});
ds_map_set(global.characterData, "aqua", 
{
    id: "aqua",
    charName: global.TextContainer.aquaName.selectedLanguage,
    port: 1032,
    large_port: 997,
    sprite1: 2274,
    sprite2: 2183,
    HP: 44.5,
    ATK: 1.2,
    SPD: 1.4,
    crit: 10,
    attackID: "CleaningBroom",
    attackIcon: 1128,
    attack: global.TextContainer.aquaAttackName.selectedLanguage,
    attackDesc: global.TextContainer.aquaAttackDesc.selectedLanguage,
    specIcon: 246,
    specID: "Neko",
    specCD: 60,
    specName: global.TextContainer.aquaSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.aquaSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        AquaMaid: 0,
        Sololive: 0,
        Klutz: 0
    },
    outfits: 
    {
        aquaAlt1: 
        {
            outfitID: "aquaAlt1",
            sprites: [
            {
                sprite1: 2313,
                sprite2: 2251
            }]
        }
    },
    sizeGrade: 2
});
ds_map_set(global.characterData, "moona", 
{
    id: "moona",
    charName: global.TextContainer.moonaName.selectedLanguage,
    port: 1991,
    large_port: 2054,
    sprite1: 1071,
    sprite2: 2035,
    sprites: [
    {
        sprite1: 1071,
        sprite2: 2035
    }, 
    {
        sprite1: 2463,
        sprite2: 2463
    }],
    HP: 70,
    ATK: 1.1,
    SPD: 1.3,
    crit: 1,
    attackID: "CrescentMoon",
    attackIcon: 2165,
    attack: global.TextContainer.moonaAttackName.selectedLanguage,
    attackDesc: global.TextContainer.moonaAttackDesc.selectedLanguage,
    specIcon: 183,
    specID: "HighTide",
    specCD: 90,
    specName: global.TextContainer.moonaSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.moonaSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        LunarConstruction: 0,
        MoonSong: 0,
        Hoshinova: 0
    },
    sizeGrade: 3
});
ds_map_set(global.characterData, "risu", 
{
    id: "risu",
    charName: global.TextContainer.risuName.selectedLanguage,
    port: 497,
    large_port: 1864,
    sprite1: 1199,
    sprite2: 1605,
    HP: 60,
    ATK: 1.1,
    SPD: 1.5,
    crit: 5,
    attackID: "Nuts",
    attackIcon: 665,
    attack: global.TextContainer.risuAttackName.selectedLanguage,
    attackDesc: global.TextContainer.risuAttackDesc.selectedLanguage,
    specIcon: 2114,
    specID: "BigNut",
    specCD: 70,
    specName: global.TextContainer.risuSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.risuSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Deez: 0,
        NonstopNuts: 0,
        DLC: 0
    },
    sizeGrade: 2
});
ds_map_set(global.characterData, "iofi", 
{
    id: "iofi",
    charName: global.TextContainer.iofiName.selectedLanguage,
    port: 393,
    large_port: 1663,
    sprite1: 765,
    sprite2: 1163,
    HP: 65,
    ATK: 1.2,
    SPD: 1.4,
    crit: 10,
    attackID: "PaintBrush",
    attackIcon: 259,
    attack: global.TextContainer.iofiAttackName.selectedLanguage,
    attackDesc: global.TextContainer.iofiAttackDesc.selectedLanguage,
    specIcon: 1041,
    specID: "Draw",
    specCD: 60,
    specName: global.TextContainer.iofiSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.iofiSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Erofi: 0,
        AlienBrainwashing: 0,
        Polyglot: 0
    },
    sizeGrade: 1
});
ds_map_set(global.characterData, "ollie", 
{
    id: "ollie",
    charName: global.TextContainer.ollieName.selectedLanguage,
    port: 685,
    large_port: 2117,
    sprite1: 922,
    sprite2: 2003,
    HP: 60,
    ATK: 1.2,
    SPD: 1.5,
    crit: 2,
    attackID: "OllieSword",
    attackIcon: 370,
    attack: global.TextContainer.ollieAttackName.selectedLanguage,
    attackDesc: global.TextContainer.ollieAttackDesc.selectedLanguage,
    specIcon: 1932,
    specID: "ChargeRifle",
    specCD: 60,
    specName: global.TextContainer.ollieSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.ollieSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        Ninjutsu: 0,
        Undead: 0,
        SimpOfAllTime: 0
    },
    sizeGrade: 0,
    flat: true
});
ds_map_set(global.characterData, "reine", 
{
    id: "reine",
    charName: global.TextContainer.reineName.selectedLanguage,
    port: 2073,
    large_port: 162,
    sprite1: 1063,
    sprite2: 2212,
    HP: 80,
    ATK: 0.9,
    SPD: 1.4,
    crit: 10,
    attackID: "ReineFeather",
    attackIcon: 301,
    attack: global.TextContainer.reineAttackName.selectedLanguage,
    attackDesc: global.TextContainer.reineAttackDesc.selectedLanguage,
    specIcon: 919,
    specID: "5xTonjok",
    specCD: 80,
    specName: global.TextContainer.reineSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.reineSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        WindMagic: 0,
        AttentionPlease: 0,
        LadyOfPeafowl: 0
    },
    sizeGrade: 4
});
ds_map_set(global.characterData, "anya", 
{
    id: "anya",
    charName: global.TextContainer.anyaName.selectedLanguage,
    port: 2275,
    large_port: 341,
    sprite1: 814,
    sprite2: 1255,
    HP: 60,
    ATK: 1.5,
    SPD: 1.2,
    crit: 5,
    attackID: "Keris",
    attackIcon: 969,
    attack: global.TextContainer.anyaAttackName.selectedLanguage,
    attackDesc: global.TextContainer.anyaAttackDesc.selectedLanguage,
    specIcon: 2433,
    specID: "BladeForm",
    specCD: 75,
    specName: global.TextContainer.anyaSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.anyaSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        LivingWeapon: 0,
        Slumber: 0,
        CuttingDeep: 0
    },
    sizeGrade: 1
});
ds_map_set(global.characterData, "kaela", 
{
    id: "kaela",
    charName: global.TextContainer.kaelaName.selectedLanguage,
    port: 1089,
    large_port: 1569,
    sprite1: 1146,
    sprite2: 2460,
    HP: 69,
    ATK: 1.3,
    SPD: 1.3,
    crit: 3,
    attackID: "BlacksmithHammer",
    attackIcon: 1494,
    attack: global.TextContainer.kaelaAttackName.selectedLanguage,
    attackDesc: global.TextContainer.kaelaAttackDesc.selectedLanguage,
    specIcon: 2451,
    specID: "RarestMaterial",
    specCD: 90,
    specName: global.TextContainer.kaelaSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.kaelaSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        MaterialGrind: 0,
        NoPressure: 0,
        TheBlacksmith: 0
    },
    sizeGrade: 2
});
ds_map_set(global.characterData, "zeta", 
{
    id: "zeta",
    charName: global.TextContainer.zetaName.selectedLanguage,
    port: 2327,
    large_port: 2468,
    sprite1: 1473,
    sprite2: 1273,
    HP: 70,
    ATK: 1.1,
    SPD: 1.4,
    crit: 5,
    attackID: "SilentPistol",
    attackIcon: 1759,
    attack: global.TextContainer.zetaAttackName.selectedLanguage,
    attackDesc: global.TextContainer.zetaAttackDesc.selectedLanguage,
    specIcon: 386,
    specID: "StealthMode",
    specCD: 70,
    specName: global.TextContainer.zetaSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.zetaSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        SecretAgent: 0,
        CatReflexes: 0,
        DataCollection: 0
    },
    sizeGrade: 1
});
ds_map_set(global.characterData, "kobo", 
{
    id: "kobo",
    charName: global.TextContainer.koboName.selectedLanguage,
    port: 1732,
    large_port: 1580,
    sprite1: 725,
    sprite2: 804,
    HP: 60,
    ATK: 1.2,
    SPD: 1.4,
    crit: 1,
    attackID: "Umbrella",
    attackIcon: 1779,
    attack: global.TextContainer.koboAttackName.selectedLanguage,
    attackDesc: global.TextContainer.koboAttackDesc.selectedLanguage,
    specIcon: 1661,
    specID: "Underwater",
    specCD: 85,
    specName: global.TextContainer.koboSpecialAttackName.selectedLanguage,
    specDesc: global.TextContainer.koboSpecialAttackDesc.selectedLanguage,
    perks: 
    {
        RainCloud: 0,
        Praise: 0,
        Tantrum: 0
    },
    sizeGrade: 0,
    flat: true
});
ds_map_set(global.characterData, "empty", 
{
    id: "",
    charName: "",
    port: 585,
    large_port: -1,
    sprite1: -1,
    sprite2: -1,
    HP: 0,
    ATK: 0,
    SPD: 0,
    crit: 0,
    attackID: "",
    attackIcon: -1,
    attack: "",
    attackDesc: "",
    specIcon: -1,
    specID: "",
    specCD: 0,
    specName: "",
    specDesc: ""
});
ds_map_set(global.characterData, "none", 
{
    id: "",
    charName: "",
    port: -1,
    large_port: -1,
    sprite1: -1,
    sprite2: -1,
    HP: 0,
    ATK: 0,
    SPD: 0,
    crit: 0,
    attackID: "",
    attackIcon: -1,
    attack: "",
    attackDesc: "",
    specIcon: -1,
    specID: "",
    specCD: 0,
    specName: "",
    specDesc: ""
});
ds_map_set(global.characterData, "random", 
{
    id: "random",
    charName: "RANDOM",
    port: 1739,
    sprite1: -1,
    sprite2: -1,
    HP: 0,
    ATK: 0,
    SPD: 0,
    crit: 0,
    attackID: "",
    attackIcon: -1,
    attack: "",
    attackDesc: "",
    specIcon: -1,
    specID: "",
    specCD: 0,
    specName: "",
    specDesc: ""
});
