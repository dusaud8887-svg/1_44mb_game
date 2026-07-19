function FirebaseAuthentication_SignInWithCustomToken(arg0)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_SignInWithCustomToken(arg0);
    }
    FirebaseAuthentication_controllerVerification();
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_SignInWithCustomToken_YYFirebaseCallback", 98, "https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("returnSecureToken", "true", "token", arg0));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function RESTFirebaseAuthentication_RequestIDToken_FromCache()
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return -4;
    }
    FirebaseAuthentication_controllerVerification();
    if (file_exists("Firebase.data"))
    {
        var map = new_ds_map_secure_load("Firebase.data");
        var refreshToken = ds_map_find_value(map, "refreshToken");
        if (ds_map_exists(map, "UserData"))
        {
            global.YYFirebaseUserData = ds_map_find_value(map, "UserData");
        }
        ds_map_destroy(map);
        return RESTFirebaseAuthentication_RequestIDToken(refreshToken);
    }
    else
    {
        return -4;
    }
}

function RESTFirebaseAuthentication_RequestIDToken(arg0)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return -4;
    }
    FirebaseAuthentication_controllerVerification();
    var listener = FirebaseREST_asyncFunction_Authentication("RESTFirebaseAuthentication_RequestIDToken_YYFirebaseCallback", 98, "https://securetoken.googleapis.com/v1/token?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/x-www-form-urlencoded"), "grant_type=refresh_token&refresh_token=" + arg0);
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_SignUp_Email(arg0, arg1)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_SignUp_Email(arg0, arg1);
    }
    FirebaseAuthentication_controllerVerification();
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_SignUp_Email_YYFirebaseCallback", 98, "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("returnSecureToken", "true", "email", arg0, "password", arg1));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_SignIn_Email(arg0, arg1)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_SignIn_Email(arg0, arg1);
    }
    FirebaseAuthentication_controllerVerification();
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_SignIn_Email_YYFirebaseCallback", 98, "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("returnSecureToken", "true", "email", arg0, "password", arg1));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_SignIn_Anonymously()
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_SignIn_Anonymously();
    }
    FirebaseAuthentication_controllerVerification();
    if (file_exists("Firebase.data"))
    {
        var listener = RESTFirebaseAuthentication_RequestIDToken_FromCache();
        listener.event = "FirebaseAuthentication_SignIn_Anonymously_YYFirebaseCallback";
    }
    else
    {
        var what = extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey");
        var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_SignIn_Anonymously_YYFirebaseCallback", 98, "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("returnSecureToken", "true"));
        listener.dropListenerFromArgs = true;
        Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
        return listener;
    }
}

function FirebaseAuthentication_SignIn_GameCenter(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_SignIn_GameCenter();
    }
    FirebaseAuthentication_controllerVerification();
    show_debug_message("signature: " + arg3);
    show_debug_message("salt: " + arg4);
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_SignIn_GameCenter_YYFirebaseCallback", 98, "https://identitytoolkit.googleapis.com/v1/accounts:signInWithGameCenter?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json", "x-ios-bundle-identifier", arg0), FirebaseREST_KeyValue("playerId", arg1, "publicKeyUrl", arg2, "signature", arg3, "salt", arg4, "timestamp", arg5, "displayName", arg7));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_SignIn_OAuth(arg0, arg1, arg2, arg3 = "")
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_SignIn_OAuth(arg0, arg1, arg2, arg3);
    }
    FirebaseAuthentication_controllerVerification();
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_SignIn_OAuth_YYFirebaseCallback", 98, "https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("returnSecureToken", "true", "returnIdpCredential", "true", "requestUri", arg3, "postBody", arg1 + "=" + arg0 + "&providerId=" + arg2));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_SendPasswordResetEmail(arg0)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_SendPasswordResetEmail(arg0);
    }
    FirebaseAuthentication_controllerVerification();
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_SendPasswordResetEmail", 98, "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("requestType", "PASSWORD_RESET", "email", arg0));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_ChangeEmail(arg0)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_ChangeEmail(arg0);
    }
    FirebaseAuthentication_controllerVerification();
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_ChangeEmail_YYFirebaseCallback", 98, "https://identitytoolkit.googleapis.com/v1/accounts:update?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("returnSecureToken", "true", "idToken", RESTFirebaseAuthentication_GetIdToken(), "email", arg0));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_ChangePassword(arg0)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_ChangePassword(arg0);
    }
    FirebaseAuthentication_controllerVerification();
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_ChangePassword_YYFirebaseCallback", 98, "https://identitytoolkit.googleapis.com/v1/accounts:update?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("returnSecureToken", "true", "idToken", RESTFirebaseAuthentication_GetIdToken(), "password", arg0));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_ChangeDisplayName(arg0)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_ChangeDisplayName(arg0);
    }
    var ins = RESTFirebaseAuthentication_UpdateProfile_Builder(arg0, "", false, false);
    ins.event = "FirebaseAuthentication_ChangeDisplayName_YYFirebaseCallback";
}

function FirebaseAuthentication_ChangePhotoURL(arg0)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_ChangePhotoURL(arg0);
    }
    var ins = RESTFirebaseAuthentication_UpdateProfile_Builder("", arg0, false, false);
    ins.event = "FirebaseAuthentication_ChangePhotoURL_YYFirebaseCallback";
}

function RESTFirebaseAuthentication_UpdateProfile_Builder(arg0, arg1, arg2, arg3)
{
    FirebaseAuthentication_controllerVerification();
    var map = json_decode(FirebaseREST_KeyValue("idToken", RESTFirebaseAuthentication_GetIdToken(), "returnSecureToken", "true"));
    if (arg0 != "")
    {
        ds_map_set(map, "displayName", arg0);
    }
    if (arg1 != "")
    {
        ds_map_set(map, "photoUrl", arg1);
    }
    var list = ds_list_create();
    if (arg2 == "")
    {
        ds_list_add(list, "DISPLAY_NAME");
    }
    if (arg3 == "")
    {
        ds_list_add(list, "PHOTO_URL");
    }
    ds_map_add_list(map, "deleteAttribute", list);
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_UpdateProfile_YYFirebaseCallback", 98, "https://identitytoolkit.googleapis.com/v1/accounts:update?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), json_encode(map));
    ds_map_destroy(map);
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function RESTFirebaseAuthentication_GetUserData()
{
    FirebaseAuthentication_controllerVerification();
    var listener = FirebaseREST_asyncFunction_Authentication("RESTFirebaseAuthentication_GetUserData", 98, "https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("idToken", RESTFirebaseAuthentication_GetIdToken()));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_LinkWithEmailPassword(arg0, arg1)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_LinkWithEmailPassword(arg0, arg1);
    }
    FirebaseAuthentication_controllerVerification();
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_LinkWithEmailPassword_YYFirebaseCallback", 98, "https://identitytoolkit.googleapis.com/v1/accounts:update?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("idToken", RESTFirebaseAuthentication_GetIdToken(), "returnSecureToken", "true", "email", arg0, "password", arg1));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_LinkWithOAuthCredential(arg0, arg1, arg2, arg3 = "")
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_LinkWithOAuthCredential(arg0, arg1, arg2, arg3);
    }
    FirebaseAuthentication_controllerVerification();
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_LinkWithOAuthCredential_YYFirebaseCallback", 98, "https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("idToken", RESTFirebaseAuthentication_GetIdToken(), "returnSecureToken", "true", "returnIdpCredential", "true", "requestUri", arg3, "postBody", arg1 + "=" + arg0 + "&providerId=" + arg2));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_UnlinkProvider(arg0)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_UnlinkProvider(arg0);
    }
    FirebaseAuthentication_controllerVerification();
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_UnlinkProvider_YYFirebaseCallback", 98, "https://identitytoolkit.googleapis.com/v1/accounts:update?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("idToken", RESTFirebaseAuthentication_GetIdToken(), "deleteProvider", arg0));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_SendEmailVerification()
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_SendEmailVerification();
    }
    FirebaseAuthentication_controllerVerification();
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_SendEmailVerification", 98, "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("idToken", RESTFirebaseAuthentication_GetIdToken(), "requestType", "VERIFY_EMAIL"));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_DeleteAccount()
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_DeleteAccount();
    }
    FirebaseAuthentication_controllerVerification();
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_DeleteAccount", 98, "https://identitytoolkit.googleapis.com/v1/accounts:delete?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("idToken", RESTFirebaseAuthentication_GetIdToken()));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_RefreshUserData()
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_RefreshUserData();
    }
    listener = RESTFirebaseAuthentication_RequestIDToken_FromCache();
    listener.event = "FirebaseAuthentication_RefreshUserData_YYFirebaseCallback";
    return listener;
}

function FirebaseAuthentication_SignOut()
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_SignOut();
    }
    FirebaseAuthentication_controllerVerification();
    if (variable_global_exists("YYFirebaseUserData"))
    {
        global.YYFirebaseUserData = "{}";
    }
    if (variable_global_exists("YYFirebaseIdToken"))
    {
        global.YYFirebaseIdToken = "";
    }
    Obj_FirebaseREST_Authentication.alarm[0] = -1;
    if (file_exists("Firebase.data"))
    {
        file_delete("Firebase.data");
    }
    if (global.Listener_IdToken)
    {
        var map = ds_map_create();
        ds_map_set(map, "type", "FirebaseAuthentication_IdTokenListener");
        ds_map_set(map, "listener", global.Listener_IdToken);
        ds_map_set(map, "status", 200);
        ds_map_set(map, "value", global.YYFirebaseIdToken);
        event_perform_async(ev_async_social, map);
    }
}

function FirebaseAuthentication_GetIdToken()
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_GetIdToken();
    }
    var listener = irandom_range(100000, 900000);
    var map = ds_map_create();
    ds_map_set(map, "type", "FirebaseAuthentication_GetIdToken");
    ds_map_set(map, "listener", listener);
    if (variable_global_exists("YYFirebaseIdToken"))
    {
        ds_map_set(map, "status", 200);
        ds_map_set(map, "value", global.YYFirebaseIdToken);
    }
    else
    {
        ds_map_set(map, "status", 400);
    }
    event_perform_async(ev_async_social, map);
    return listener;
}

function RESTFirebaseAuthentication_GetIdToken()
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return "";
    }
    if (variable_global_exists("YYFirebaseIdToken"))
    {
        return global.YYFirebaseIdToken;
    }
    else
    {
        return "";
    }
}

function FirebaseAuthentication_GetUserData_raw()
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_GetUserData();
    }
    if (variable_global_exists("YYFirebaseUserData"))
    {
        return global.YYFirebaseUserData;
    }
    else
    {
        return "{}";
    }
}

function FirebaseAuthentication_Get(arg0, arg1)
{
    var json = "{}";
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        json = SDKFirebaseAuthentication_GetUserData();
    }
    else
    {
        json = FirebaseAuthentication_GetUserData_raw();
    }
    var value = undefined;
    var map = json_decode(json);
    if (ds_map_exists(map, "users"))
    {
        var ind = 0;
        if (array_length(arg1))
        {
            ind = arg1[0];
        }
        var list = ds_map_find_value(map, "users");
        value = ds_map_find_value(ds_list_find_value(list, ind), arg0);
    }
    ds_map_destroy(map);
    return value;
}

function FirebaseAuthentication_GetLocalId()
{
    var array = [];
    for (var a = 0; a < argument_count; a++)
    {
        array_push(array, argument_count);
    }
    var value = FirebaseAuthentication_Get("localId", array);
    if (is_undefined(value))
    {
        return "";
    }
    return value;
}

function FirebaseAuthentication_GetEmail()
{
    var array = [];
    for (var a = 0; a < argument_count; a++)
    {
        array_push(array, argument_count);
    }
    var value = FirebaseAuthentication_Get("email", array);
    if (is_undefined(value))
    {
        return "";
    }
    return value;
}

function FirebaseAuthentication_GetEmailVerified()
{
    var array = [];
    for (var a = 0; a < argument_count; a++)
    {
        array_push(array, argument_count);
    }
    var value = FirebaseAuthentication_Get("emailVerified", array);
    if (is_undefined(value))
    {
        return "";
    }
    return value;
}

function FirebaseAuthentication_GetDisplayName()
{
    var array = [];
    for (var a = 0; a < argument_count; a++)
    {
        array_push(array, argument_count);
    }
    var value = FirebaseAuthentication_Get("displayName", array);
    if (is_undefined(value))
    {
        return "";
    }
    return value;
}

function FirebaseAuthentication_GetProviderUserInfo()
{
    var array = [];
    for (var a = 0; a < argument_count; a++)
    {
        array_push(array, argument_count);
    }
    var return_array = [];
    var map = json_decode(FirebaseAuthentication_GetUserData_raw());
    if (ds_map_exists(map, "users"))
    {
        var ind = 0;
        if (array_length(array))
        {
            ind = argument[0];
        }
        var list = ds_map_find_value(map, "users");
        var user_map = ds_list_find_value(list, ind);
        if (ds_map_exists(user_map, "providerUserInfo"))
        {
            var list_providers = ds_map_find_value(user_map, "providerUserInfo");
            for (var a = 0; a < ds_list_size(list_providers); a++)
            {
                array_push(return_array, json_parse(json_encode(ds_list_find_value(list_providers, a))));
            }
        }
    }
    ds_map_destroy(map);
    return return_array;
}

function FirebaseAuthentication_GetPhotoUrl()
{
    var array = [];
    for (var a = 0; a < argument_count; a++)
    {
        array_push(array, argument_count);
    }
    var value = FirebaseAuthentication_Get("photoUrl", array);
    if (is_undefined(value))
    {
        return "";
    }
    return value;
}

function FirebaseAuthentication_GetUID()
{
    if (argument_count)
    {
        return FirebaseAuthentication_GetLocalId(argument[0]);
    }
    return FirebaseAuthentication_GetLocalId();
}

function FirebaseAuthentication_RecaptchaParams()
{
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_RecaptchaParams", 98, "https://identitytoolkit.googleapis.com/v1/recaptchaParams?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "GET", FirebaseREST_KeyValue("Content-Type", "application/json"), "");
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_SendVerificationCode(arg0, arg1)
{
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_SendVerificationCode", 98, "https://identitytoolkit.googleapis.com/v1/accounts:sendVerificationCode?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("phoneNumber", arg0, "recaptchaToken", arg1));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_SignInWithPhoneNumber(arg0, arg1, arg2)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_SignInWithPhoneNumber(arg0, arg1, arg2);
    }
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_SignInWithPhoneNumber_YYFirebaseCallback", 98, "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPhoneNumber?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("phoneNumber", arg0, "code", arg1, "sessionInfo", arg2));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_LinkWithPhoneNumber(arg0, arg1, arg2)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_LinkWithPhoneNumber(arg0, arg1, arg2);
    }
    var listener = FirebaseREST_asyncFunction_Authentication("FirebaseAuthentication_LinkWithPhoneNumber_YYFirebaseCallback", 98, "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPhoneNumber?key=" + extension_get_option_value("YYFirebaseAuthentication", "WebAPIKey"), "POST", FirebaseREST_KeyValue("Content-Type", "application/json"), FirebaseREST_KeyValue("phoneNumber", arg0, "code", arg1, "sessionInfo", arg2, "idToken", RESTFirebaseAuthentication_GetIdToken()));
    listener.dropListenerFromArgs = true;
    Firebase_Listener_SetErrorCountLimit_Authentication(listener, 0);
    return listener;
}

function FirebaseAuthentication_ReauthenticateWithEmail(arg0, arg1)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_ReauthenticateWithEmail(arg0, arg1);
    }
    var listener = SDKFirebaseAuthentication_SignIn_OAuth(arg0, arg1);
    listener.event = "FirebaseAuthentication_ReauthenticateWithEmail_YYFirebaseCallback";
    return listener;
}

function FirebaseAuthentication_ReauthenticateWithOAuth(arg0, arg1, arg2, arg3 = "")
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_ReauthenticateWithOAuth(arg0, arg1, arg2, arg3);
    }
    var listener = FirebaseAuthentication_SignIn_OAuth(arg0, arg1, arg2, arg3);
    listener.event = "FirebaseAuthentication_ReauthenticateWithOAuth_YYFirebaseCallback";
    return listener;
}

function FirebaseAuthentication_ReauthenticateWithPhoneNumber(arg0, arg1, arg2)
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_ReauthenticateWithPhoneNumber(arg0, arg1, arg2);
    }
    var listener = FirebaseAuthentication_SignInWithPhoneNumber(arg0, arg1, arg2);
    listener.event = "FirebaseAuthentication_ReauthenticateWithPhoneNumber_YYFirebaseCallback";
    return listener;
}

global.Listener_IdToken = false;

function FirebaseAuthentication_IdTokenListener()
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_IdTokenListener();
    }
    global.Listener_IdToken = true;
    var map = ds_map_create();
    ds_map_set(map, "type", "FirebaseAuthentication_IdTokenListener");
    ds_map_set(map, "listener", global.Listener_IdToken);
    ds_map_set(map, "status", 200);
    ds_map_set(map, "value", global.YYFirebaseIdToken);
    event_perform_async(ev_async_social, map);
    return global.Listener_IdToken;
}

function FirebaseAuthentication_IdTokenListener_Remove()
{
    if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
    {
        return SDKFirebaseAuthentication_IdTokenListener_Remove();
    }
    global.Listener_IdToken = false;
}
