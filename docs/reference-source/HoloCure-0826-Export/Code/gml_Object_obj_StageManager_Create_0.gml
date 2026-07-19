stages = 
{
    Room1: 1,
    Room1_debug: 1,
    rm_HoloOffice: 3,
    rm_GrassPlains_Night: 4,
    rm_ConcertStage: 5,
    rm_Castle: 6,
    rm_HoloOffice_SunSet: 7,
    rm_IDArena: 8,
    rm_CastleMyth: 9
};
global.topBorder = -1;
global.bottomBorder = -1;
global.leftBorder = -1;
global.rightBorder = -1;
enemyAmount = 0;
enemyLimit = 2000;
spawnRate = 180;
spawnAmount = 2;
timer = 0;
enabledSpawner = true;
enabledTimeline = true;
global.timeModeSpawnScale = 0;
global.timeModeRateScale = 0;
global.mobsSpawned = 0;
global.totalPossibleEXP = 0;
timeSinceLastSpawn = 0;
spawnPatterns = 
{
    evenSurround: 0,
    horizontalSurround: 0,
    verticalSurround: 0,
    directionalSurround: 0,
    stage2_evenSurround: 0,
    stage2_leftSurround: 0,
    stage2_rightSurround: 0,
    random: 0
};
currentSpawnPattern = "evenSurround";
currentSpawnDirection = 0;
timelineCommands = {};
mobSpawnChoices = {};
mobSpawnPool = [];
eventSpawnChoices = {};
controlGroups = {};
lockPosition = instance_create_depth(x, y, depth, obj_empty);
lockPosition.creator = id;
lockPosition.permanent = true;
event_user(0);
event_user(2);
var index = variable_struct_get(stages, room_get_name(room));
event_user(index);
slices = 36;
sequenceSpawn = false;
sequenceSpawnTime = 0;
sequenceSpawnTimer = 0;
sequenceIndex = 0;
sequenceConfig = {};
GenerateDirections();
if (room == Room1 || room == Room1_debug)
{
    AddMobChoice("Shrimp", 2, 1);
}
if (room == rm_GrassPlains_Night)
{
    AddMobChoice("Shrimp", 3, 3);
}
