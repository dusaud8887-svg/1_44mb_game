function FirebaseREST_asyncFunction_Firestore(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var ins = instance_create_depth(0, 0, 0, arg1);
    ins.event = arg0;
    ins.url = arg2;
    ins.method_ = arg3;
    ins.header_json = arg4;
    ins.body = arg5;
    ins.alarm[0] = 1;
    return ins;
}
