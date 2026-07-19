remainingUses = 1;
depth = -y - 2;
emitter = part_emitter_create(global.psystem);
part_emitter_region(global.psystem, emitter, x - 15, x + 20, y + 15, y - 15, 0, 0);
part_emitter_stream(global.psystem, emitter, global.partType3, 2);
part_system_depth(global.psystem, -9999);
followPlayerID = instance_find(obj_Player, 0);
isInView = false;
xPos = 0;
yPos = 0;
arrowDir = 0;
canCollide = false;
alarm[0] = 60;
used = false;
initialSpawn = true;
stickerData = -1;
remainingUses = 1;
destroyIfNoneLeft = false;

function RollSticker()
{
    var availableStickers = [];
    for (var i = 0; i < array_length(global.availableStickers); i++)
    {
        if (!array_exists(global.currentStickers, global.availableStickers[i]))
        {
            var weight = ds_map_find_value(obj_PlayerManager.STICKERS, global.availableStickers[i]).weight;
            for (var j = 0; j < weight; j++)
            {
                array_push(availableStickers, global.availableStickers[i]);
            }
        }
    }
    if (array_length(availableStickers) > 0)
    {
        stickerID = availableStickers[irandom(array_length(availableStickers) - 1)];
        for (var i = 0; i < array_length(global.availableStickers); i++)
        {
            if (stickerID == global.availableStickers[i])
            {
                array_delete(global.availableStickers, i, 1);
                break;
            }
        }
        soundPlay([298], "sticker", 10, 75);
        stickerData = ds_map_find_value(obj_PlayerManager.STICKERS, stickerID);
        sprite_index = stickerData.optionIcon;
    }
    else
    {
        destroyIfNoneLeft = true;
    }
}

function Destroy()
{
    part_emitter_destroy(global.psystem, emitter);
    global.collectedSticker = -1;
    instance_destroy();
}

alarm[1] = 2;
