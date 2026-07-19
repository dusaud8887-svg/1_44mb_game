event_inherited();
if (ds_map_find_value(async_load, "type") == "GooglePlayServices_RequestServerSideAccess")
{
    if (ds_map_find_value(async_load, "success"))
    {
        show_debug_message(json_encode(async_load));
        if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
        {
            token = ds_map_find_value(async_load, "accessToken");
            event_user(0);
            exit;
        }
        var header_map = json_decode(FirebaseREST_KeyValue("Content-Type", "application/x-www-form-urlencoded"));
        var body = "code=" + ds_map_find_value(async_load, "authCode") + "&client_id=" + client_id + "&client_secret=" + client_secret + "&redirect_uri=" + redirect_uri + "&grant_type=authorization_code";
        request = http_request("https://oauth2.googleapis.com/token", "POST", header_map, body);
        ds_map_destroy(header_map);
    }
}
