if (showingDialogue)
{
    if (array_length(fullDialogue) > 0)
    {
        if (displayDelay > 0)
        {
            displayDelay--;
        }
        else if (displayingDialogue != fullDialogue[currentPage][1])
        {
            displayingDialogue += string_copy(fullDialogue[currentPage][1], textIndex, 1);
            if (string_copy(fullDialogue[currentPage][1], textIndex, 1) != " " && string_copy(fullDialogue[currentPage][1], textIndex, 1) != "　")
            {
                soundPlay([201], "textblip", 3, 5, true);
            }
            if (string_copy(fullDialogue[currentPage][1], textIndex, 1) == "." || string_copy(fullDialogue[currentPage][1], textIndex, 1) == "。" || string_copy(fullDialogue[currentPage][1], textIndex, 1) == "！" || string_copy(fullDialogue[currentPage][1], textIndex, 1) == "？" || string_copy(fullDialogue[currentPage][1], textIndex, 1) == "、" || string_copy(fullDialogue[currentPage][1], textIndex, 1) == "?" || string_copy(fullDialogue[currentPage][1], textIndex, 1) == "!" || string_copy(fullDialogue[currentPage][1], textIndex, 1) == ",")
            {
                displayDelay = 6;
            }
            else
            {
                displayDelay = 1;
            }
            textIndex++;
        }
    }
}
if (timer < 60)
{
    timer++;
}
else
{
    timer = 0;
}
