if (!ds_map_exists(async_load, "type"))
{
    exit;
}
if (!string_count("FirebaseAuthentication", ds_map_find_value(async_load, "type")))
{
    exit;
}
var ins = instance_create_depth(0, 0, 0, Obj_Debug_FallText_Authentication);
ins.text = string(ds_map_find_value(async_load, "listener")) + " - " + ds_map_find_value(async_load, "type") + " - " + string(ds_map_find_value(async_load, "status"));
if (ds_map_exists(async_load, "value"))
{
    ins.text += " -> " + string(ds_map_find_value(async_load, "value"));
}
if (ds_map_exists(async_load, "errorMessage"))
{
    ins.text += " -> " + string(ds_map_find_value(async_load, "errorMessage"));
}
if (ds_map_find_value(async_load, "status") == 200)
{
    ins.color = 16777215;
}
else
{
    ins.color = 255;
}
if (ds_map_find_value(async_load, "status") == 200)
{
    switch (ds_map_find_value(async_load, "type"))
    {
        case "FirebaseAuthentication_SignInWithCustomToken":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseAuthentication_SignIn_Email":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseAuthentication_SignUp_Email":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseAuthentication_SignIn_Anonymously":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseAuthentication_SendPasswordResetEmail":
            break;
        case "FirebaseAuthentication_ChangeEmail":
            break;
        case "FirebaseAuthentication_ChangePassword":
            break;
        case "FirebaseAuthentication_ChangeDisplayName":
            break;
        case "FirebaseAuthentication_ChangePhotoURL":
            break;
        case "FirebaseAuthentication_SendEmailVerification":
            break;
        case "FirebaseAuthentication_DeleteAccount":
            break;
        case "FirebaseAuthentication_LinkWithEmailPassword":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseAuthentication_SignIn_OAuth":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseAuthentication_LinkWithOAuthCredential":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseAuthentication_UnlinkProvider":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseAuthentication_RefreshUserData":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseAuthentication_GetIdToken":
            var token = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseAuthentication_SignInWithPhoneNumber":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseAuthentication_LinkWithPhoneNumber":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseAuthentication_ReauthenticateWithOAuth":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseAuthentication_ReauthenticateWithPhoneNumber":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "SDKFirebaseAuthentication_SignInWithProvider":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "SDKFirebaseAuthentication_LinkWithProvider":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "SDKFirebaseAuthentication_ReauthenticateWithProvider":
            var user_raw = ds_map_find_value(async_load, "value");
            break;
        case "FirebaseAuthentication_IdTokenListener":
            var token = ds_map_find_value(async_load, "value");
            break;
    }
}
