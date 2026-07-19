function FirebaseFirestore(arg0 = undefined)
{
    return new Firebase_Firestore_builder(arg0);
}

function FirebaseFirestore_updatedPath(arg0)
{
    if (is_undefined(arg0))
    {
        _isDocument = false;
        _isCollection = false;
    }
    else if (FirebaseREST_Firestore_path_isDocument(arg0))
    {
        _isDocument = true;
        _isCollection = false;
    }
    else
    {
        _isDocument = false;
        _isCollection = true;
    }
}

function Firebase_Firestore_builder(arg0) constructor
{
    static Child = function(arg0)
    {
        _path = FirebaseFirestore_Path_Join(_path, arg0);
        FirebaseFirestore_updatedPath(_path);
        return self;
    };
    
    static Parent = function()
    {
        _path = FirebaseFirestore_Path_Back(_path, 1);
        return self;
    };
    
    static OrderBy = function(arg0)
    {
        if (!is_array(arg0))
        {
            show_message("OrderBy conditions must be an array!");
            return self;
        }
        _orderBy_conditions = array_create(array_length(arg0));
        for (var i = 0; i < array_length(arg0); i++)
        {
            _orderBy_conditions[i] = arg0[i];
        }
        return self;
    };
    
    static Where = function(arg0, arg1, arg2)
    {
        if (is_undefined(_operations))
        {
            _operations = [];
        }
        arg1 = FirebaseFirestore_operationFromSymbol(arg1);
        array_push(_operations, 
        {
            operation: arg1,
            path: arg0,
            value: arg2
        });
        return self;
    };
    
    static WhereEqual = function(arg0, arg1)
    {
        if (is_undefined(_operations))
        {
            _operations = [];
        }
        array_push(_operations, 
        {
            operation: "EQUAL",
            path: arg0,
            value: arg1
        });
        return self;
    };
    
    static WhereGreaterThan = function(arg0, arg1)
    {
        if (is_undefined(_operations))
        {
            _operations = [];
        }
        array_push(_operations, 
        {
            operation: "GREATER_THAN",
            path: arg0,
            value: arg1
        });
        return self;
    };
    
    static WhereGreaterThanOrEqual = function(arg0, arg1)
    {
        if (is_undefined(_operations))
        {
            _operations = [];
        }
        array_push(_operations, 
        {
            operation: "GREATER_THAN_OR_EQUAL",
            path: arg0,
            value: arg1
        });
        return self;
    };
    
    static WhereLessThan = function(arg0, arg1)
    {
        if (is_undefined(_operations))
        {
            _operations = [];
        }
        array_push(_operations, 
        {
            operation: "LESS_THAN_OR_EQUAL",
            path: arg0,
            value: arg1
        });
        return self;
    };
    
    static WhereLessThanOrEqual = function(arg0, arg1)
    {
        if (is_undefined(_operations))
        {
            _operations = [];
        }
        array_push(_operations, 
        {
            operation: "EQUAL",
            path: arg0,
            value: arg1
        });
        return self;
    };
    
    static WhereNotEqual = function(arg0, arg1)
    {
        if (is_undefined(_operations))
        {
            _operations = [];
        }
        array_push(_operations, 
        {
            operation: "NOT_EQUAL",
            path: arg0,
            value: arg1
        });
        return self;
    };
    
    static StartAt = function(arg0)
    {
        _start = arg0;
        return self;
    };
    
    static EndAt = function(arg0)
    {
        _end = arg0;
        return self;
    };
    
    static Limit = function(arg0)
    {
        _limit = arg0;
        return self;
    };
    
    static Set = function(arg0)
    {
        _action = "Set";
        _value = arg0;
        if ((extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_Only")
        {
            return FirebaseFirestore_SDK(json_stringify(self));
        }
        if (FirebaseREST_Firestore_path_isDocument(_path))
        {
            return RESTFirebaseFirestore_Document_Set(_path, arg0);
        }
        else
        {
            return RESTFirebaseFirestore_Collection_Add(_path, arg0);
        }
    };
    
    static Update = function(arg0)
    {
        _action = "Update";
        _value = arg0;
        if ((extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_Only")
        {
            return FirebaseFirestore_SDK(json_stringify(self));
        }
        if (FirebaseREST_Firestore_path_isDocument(_path))
        {
            return RESTFirebaseFirestore_Document_Update(_path, arg0);
        }
        else
        {
            show_debug_message("Firestore: You can't update a Collection");
            exit;
        }
    };
    
    static Read = function()
    {
        _action = "Read";
        if ((extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_Only")
        {
            return FirebaseFirestore_SDK(json_stringify(self));
        }
        if (FirebaseREST_Firestore_path_isDocument(_path))
        {
            return RESTFirebaseFirestore_Document_Read(_path);
        }
        else
        {
            return RESTFirebaseFirestore_Collection_Read(_path);
        }
    };
    
    static Query = function()
    {
        _action = "Query";
        if ((extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_Only")
        {
            return FirebaseFirestore_SDK(json_stringify(self));
        }
        if (FirebaseREST_Firestore_path_isCollection(_path))
        {
            return RESTFirebaseFirestore_Collection_Query(self);
        }
        else
        {
            show_debug_message("Firestore: You can't query documents");
        }
    };
    
    static Listener = function()
    {
        _action = "Listener";
        if ((extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_Only")
        {
            return FirebaseFirestore_SDK(json_stringify(self));
        }
        if (FirebaseREST_Firestore_path_isDocument(_path))
        {
            return RESTFirebaseFirestore_Document_Listener(_path);
        }
        else
        {
            return RESTFirebaseFirestore_Collection_Listener(_path);
        }
    };
    
    static Delete = function()
    {
        _action = "Delete";
        if ((extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_Only")
        {
            return FirebaseFirestore_SDK(json_stringify(self));
        }
        if (FirebaseREST_Firestore_path_isDocument(_path))
        {
            return RESTFirebaseFirestore_Document_Delete(_path);
        }
        else
        {
            show_debug_message("Firestore: You can't delete a Collection");
            exit;
        }
    };
    
    static ListenerRemove = function(arg0)
    {
        _action = "ListenerRemove";
        _value = arg0;
        if ((extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_Only")
        {
            return FirebaseFirestore_SDK(json_stringify(self));
        }
        with (arg0)
        {
            instance_destroy();
        }
    };
    
    static ListenerRemoveAll = function()
    {
        _action = "ListenerRemoveAll";
        if ((extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_When_Available" && (os_type == os_android || os_type == os_ios || false)) || extension_get_option_value("YYFirebaseFirestore", "Config") == "SDKs_Only")
        {
            return FirebaseFirestore_SDK(json_stringify(self));
        }
        with (Obj_FirebaseREST_Listener_Firestore)
        {
            if (string_count("Listener", event))
            {
                instance_destroy();
            }
        }
    };
    
    _path = arg0;
    _operations = undefined;
    _orderBy_field = undefined;
    _orderBy_direction = undefined;
    _orderBy_conditions = undefined;
    _start = undefined;
    _end = undefined;
    _limit = undefined;
    _action = "";
    _value = undefined;
    FirebaseFirestore_updatedPath(_path);
}
