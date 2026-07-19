if (!ds_map_exists(async_load, "type"))
{
    exit;
}
if (!string_count("FirebaseAuthentication", ds_map_find_value(async_load, "type")))
{
    exit;
}

function AuthStatusToString(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_200:
            return "success";
            break;
        case UnknownEnum.Value_4000:
            return "unhandledError";
            break;
        default:
            return string(arg0);
            break;
    }
}

var status = ds_map_find_value(async_load, "status");
if (ds_map_exists(async_load, "errorMessage"))
{
    show_debug_message(string(ds_map_find_value(async_load, "errorMessage")));
    if (status == UnknownEnum.Value_200)
    {
        status = UnknownEnum.Value_4000;
    }
}
show_debug_message("Firebase Authentication status - " + AuthStatusToString(status));
var type = ds_map_find_value(async_load, "type");
switch (status)
{
    case UnknownEnum.Value_200:
        show_debug_message("Firebase Authentication success! - " + type);
        switch (type)
        {
            case "FirebaseAuthentication_SignIn_Anonymously":
                global.UID = FirebaseAuthentication_GetUID();
                show_debug_message("Signed in successfully! UID: " + global.UID);
                FirebaseAuthSignInSuccess();
                break;
        }
        break;
    case UnknownEnum.Value_4000:
    default:
        show_debug_message("Firebase Authentication fail! - " + type);
        FirebaseAuthSignInFail();
        break;
}

enum UnknownEnum
{
    Value_200 = 200,
    Value_4000 = 4000
}
