if (textAlpha > 0)
{
    textAlpha -= 0.26;
    if (textAlpha < 0)
    {
        textAlpha = 0;
        if (currentText < 8)
        {
            currentText++;
        }
    }
    else
    {
        alarm[3] = 12;
    }
}
