event_inherited();
switch (ds_map_find_value(async_load, "type"))
{
    case "GameCenter_Authenticate":
        if (ds_map_find_value(async_load, "success"))
        {
            if (FirebaseAuthentication_GetUserData_raw() == "{}")
            {
                SDKFirebaseAuthentication_SignIn_GameCenter();
            }
            else
            {
                var reauthenticate = false;
                var array = FirebaseAuthentication_GetProviderUserInfo();
                for (var a = 0; a < array_length(array); a++)
                {
                    if (array[a].providerId == provider)
                    {
                        reauthenticate = true;
                        break;
                    }
                }
                if (reauthenticate)
                {
                    SDKFirebaseAuthentication_ReauthenticateWithGameCenter();
                }
                else
                {
                    SDKFirebaseAuthentication_LinkWithGameCenter();
                }
            }
            exit;
            GameCenter_FetchItemsForIdentityVerificationSignature();
        }
        break;
    case "GameCenter_FetchItemsForIdentityVerificationSignature":
        show_debug_message("GameCenter: " + json_encode(async_load));
        var map = json_decode(GameCenter_LocalPlayer_GetInfo());
        var displayName = ds_map_find_value(map, "displayName");
        var playerId = ds_map_find_value(map, "playerID");
        show_debug_message("displayName: " + displayName);
        show_debug_message("playerId: " + playerId);
        ds_map_destroy(map);
        var publicKeyURL = ds_map_find_value(async_load, "publicKeyURL");
        var signature = ds_map_find_value(async_load, "signature");
        var salt = ds_map_find_value(async_load, "salt");
        var timestamp = ds_map_find_value(async_load, "timestamp");
        FirebaseAuthentication_SignIn_GameCenter("com.yoyogames.yygfirebase", playerId, publicKeyURL, signature, salt, timestamp, RESTFirebaseAuthentication_GetIdToken(), displayName, function(arg0, arg1, arg2)
        {
            show_debug_message("SignIn_GameCenter: " + json_encode(async_load));
            var ins = instance_create_depth(0, 0, 0, Obj_Debug_FallText_Authentication);
            ins.text = arg0 + "-" + string(arg1) + " -> " + string(arg2);
            ins.color = (arg1 == 200) ? 16777215 : 255;
        });
        break;
}
