if (selectedCharacter == randomSelectSlot)
{
    if (randomDelay == 0)
    {
        randomDelay = 4;
        audio_play_sound(snd_charSelectWoosh, 0, 0);
        randomSelect = randomAvailableCharacters[irandom(array_length(randomAvailableCharacters) - 1)];
    }
    else
    {
        randomDelay--;
    }
}
