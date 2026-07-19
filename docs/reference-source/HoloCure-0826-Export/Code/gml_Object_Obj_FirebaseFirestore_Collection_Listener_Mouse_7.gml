if (listener == -4)
{
    text = "Collection Listener Remove";
    listener = FirebaseFirestore("Collection").Listener();
}
else
{
    FirebaseFirestore().ListenerRemove(listener);
    listener = -4;
    text = "Collection Listener";
}
