function PushDamageData(arg0, arg1, arg2 = "")
{
    var attackDamageID = "";
    if (arg2 != "")
    {
        attackDamageID = arg2;
    }
    else if (variable_instance_exists(arg0, "attackDamageID"))
    {
        attackDamageID = arg0.attackDamageID;
    }
    else
    {
        attackDamageID = arg0.attackID;
    }
    var found = false;
    var index = 0;
    for (var i = 0; i < array_length(obj_PlayerManager.damageData); i++)
    {
        if (obj_PlayerManager.damageData[i][0] == attackDamageID)
        {
            found = true;
            index = i;
        }
    }
    if (found)
    {
        obj_PlayerManager.damageData[index][1] += arg1;
    }
    else if (arg1 > 0)
    {
        array_push(obj_PlayerManager.damageData, [attackDamageID, arg1, 0]);
    }
}
