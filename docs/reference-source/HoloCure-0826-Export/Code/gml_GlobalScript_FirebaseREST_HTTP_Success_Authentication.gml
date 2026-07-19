function FirebaseREST_HTTP_Success_Authentication()
{
    switch (event)
    {
        default:
            RESTFirebase_asyncCall_Authentication();
            break;
        case "FirebaseAuthentication_RefreshUserData_YYFirebaseCallback":
        case "FirebaseAuthentication_ChangeEmail_YYFirebaseCallback":
        case "FirebaseAuthentication_ChangePassword_YYFirebaseCallback":
        case "FirebaseAuthentication_ChangeDisplayName_YYFirebaseCallback":
        case "FirebaseAuthentication_ChangePhotoURL_YYFirebaseCallback":
            without_userdata = true;
        case "RESTFirebaseAuthentication_RequestIDToken_YYFirebaseCallback":
        case "FirebaseAuthentication_SignInWithCustomToken_YYFirebaseCallback":
        case "FirebaseAuthentication_SignUp_Email_YYFirebaseCallback":
        case "FirebaseAuthentication_SignIn_Email_YYFirebaseCallback":
        case "FirebaseAuthentication_SignIn_Anonymously_YYFirebaseCallback":
        case "FirebaseAuthentication_SignIn_OAuth_YYFirebaseCallback":
        case "FirebaseAuthentication_SignInWithPhoneNumber_YYFirebaseCallback":
        case "FirebaseAuthentication_LinkWithPhoneNumber_YYFirebaseCallback":
        case "FirebaseAuthentication_LinkWithEmailPassword_YYFirebaseCallback":
        case "FirebaseAuthentication_LinkWithOAuthCredential_YYFirebaseCallback":
        case "FirebaseAuthentication_UpdateProfile_YYFirebaseCallback":
        case "FirebaseAuthentication_SignIn_GameCenter_YYFirebaseCallback":
        case "FirebaseAuthentication_ReauthenticateWithCustomToken_YYFirebaseCallback":
        case "FirebaseAuthentication_ReauthenticateWithEmail_YYFirebaseCallback":
        case "FirebaseAuthentication_ReauthenticateWithOAuth_YYFirebaseCallback":
        case "FirebaseAuthentication_ReauthenticateWithPhoneNumber_YYFirebaseCallback":
            var map = json_decode(ds_map_find_value(async_load, "result"));
            if (ds_map_exists(map, "id_token"))
            {
                ds_map_set(map, "expiresIn", ds_map_find_value(map, "expires_in"));
                ds_map_set(map, "refreshToken", ds_map_find_value(map, "refresh_token"));
                ds_map_set(map, "idToken", ds_map_find_value(map, "id_token"));
                ds_map_set(map, "localId", ds_map_find_value(map, "user_id"));
            }
            if (ds_map_exists(map, "idToken") && ds_map_exists(map, "expiresIn"))
            {
                if (variable_global_exists("YYFirebaseIdToken"))
                {
                    global.YYFirebaseIdToken = ds_map_find_value(map, "idToken");
                }
                Obj_FirebaseREST_Authentication.alarm[0] = real(ds_map_find_value(map, "expiresIn")) * room_speed * Obj_FirebaseREST_Authentication.expiresK;
                new_ds_map_secure_save(map, "Firebase.data");
                if (global.Listener_IdToken)
                {
                    map = ds_map_create();
                    ds_map_set(map, "type", "FirebaseAuthentication_IdTokenListener");
                    ds_map_set(map, "listener", global.Listener_IdToken);
                    ds_map_set(map, "status", 200);
                    ds_map_set(map, "value", global.YYFirebaseIdToken);
                    event_perform_async(ev_async_social, map);
                }
            }
            Firebase_Listerner_refreshTokenOnPath();
        case "FirebaseAuthentication_UnlinkProvider_YYFirebaseCallback":
        case "FirebaseAuthentication_ConfirmEmailVerification_YYFirebaseCallback":
            event = string_replace(event, "_YYFirebaseCallback", "");
            var listener = RESTFirebaseAuthentication_GetUserData();
            listener.event_ = event;
            if (variable_instance_exists(id, "without_userdata"))
            {
                listener.without_userdata = without_userdata;
            }
            listener.identifiquer = identifiquer;
            break;
        case "RESTFirebaseAuthentication_GetUserData":
            global.YYFirebaseUserData = ds_map_find_value(async_load, "result");
            var map = new_ds_map_secure_load("Firebase.data");
            ds_map_set(map, "UserData", global.YYFirebaseUserData);
            new_ds_map_secure_save(map, "Firebase.data");
            ds_map_destroy(map);
            map = -1;
            event = id.event_;
            if (variable_instance_exists(id, "without_userdata"))
            {
                RESTFirebase_asyncCall_Authentication();
            }
            else
            {
                RESTFirebase_asyncCall_Authentication(ds_map_find_value(async_load, "result"));
            }
            break;
        case "FirebaseAuthentication_RecaptchaParams":
        case "FirebaseAuthentication_SendVerificationCode":
        case "FirebaseAuthentication_Fetch_Providers":
        case "FirebaseAuthentication_SendPasswordResetEmail":
        case "FirebaseAuthentication_VerifyPasswordResetCode":
        case "FirebaseAuthentication_ConfirmPasswordReset":
        case "FirebaseAuthentication_SendEmailVerification":
            RESTFirebase_asyncCall_Authentication(ds_map_find_value(async_load, "result"));
            break;
        case "FirebaseAuthentication_DeleteAccount":
            FirebaseAuthentication_SignOut();
            RESTFirebase_asyncCall_Authentication();
            break;
    }
}
