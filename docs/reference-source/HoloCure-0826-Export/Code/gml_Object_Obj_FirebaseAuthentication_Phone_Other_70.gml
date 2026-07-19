switch (ds_map_find_value(async_load, "type"))
{
    case "FirebaseAuthentication_Tools_WebView_onUserClose":
        if (os_type == os_android || os_type == os_ios)
        {
            extension_stubfunc_string();
        }
        break;
    case "FirebaseAuthentication_Tools_WebView_onCloseWindow":
        break;
    case "FirebaseRealTime_Delete":
        if (ds_map_find_value(async_load, "listener") == request_recatch_delete)
        {
            FirebaseAuthentication_RecaptchaParams();
        }
        break;
    case "FirebaseAuthentication_RecaptchaParams":
        if (ds_map_find_value(async_load, "status") == 200)
        {
            listener_reCaptcha = FirebaseRealTime().Path("reCaptcha/" + request_reCaptcha_web).Listener();
            var map = json_decode(ds_map_find_value(async_load, "value"));
            var recaptchaSiteKey = ds_map_find_value(map, "recaptchaSiteKey");
            ds_map_destroy(map);
            map = -1;
            var url = "https://yoyoplayservices-13954376.web.app/";
            url = url + "?recaptchaSiteKey=" + recaptchaSiteKey + "&uid=" + request_reCaptcha_web;
            switch (os_type)
            {
                case os_android:
                case os_ios:
                    extension_stubfunc_string(url);
                    break;
                default:
                    url_open(url);
                    break;
            }
        }
        break;
    case "FirebaseRealTime_Listener":
        if (listener_reCaptcha == ds_map_find_value(async_load, "listener"))
        {
            if (ds_map_exists(async_load, "value"))
            {
                if (!is_undefined(ds_map_find_value(async_load, "value")))
                {
                    recaptchaToken = ds_map_find_value(async_load, "value");
                    request_phone = get_string_async("Phone:", "");
                    FirebaseRealTime().Path("reCaptcha/" + request_reCaptcha_web).Delete();
                    FirebaseRealTime().ListenerRemove(listener_reCaptcha);
                    listener_reCaptcha = -4;
                    if (os_type == os_android || os_type == os_ios)
                    {
                        extension_stubfunc_string();
                    }
                }
            }
        }
        break;
    case "FirebaseAuthentication_SendVerificationCode":
        if (ds_map_find_value(async_load, "status") == 200)
        {
            var map = json_decode(ds_map_find_value(async_load, "value"));
            sessionInfo = ds_map_find_value(map, "sessionInfo");
            ds_map_destroy(map);
            map = -1;
            request_code = get_string_async("Code:", "");
        }
        break;
    case "FirebaseAuthentication_SignInWithPhoneNumber":
    case "FirebaseAuthentication_LinkWithPhoneNumber":
        if (ds_map_find_value(async_load, "status") == 200)
        {
            show_debug_message("Phone Auth Done");
        }
        else
        {
            show_debug_message("Phone Auth Failed");
        }
        break;
}
