function key_to_string()
{
    var key = argument0;
    switch (key)
    {
        case 32:
            return "SPACE";
        case 37:
            return "LEFT";
        case 39:
            return "RIGHT";
        case 38:
            return "UP";
        case 40:
            return "DOWN";
        case 107:
            return "+";
        case 8:
            return "BACKSPACE";
        case 110:
            return "^";
        case 46:
            return "DELETE";
        case 111:
            return "/";
        case 35:
            return "END";
        case 13:
            return "ENTER";
        case 27:
            return "ESCAPE";
        case 112:
            return "F1";
        case 113:
            return "F2";
        case 114:
            return "F3";
        case 115:
            return "F4";
        case 116:
            return "F5";
        case 117:
            return "F6";
        case 118:
            return "F7";
        case 119:
            return "F8";
        case 120:
            return "F9";
        case 121:
            return "F10";
        case 122:
            return "F11";
        case 123:
            return "F12";
        case 36:
            return "HOME";
        case 45:
            return "INSERT";
        case 164:
            return "L.ALT";
        case 162:
            return "L.CTRL";
        case 160:
            return "L.SHIFT";
        case 106:
            return "*";
        case 96:
            return "NUM 0";
        case 97:
            return "NUM 1";
        case 98:
            return "NUM 2";
        case 99:
            return "NUM 3";
        case 100:
            return "NUM 4";
        case 101:
            return "NUM 5";
        case 102:
            return "NUM 6";
        case 103:
            return "NUM 7";
        case 104:
            return "NUM 8";
        case 105:
            return "NUM 9";
        case 34:
            return "PAGE DOWN";
        case 33:
            return "PAGE UP";
        case 19:
            return "PAUSE";
        case 44:
            return "PRT SCR";
        case 165:
            return "R.ALT";
        case 163:
            return "R.CTRL";
        case 161:
            return "R.SHIFT";
        case 18:
            return "ALT";
        case 17:
            return "CTRL";
        case 16:
            return "SHIFT";
        case 109:
            return "-";
        case 9:
            return "TAB";
        case 22:
            return "CAPS LOCK";
        case 91:
            return "WIN KEY";
        case 32769:
            return "gp_face1";
        case 32770:
            return "gp_face2";
        case 32771:
            return "gp_face3";
        case 32772:
            return "gp_face4";
        case 32773:
            return "gp_shoulderl";
        case 32775:
            return "gp_shoulderlb";
        case 32774:
            return "gp_shoulderr";
        case 32776:
            return "gp_shoulderrb";
        case 32777:
            return "gp_select";
        case 32778:
            return "gp_start";
        default:
            return chr(string(key));
    }
}

function ControllerToStrings()
{
    var key = argument0;
    show_debug_message("controller: " + string(key));
    switch (key)
    {
        case 32769:
            return "gp_face1";
        case 32770:
            return "gp_face2";
        case 32771:
            return "gp_face3";
        case 32772:
            return "gp_face4";
        case 32773:
            return "gp_shoulderl";
        case 32775:
            return "gp_shoulderlb";
        case 32774:
            return "gp_shoulderr";
        case 32776:
            return "gp_shoulderrb";
        case 32777:
            return "gp_select";
        case 32778:
            return "gp_start";
        default:
            return "";
    }
}

function ValidKeysOnly(arg0)
{
    var key = argument0;
    switch (key)
    {
        case 107:
            return false;
        case 8:
            return false;
        case 110:
            return false;
        case 46:
            return false;
        case 35:
            return false;
        case 13:
            return false;
        case 27:
            return false;
        case 112:
            return false;
        case 113:
            return false;
        case 114:
            return false;
        case 115:
            return false;
        case 116:
            return false;
        case 117:
            return false;
        case 118:
            return false;
        case 119:
            return false;
        case 120:
            return false;
        case 121:
            return false;
        case 122:
            return false;
        case 123:
            return false;
        case 164:
            return false;
        case 162:
            return false;
        case 160:
            return false;
        case 106:
            return false;
        case 96:
            return false;
        case 97:
            return false;
        case 98:
            return false;
        case 99:
            return false;
        case 100:
            return false;
        case 101:
            return false;
        case 102:
            return false;
        case 103:
            return false;
        case 104:
            return false;
        case 105:
            return false;
        case 34:
            return false;
        case 33:
            return false;
        case 19:
            return false;
        case 44:
            return false;
        case 165:
            return false;
        case 163:
            return false;
        case 161:
            return false;
        case 109:
            return false;
        case 9:
            return false;
        case 45:
            return false;
        case 219:
            return false;
        case 221:
            return false;
        case 191:
            return false;
        case 220:
            return false;
        case 222:
            return false;
        case 111:
            return false;
        case 186:
            return false;
        case 22:
            return false;
        case 91:
            return false;
        default:
            return true;
    }
}
