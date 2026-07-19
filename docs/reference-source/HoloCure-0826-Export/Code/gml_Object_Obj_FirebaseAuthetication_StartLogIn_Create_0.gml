if ((extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseAuthentication", "Config") == "SDKs_Only")
{
    instance_destroy();
    exit;
}
var auth_exists = RESTFirebaseAuthentication_RequestIDToken_FromCache();
if (auth_exists)
{
    show_debug_message("Requesting Start Authentication");
}
