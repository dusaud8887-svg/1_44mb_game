lifetime = 0;
creator = -1;
rhythmTimes = [0, 0, 0, 0, 0, 0, 0, 0];
beatTimes = [0, 30, 60, 115, 135, 145, 160, 175];
correctHits = [0, 0, 0, 0, 0, 0, 0, 0];
currentBeat = 0;
alarm[0] = 300;
circleTime = 80;
emitter = part_emitter_create(global.psystem);
depth = -9999;
orangeLight = 0;

function Pressed()
{
    if (currentBeat < 8)
    {
        if (lifetime > beatTimes[currentBeat] && lifetime < (beatTimes[currentBeat] + circleTime))
        {
            var hitCorrect = 0;
            if (lifetime > (beatTimes[currentBeat] + 55))
            {
                hitCorrect = 1;
                correctHits[currentBeat] = 1;
            }
            if (hitCorrect == 0)
            {
                if (currentBeat == 2 || currentBeat == 5)
                {
                    soundPlay([36], "drum", 5, 50, false);
                }
                else
                {
                    soundPlay([142], "drum", 5, 50, false);
                }
            }
            else if (currentBeat == 2 || currentBeat == 5)
            {
                soundPlay([13], "drum", 5, 50, false);
            }
            else
            {
                soundPlay([239], "drum", 5, 50, false);
            }
            if (hitCorrect == 1)
            {
                orangeLight = 0.3;
                part_emitter_region(global.psystem, emitter, creator.x, creator.x, creator.y - 16, creator.y - 16, 0, 0);
                part_emitter_burst(global.psystem, emitter, global.partType14, 100);
            }
            obj_AttackController.ExecuteAttack("TaikoBurst", creator, 
            {
                x: creator.x,
                y: creator.y - 16,
                image_xscale: 1.5 + (hitCorrect * 3),
                image_yscale: 1.5 + (hitCorrect * 3),
                damage: 1.5 + hitCorrect
            });
            beatTimes[currentBeat] = -1;
            currentBeat++;
            if (currentBeat == 8)
            {
                var allCorrect = true;
                for (var i = 0; i < array_length(correctHits); i++)
                {
                    if (correctHits[i] == 0)
                    {
                        allCorrect = false;
                    }
                }
                if (allCorrect)
                {
                    alarm[1] = 15;
                }
                else
                {
                    instance_destroy();
                }
            }
        }
    }
}
