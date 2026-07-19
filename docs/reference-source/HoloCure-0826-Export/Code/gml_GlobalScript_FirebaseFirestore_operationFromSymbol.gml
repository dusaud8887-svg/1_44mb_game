function FirebaseFirestore_operationFromSymbol(arg0)
{
    switch (arg0)
    {
        case ">=":
            return "GREATER_THAN_OR_EQUAL";
        case ">":
            return "GREATER_THAN";
        case "<=":
            return "LESS_THAN_OR_EQUAL";
        case "<":
            return "LESS_THAN";
        case "==":
            return "EQUAL";
        case "!=":
            return "NOT_EQUAL";
        default:
            throw "[ERROR] Firestore: invalid query operation.";
    }
}
