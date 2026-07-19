event_inherited();
request = -4;
if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
{
    provider = "playgames.google.com";
    redirect_uri = "";
    token_kind = "serverAuthCode";
}
else
{
    provider = "google.com";
    redirect_uri = "https://yoyoplayservices-13954376.firebaseapp.com/__/auth/handler";
    token_kind = "id_token";
    client_id = "20722703459-a7si0v3inel7uaf69t4cemjo9h20ind7.apps.googleusercontent.com";
    client_secret = "ZdQS3ABKNLdlc9KUo_QHnLyy";
}
