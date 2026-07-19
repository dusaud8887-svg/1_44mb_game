if (!ds_map_exists(async_load, "type"))
{
    exit;
}
if (!string_count("FirebaseFirestore", ds_map_find_value(async_load, "type")))
{
    exit;
}
if (string_count("uidData", ds_map_find_value(async_load, "path")))
{
    exit;
}

function FetchStatusToString(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_200:
            return "success";
            break;
        case UnknownEnum.Value_400:
            return "generalError";
            break;
        case UnknownEnum.Value_401:
            return "unauthenticated";
            break;
        case UnknownEnum.Value_403:
            return "permissionDenied";
            break;
        case UnknownEnum.Value_404:
            return "documentNotFound";
            break;
        case UnknownEnum.Value_409:
            return "alreadyExists";
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
show_debug_message("Firestore fetch status - " + FetchStatusToString(status));
var type = ds_map_find_value(async_load, "type");
switch (status)
{
    case UnknownEnum.Value_200:
        show_debug_message("Firestore fetch success! - " + type);
        switch (type)
        {
            case "RESTFirebaseFirestore_Document_Set":
                OnFirebaseFirestoreDocumentAddOrUpdate();
                break;
            case "FirebaseFirestore_Document_Update":
                OnFirebaseFirestoreDocumentAddOrUpdate();
                break;
            case "FirebaseFirestore_Document_Read":
                var path = ds_map_find_value(async_load, "path");
                value = ds_map_find_value(async_load, "value");
                var result = ds_map_find_value(async_load, "result");
                OnFirebaseFirestoreDocumentRead(path, value, result);
                break;
        }
        break;
    case UnknownEnum.Value_401:
        switch (type)
        {
            case "RESTFirebaseFirestore_Document_Set":
            case "FirebaseFirestore_Document_Update":
                FirebaseAuthSignInWithCallback(UnknownEnum.Value_0, UnknownEnum.Value_2);
                break;
            case "FirebaseFirestore_Document_Read":
                FirebaseAuthSignInWithCallback(UnknownEnum.Value_3, UnknownEnum.Value_5);
                break;
        }
        break;
    case UnknownEnum.Value_400:
    case UnknownEnum.Value_403:
    case UnknownEnum.Value_404:
    case UnknownEnum.Value_409:
    case UnknownEnum.Value_4000:
    default:
        show_debug_message("Firestore fetch fail! - " + type);
        if (postScoreFromFailCallback)
        {
            switch (type)
            {
                case "RESTFirebaseFirestore_Document_Set":
                case "FirebaseFirestore_Document_Update":
                    var playerMan = instance_find(obj_PlayerManager, 0);
                    if (playerMan != -4)
                    {
                        playerMan.OnPostScoreFail(status != UnknownEnum.Value_4000);
                    }
                    exit;
            }
        }
        else if (fetchScoreFromFailCallback && type == "FirebaseFirestore_Document_Read")
        {
            OnFetchScoreFail(status != UnknownEnum.Value_4000);
            exit;
        }
        else
        {
            switch (type)
            {
                case "RESTFirebaseFirestore_Document_Set":
                case "FirebaseFirestore_Document_Update":
                    var callback = (status == UnknownEnum.Value_4000) ? UnknownEnum.Value_2 : UnknownEnum.Value_1;
                    FirebaseAuthSignInWithCallback(UnknownEnum.Value_0, callback);
                    break;
                case "FirebaseFirestore_Document_Read":
                    if (!fetchScoreError)
                    {
                        var callback = (status == UnknownEnum.Value_4000) ? UnknownEnum.Value_5 : UnknownEnum.Value_4;
                        FirebaseAuthSignInWithCallback(UnknownEnum.Value_3, callback);
                    }
                    break;
            }
        }
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_200 = 200,
    Value_400 = 400,
    Value_401,
    Value_403 = 403,
    Value_404,
    Value_409 = 409,
    Value_4000 = 4000
}
