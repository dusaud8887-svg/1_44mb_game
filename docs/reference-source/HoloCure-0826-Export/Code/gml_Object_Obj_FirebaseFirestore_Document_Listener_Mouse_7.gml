if (listener == -4)
{
    text = "Document Listener Remove";
    listener = FirebaseFirestore("Collection/Document").Listener();
}
else
{
    FirebaseFirestore().ListenerRemove(listener);
    listener = -4;
    text = "Document Listener";
}
