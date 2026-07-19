if (canCollide && stickerData != -1)
{
    var playerMan = instance_find(obj_PlayerManager, 0);
    global.collectedSticker = stickerData;
    playerMan.getSticker(id);
    canCollide = false;
    alarm[0] = 60;
}
