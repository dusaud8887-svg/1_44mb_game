function FirebaseREST_Firestore_getURL(arg0)
{
    return FirebaseFirestore_Path_Join("https://firestore.googleapis.com/v1/projects/", extension_get_option_value("YYFirebaseFirestore", "ProjectID"), "/databases/(default)/documents/", arg0);
}
