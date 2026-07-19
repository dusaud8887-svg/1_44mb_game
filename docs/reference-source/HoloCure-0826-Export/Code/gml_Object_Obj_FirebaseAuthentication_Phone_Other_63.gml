if (ds_map_find_value(async_load, "status"))
{
    if (ds_map_find_value(async_load, "result") != "")
    {
        if (ds_map_find_value(async_load, "id") == request_phone)
        {
            phone = ds_map_find_value(async_load, "result");
            FirebaseAuthentication_SendVerificationCode(phone, recaptchaToken);
        }
        if (ds_map_find_value(async_load, "id") == request_code)
        {
            var code = ds_map_find_value(async_load, "result");
            if (FirebaseAuthentication_GetUID() == "")
            {
                FirebaseAuthentication_SignInWithPhoneNumber(phone, code, sessionInfo);
            }
            else
            {
                var reauthenticate = false;
                var array = FirebaseAuthentication_GetProviderUserInfo();
                for (var a = 0; a < array_length(array); a++)
                {
                    if (array[a].providerId == "phone")
                    {
                        reauthenticate = true;
                        break;
                    }
                }
                if (reauthenticate)
                {
                    FirebaseAuthentication_ReauthenticateWithPhoneNumber(phone, code, sessionInfo);
                }
                else
                {
                    FirebaseAuthentication_LinkWithPhoneNumber(phone, code, sessionInfo);
                }
            }
        }
    }
}
