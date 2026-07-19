if (paused && !gotBox && !gotAnvil && !gotGoldenAnvil && !gotSticker && !leveled && !gameOvered && !gameWon && !gotGoldenAnvil && !reviving)
{
    if (!quitConfirm)
    {
        for (var i = 0; i < 6; i++)
        {
            if (MouseOverButton("short", pauseContainer[0], pauseContainer[1] + 62 + (i * 30), 2))
            {
                Confirmed();
            }
        }
    }
    else
    {
        for (var i = 0; i < 2; i++)
        {
            if (MouseOverButton("short", pauseContainer[0], pauseContainer[1] + 30 + 62 + (i * 30), 2))
            {
                Confirmed();
            }
        }
    }
}
