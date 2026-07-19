creditsScroll -= 0.4;
if (creditsScroll < -(200 + string_height(global.TextContainer.CreditsList.selectedLanguage)))
{
    creditsScroll = 330;
    DoAchievement("thankYou");
}
