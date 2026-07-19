__input_initialize();

function __input_initialize()
{
    static _initialized = false;
    
    if (_initialized)
    {
        exit;
    }
    _initialized = true;
    var _global = __input_global();
    _global.__debug_log = "input___" + string_replace_all(string_replace_all(date_datetime_string(date_current_datetime()), ":", "-"), " ", "___") + ".txt";
    __input_trace("Welcome to Input by @jujuadams and @offalynne! This is version ", "6.0.1 Beta", ", ", "2023-05-11");
    _global.__use_is_instanceof = !(false || os_type == os_gxgames) && string_copy("2023.4.0.113", 1, 4) == "2023";
    _global.__use_legacy_strings = string_copy("2023.4.0.113", 1, 8) == "2022.0.0";
    if (_global.__use_is_instanceof)
    {
        __input_trace("On runtime ", "2023.4.0.113", ", using is_instanceof()");
    }
    if (!_global.__use_legacy_strings)
    {
        __input_trace("Using new string functions");
    }
    _global.__time_source = time_source_create(time_source_global, 1, time_source_units_frames, function()
    {
        if (!instance_exists(input_controller_object))
        {
            instance_activate_object(input_controller_object);
            if (instance_exists(input_controller_object))
            {
                __input_trace("Warning! input_controller_object has been deactivated. Please ensure that input_controller_object is never deactivated. You may need to use instance_activate_object(input_controller_object)");
            }
            else
            {
                static _created = false;
                
                if (!_created)
                {
                    _created = true;
                }
                else
                {
                    __input_trace("Warning! input_controller_object has been destroyed. Please ensure that input_controller_object is never destroyed");
                }
                instance_create_depth(0, 0, 0, input_controller_object);
            }
        }
        if (!input_controller_object.persistent)
        {
            __input_trace("Warning! input_controller_object has been set as non-persistent. Please ensure that input_controller_object is always persistent");
            input_controller_object.persistent = true;
        }
    }, [], -1);
    time_source_start(_global.__time_source);
    if ((string_pos("127.0.0.1", parameter_string(0)) > 0 || string_pos("localhost", parameter_string(0)) > 0) && false)
    {
        show_message("Due to changes in security policy, some browsers may not permit the use of gamepads when testing locally.\n \nPlease host on a remote web service (itch.io, GX.games, etc.) if you are encountering problems.");
    }
    if (false && os_type == os_gxgames)
    {
        show_message("Due to changes in security policy, some browsers may not permit the use of gamepads when testing locally.\n \nPlease host on a remote web service (itch.io, GX.games, etc.) if you are encountering problems.");
    }
    _global.__frame = 0;
    _global.__current_time = current_time;
    _global.__previous_current_time = current_time;
    _global.__cleared = false;
    _global.__window_focus = true;
    _global.__toggle_momentary_dict = {};
    _global.__toggle_momentary_state = false;
    _global.__cooldown_dict = {};
    _global.__cooldown_state = false;
    _global.__tap_presses = 0;
    _global.__tap_releases = 0;
    _global.__tap_click = false;
    _global.__pointer_index = 0;
    _global.__pointer_index_previous = 0;
    _global.__pointer_pressed = false;
    _global.__pointer_released = false;
    _global.__pointer_pressed_index = undefined;
    _global.__pointer_durations = array_create(11, 0);
    _global.__pointer_coord_space = UnknownEnum.Value_0;
    _global.__pointer_x = array_create(UnknownEnum.Value_3, 0);
    _global.__pointer_y = array_create(UnknownEnum.Value_3, 0);
    _global.__pointer_dx = array_create(UnknownEnum.Value_3, 0);
    _global.__pointer_dy = array_create(UnknownEnum.Value_3, 0);
    _global.__pointer_moved = false;
    _global.__mouse_capture = false;
    _global.__mouse_capture_blocked = false;
    _global.__mouse_capture_sensitivity = 1;
    _global.__mouse_capture_frame = 0;
    _global.__strict_binding_check = false;
    _global.__any_keyboard_binding_defined = false;
    _global.__any_mouse_binding_defined = false;
    _global.__any_touch_binding_defined = false;
    _global.__any_gamepad_binding_defined = false;
    _global.__keyboard_allowed = (((os_type == os_macosx || os_type == os_linux || os_type == os_windows) || (false || os_type == os_gxgames) || os_type == os_switch) || os_type == os_android) && (os_type != os_android || false) && (os_type != os_switch || false);
    _global.__mouse_allowed_on_platform = !(os_type == os_xboxone || os_type == os_gdk) && (!(1 && ((os_type == os_android || (os_type == os_ios || os_type == os_tvos)) || os_type == os_switch || (false && os_type == os_windows))) || (false && (1 && ((os_type == os_android || (os_type == os_ios || os_type == os_tvos)) || os_type == os_switch || (false && os_type == os_windows)))) || (false && (os_type == os_ps4 || os_type == os_ps5)));
    _global.__vibration_allowed_on_platform = (((os_type == os_xboxone || os_type == os_gdk) || (os_type == os_ps4 || os_type == os_ps5) || os_type == os_switch) || (!(false || os_type == os_gxgames) && os_type == os_windows)) && true && (os_type != os_switch || true) && (os_type != os_ps5 || true);
    _global.__window_focus_block_mouse = false;
    _global.__window_focus_frame = -infinity;
    _global.__cursor_verbs_valid = false;
    _global.__swap_ab = false;
    _global.__all_verb_dict = {};
    _global.__all_verb_array = [];
    _global.__basic_verb_dict = {};
    _global.__basic_verb_array = [];
    _global.__chord_verb_dict = {};
    _global.__chord_verb_array = [];
    _global.__key_name_dict = {};
    _global.__ignore_key_dict = {};
    _global.__ignore_gamepad_types = {};
    _global.__virtual_array = [];
    _global.__virtual_background = input_virtual_create().priority(-infinity);
    _global.__virtual_background.__background = true;
    _global.__virtual_order_dirty = false;
    _global.__touch_player = undefined;
    _global.__players_status = 
    {
        any_changed: false,
        new_connections: [],
        new_disconnections: [],
        players: array_create(4, UnknownEnum.Value_0)
    };
    _global.__gamepads_status = 
    {
        any_changed: false,
        new_connections: [],
        new_disconnections: [],
        gamepads: array_create(12, UnknownEnum.Value_0)
    };
    _global.__default_player = new __input_class_player();
    _global.__players = array_create(4, undefined);
    var _p = 0;
    repeat (4)
    {
        with (new __input_class_player())
        {
            _global.__players[_p] = self;
            __index = _p;
        }
        _p++;
    }
    _global.__source_mode = undefined;
    _global.__previous_source_mode = UnknownEnum.Value_2;
    _global.__hotswap_callback = undefined;
    _global.__join_player_min = 1;
    _global.__join_player_max = 4;
    _global.__join_leave_verb = "cancel";
    _global.__join_abort_callback = undefined;
    _global.__join_drop_down = true;
    _global.__gamepads = array_create(12, undefined);
    _global.__sdl2_database = 
    {
        by_guid: {},
        by_vendor_product: {},
        by_description: {}
    };
    _global.__sdl2_look_up_table = 
    {
        a: 32769,
        b: 32770,
        x: 32771,
        y: 32772,
        dpup: 32781,
        dpdown: 32782,
        dpleft: 32783,
        dpright: 32784,
        leftx: 32785,
        lefty: 32786,
        rightx: 32787,
        righty: 32788,
        leftshoulder: 32773,
        rightshoulder: 32774,
        lefttrigger: 32775,
        righttrigger: 32776,
        leftstick: 32779,
        rightstick: 32780,
        start: 32778,
        back: 32777
    };
    _global.__sdl2_look_up_table.guide = 32889;
    _global.__sdl2_look_up_table.misc1 = 32890;
    _global.__sdl2_look_up_table.touchpad = 32891;
    _global.__sdl2_look_up_table.paddle1 = 32892;
    _global.__sdl2_look_up_table.paddle2 = 32893;
    _global.__sdl2_look_up_table.paddle3 = 32894;
    _global.__sdl2_look_up_table.paddle4 = 32895;
    if (!(!(false || os_type == os_gxgames) && ((os_type == os_macosx || os_type == os_linux || os_type == os_windows) || os_type == os_android)) || 0)
    {
        __input_trace("Skipping loading SDL database");
    }
    else
    {
        if (file_exists("sdl2.txt"))
        {
            __input_load_sdl2_from_file("sdl2.txt");
        }
        else
        {
            __input_trace("Warning! \"", "sdl2.txt", "\" not found in Included Files");
        }
        var _external_string = environment_get_variable("SDL_GAMECONTROLLERCONFIG");
        if (_external_string != "")
        {
            __input_trace("External SDL2 string found");
            try
            {
                __input_load_sdl2_from_string(_external_string);
            }
            catch (_error)
            {
                __input_trace_loud("Error!\n\n%SDL_GAMECONTROLLERCONFIG% could not be parsed.\nYou may see unexpected behaviour when using gamepads.\n\nTo remove this error, clear %SDL_GAMECONTROLLERCONFIG%\n\nInput ", "6.0.1 Beta", "   @jujuadams and @offalynne ", "2023-05-11");
            }
        }
    }
    __input_define_gamepad_types();
    _global.__raw_type_dictionary = {};
    if (((os_type == os_xboxone || os_type == os_gdk) || (os_type == os_ps4 || os_type == os_ps5) || os_type == os_switch) || os_type == os_gxgames || (os_type == os_ios || os_type == os_tvos))
    {
        __input_trace("Skipping loading controller type database");
    }
    else if (file_exists("controllertypes.csv"))
    {
        __input_load_type_csv("controllertypes.csv");
    }
    else
    {
        __input_trace("Warning! \"", "controllertypes.csv", "\" not found in Included Files");
    }
    _global.__blacklist_dictionary = {};
    if (!(!(false || os_type == os_gxgames) && ((os_type == os_macosx || os_type == os_linux || os_type == os_windows) || os_type == os_android)))
    {
        __input_trace("Skipping loading controller blacklist database");
    }
    else if (file_exists("controllerblacklist.csv"))
    {
        __input_load_blacklist_csv("controllerblacklist.csv");
    }
    else
    {
        __input_trace("Warning! \"", "controllerblacklist.csv", "\" not found in Included Files");
    }
    _global.__gamepad_led_pattern_dict = 
    {
        ps5: [[false, false, true, false, false], [false, true, false, true, false], [true, false, true, false, true], [true, true, false, true, true]],
        switch: [[true, false, false, false], [true, true, false, false], [true, true, true, false], [true, true, true, true], [true, false, false, true], [true, false, true, false], [true, false, true, true], [false, true, true, false]],
        "xbox 360": [[true, false, false, false], [false, true, false, false], [false, false, true, false], [false, false, false, true]]
    };
    __input_key_name_set((os_type == os_macosx) ? 50 : ((os_type == os_linux) ? 223 : 192), "`");
    __input_key_name_set((os_type == os_switch || (os_type == os_macosx && !(false || os_type == os_gxgames))) ? 109 : 189, "-");
    __input_key_name_set((os_type == os_macosx && !(false || os_type == os_gxgames)) ? 24 : 187, "=");
    __input_key_name_set(186, ";");
    __input_key_name_set((os_type == os_macosx && !(false || os_type == os_gxgames)) ? 192 : 222, "'");
    __input_key_name_set(188, ",");
    __input_key_name_set((os_type == os_switch) ? 110 : 190, ".");
    __input_key_name_set(221, "]");
    __input_key_name_set(219, "[");
    __input_key_name_set(191, "/");
    __input_key_name_set(220, "\\");
    __input_key_name_set(145, "scroll lock");
    __input_key_name_set(20, "caps lock");
    __input_key_name_set(((os_type == os_macosx || (os_type == os_ios || os_type == os_tvos)) && (false || os_type == os_gxgames)) ? 12 : 144, "num lock");
    __input_key_name_set((os_type == os_macosx) ? 92 : 91, "left meta");
    __input_key_name_set((os_type == os_macosx) ? (((os_type == os_macosx || (os_type == os_ios || os_type == os_tvos)) && (false || os_type == os_gxgames)) ? 93 : 91) : 92, "right meta");
    __input_key_name_set(12, "clear");
    __input_key_name_set(93, "menu");
    __input_key_name_set(44, "print screen");
    __input_key_name_set(19, "pause break");
    __input_key_name_set(27, "escape");
    __input_key_name_set(8, "backspace");
    __input_key_name_set(32, "space");
    __input_key_name_set(13, "enter");
    __input_key_name_set(38, "arrow up");
    __input_key_name_set(40, "arrow down");
    __input_key_name_set(37, "arrow left");
    __input_key_name_set(39, "arrow right");
    __input_key_name_set(9, "tab");
    __input_key_name_set(165, "right alt");
    __input_key_name_set(164, "left alt");
    __input_key_name_set(18, "alt");
    __input_key_name_set(161, "right shift");
    __input_key_name_set(160, "left shift");
    __input_key_name_set(16, "shift");
    __input_key_name_set(163, "right ctrl");
    __input_key_name_set(162, "left ctrl");
    __input_key_name_set(17, "ctrl");
    __input_key_name_set(112, "f1");
    __input_key_name_set(113, "f2");
    __input_key_name_set(114, "f3");
    __input_key_name_set(115, "f4");
    __input_key_name_set(116, "f5");
    __input_key_name_set(117, "f6");
    __input_key_name_set(118, "f7");
    __input_key_name_set(119, "f8");
    __input_key_name_set(120, "f9");
    __input_key_name_set(121, "f10");
    __input_key_name_set(122, "f11");
    __input_key_name_set(123, "f12");
    __input_key_name_set(111, "numpad /");
    __input_key_name_set(106, "numpad *");
    __input_key_name_set(109, "numpad -");
    __input_key_name_set(107, "numpad +");
    __input_key_name_set(110, "numpad .");
    __input_key_name_set(96, "numpad 0");
    __input_key_name_set(97, "numpad 1");
    __input_key_name_set(98, "numpad 2");
    __input_key_name_set(99, "numpad 3");
    __input_key_name_set(100, "numpad 4");
    __input_key_name_set(101, "numpad 5");
    __input_key_name_set(102, "numpad 6");
    __input_key_name_set(103, "numpad 7");
    __input_key_name_set(104, "numpad 8");
    __input_key_name_set(105, "numpad 9");
    __input_key_name_set(46, "delete");
    __input_key_name_set(45, "insert");
    __input_key_name_set(36, "home");
    __input_key_name_set(33, "page up");
    __input_key_name_set(34, "page down");
    __input_key_name_set(35, "end");
    __input_key_name_set(10, variable_struct_get(_global.__key_name_dict, 13));
    if (os_type == os_switch || os_type == os_linux || os_type == os_macosx)
    {
        __input_key_name_set(128, "f11");
        __input_key_name_set(129, "f12");
    }
    if (os_type == os_windows || (false || os_type == os_gxgames))
    {
        for (var _i = 124; _i < 144; _i++)
        {
            __input_key_name_set(_i, "f" + string(_i));
        }
    }
    if (os_type == os_switch)
    {
        for (var _i = 2; _i <= 7; _i++)
        {
            __input_key_name_set(_i, __input_key_get_name(ord(_i)));
        }
    }
    input_ignore_key_add(18);
    input_ignore_key_add(165);
    input_ignore_key_add(164);
    input_ignore_key_add((os_type == os_macosx) ? 92 : 91);
    input_ignore_key_add((os_type == os_macosx) ? (((os_type == os_macosx || (os_type == os_ios || os_type == os_tvos)) && (false || os_type == os_gxgames)) ? 93 : 91) : 92);
    input_ignore_key_add(255);
    if ((os_type == os_android || (os_type == os_ios || os_type == os_tvos)) && (os_type == os_macosx || (os_type == os_ios || os_type == os_tvos)))
    {
        input_ignore_key_add(124);
    }
    if (false || os_type == os_gxgames)
    {
        if (os_type == os_macosx || (os_type == os_ios || os_type == os_tvos))
        {
            input_ignore_key_add(121);
            input_ignore_key_add(20);
        }
        else
        {
            input_ignore_key_add(122);
        }
    }
    input_ignore_key_add(((os_type == os_macosx || (os_type == os_ios || os_type == os_tvos)) && (false || os_type == os_gxgames)) ? 12 : 144);
    input_ignore_key_add(145);
    if ((false || os_type == os_gxgames) || os_type == os_windows)
    {
        input_ignore_key_add(21);
        input_ignore_key_add(22);
        input_ignore_key_add(23);
        input_ignore_key_add(24);
        input_ignore_key_add(25);
        input_ignore_key_add(26);
        input_ignore_key_add(28);
        input_ignore_key_add(29);
        input_ignore_key_add(30);
        input_ignore_key_add(31);
        input_ignore_key_add(229);
        input_ignore_key_add(166);
        input_ignore_key_add(167);
        input_ignore_key_add(168);
        input_ignore_key_add(169);
        input_ignore_key_add(170);
        input_ignore_key_add(171);
        input_ignore_key_add(172);
        input_ignore_key_add(173);
        input_ignore_key_add(174);
        input_ignore_key_add(175);
        input_ignore_key_add(176);
        input_ignore_key_add(177);
        input_ignore_key_add(178);
        input_ignore_key_add(179);
        input_ignore_key_add(180);
        input_ignore_key_add(181);
        input_ignore_key_add(182);
        input_ignore_key_add(183);
        input_ignore_key_add(251);
    }
    _global.__steam_switch_labels = false;
    _global.__using_steamworks = false;
    _global.__on_steam_deck = false;
    _global.__on_wine = false;
    _global.__steam_handles = [];
    _global.__steam_type_to_raw = {};
    _global.__steam_type_to_name = {};
    _global.__steam_trigger_mode = {};
    if (((os_type == os_windows || os_type == os_linux) && !(false || os_type == os_gxgames)) && true)
    {
        try
        {
            _global.__using_steamworks = extension_stubfunc_real(true);
            _global.__on_steam_deck = extension_stubfunc_real();
        }
        catch (_error)
        {
            __input_trace("Steamworks extension unavailable");
        }
        if (_global.__using_steamworks && string(extension_stubfunc_real()) == "480")
        {
            __input_trace_loud("Error!\nSteamworks extension incorrectly configured (Application ID 480).\nYou may see unexpected behaviour when using gamepads.\n\nTo remove this error, set Application ID.\n\nInput ", "6.0.1 Beta", "   @jujuadams and @offalynne ", "2023-05-11");
        }
    }
    if (!_global.__on_steam_deck)
    {
        var _map = os_get_info();
        if (ds_exists(_map, ds_type_map))
        {
            var _identifier = undefined;
            if (os_type == os_linux)
            {
                _identifier = ds_map_find_value(_map, "gl_renderer_string");
            }
            if (os_type == os_windows)
            {
                _identifier = ds_map_find_value(_map, "video_adapter_description");
            }
            if (_identifier != undefined && __input_string_contains(_identifier, "AMD Custom GPU 04"))
            {
                _global.__on_steam_deck = true;
            }
            ds_map_destroy(_map);
        }
    }
    var _switch_labels = environment_get_variable("SDL_GAMECONTROLLER_USE_BUTTON_LABELS");
    if (_switch_labels != "")
    {
        _global.__steam_switch_labels = _switch_labels == "1";
    }
    else
    {
        _global.__steam_switch_labels = _global.__on_steam_deck;
    }
    if (_global.__using_steamworks)
    {
        _global.__on_wine = environment_get_variable("WINEDLLPATH") != "";
        __input_steam_type_set(2, "XBox360Controller", "Xbox 360 Controller");
        __input_steam_type_set(3, "XBoxOneController", "Xbox One Controller");
        __input_steam_type_set(12, "PS3Controller", "PS3 Controller");
        __input_steam_type_set(5, "PS4Controller", "PS4 Controller");
        __input_steam_type_set(13, "PS5Controller", "PS5 Controller");
        __input_steam_type_set(1, "SteamController", "Steam Controller");
        __input_steam_type_set(14, "CommunityDeck", "Steam Deck Controller");
        __input_steam_type_set(11, "MobileTouch", "Steam Link");
        if (_global.__steam_switch_labels)
        {
            __input_steam_type_set(10, "XBox360Controller", "Switch Pro Controller");
            __input_steam_type_set(9, "XBox360Controller", "Joy-Con");
            __input_steam_type_set(8, "XBox360Controller", "Joy-Con Pair");
        }
        else
        {
            __input_steam_type_set(10, "SwitchProController", "Switch Pro Controller");
            __input_steam_type_set(9, "SwitchJoyConSingle", "Joy-Con");
            __input_steam_type_set(8, "SwitchJoyConPair", "Joy-Con Pair");
        }
        __input_steam_type_set("unknown", "UnknownNonSteamController", "Controller");
        variable_struct_set(_global.__steam_trigger_mode, string(UnknownEnum.Value_0), 0);
        variable_struct_set(_global.__steam_trigger_mode, string(UnknownEnum.Value_1), 1);
        variable_struct_set(_global.__steam_trigger_mode, string(UnknownEnum.Value_2), 2);
        variable_struct_set(_global.__steam_trigger_mode, string(UnknownEnum.Value_3), 3);
    }
    if (os_type == os_linux || os_type == os_macosx)
    {
        var _os = (os_type == os_macosx) ? "macos" : "linux";
        var _id = (os_type == os_macosx) ? "030000005e0400008e02000001000000" : "03000000de280000ff11000001000000";
        var _blacklist_os = is_struct(_global.__blacklist_dictionary) ? variable_struct_get(_global.__blacklist_dictionary, _os) : undefined;
        var _blacklist_id = is_struct(_blacklist_os) ? variable_struct_get(_blacklist_os, "guid") : undefined;
        if (is_struct(_blacklist_os) && _blacklist_id == undefined)
        {
            variable_struct_set(_blacklist_os, "guid", {});
            _blacklist_id = is_struct(_blacklist_os) ? variable_struct_get(_blacklist_os, "guid") : undefined;
        }
        if (is_struct(_blacklist_id))
        {
            variable_struct_set(_blacklist_id, _id, true);
        }
        var _steam_environ = environment_get_variable("SteamEnv");
        var _steam_configs = environment_get_variable("EnableConfiguratorSupport");
        if (os_type == os_linux && ((_steam_environ != "" && _steam_environ == "1") || _global.__using_steamworks) && _steam_configs != "" && _steam_configs == string_digits(_steam_configs))
        {
            if (is_struct(_blacklist_id))
            {
                variable_struct_remove(_blacklist_id, _id);
            }
            var _bitmask = real(_steam_configs);
            var _steam_ps = _bitmask & 1;
            var _steam_xbox = _bitmask & 2;
            var _steam_generic = _bitmask & 4;
            var _steam_switch = _bitmask & 8;
            var _ignore_list = [];
            if (_global.__using_steamworks || environment_get_variable("SDL_GAMECONTROLLER_IGNORE_DEVICES") == "")
            {
                if (_steam_ps)
                {
                    array_push(_ignore_list, "psx", "ps4", "ps5");
                }
                if (_steam_xbox)
                {
                    array_push(_ignore_list, "xbox 360", "xbox one");
                }
                if (_steam_switch)
                {
                    array_push(_ignore_list, "switch", "switch joycon left", "switch joycon right");
                }
                if (_steam_generic)
                {
                    array_push(_ignore_list, "gamecube", "unknown");
                }
                var _i = 0;
                repeat (array_length(_ignore_list))
                {
                    variable_struct_set(_global.__ignore_gamepad_types, array_get(_ignore_list, _i), true);
                    _i++;
                }
            }
            if (!_steam_generic && !_steam_ps && (!_steam_switch || _global.__steam_switch_labels))
            {
                variable_struct_set(_global.__simple_type_lookup, "CommunitySteam", _default_xbox_type);
                __input_trace("Steam Input configuration indicates Xbox-like identity for virtual controllers");
            }
        }
    }
    var _locale = os_get_language() + "-" + os_get_region();
    switch (_locale)
    {
        case "en-US":
        case "en-":
        case "en-GB":
        case "-":
            __input_global().__keyboard_locale = "QWERTY";
            break;
        case "ar-DZ":
        case "ar-MA":
        case "ar-TN":
        case "fr-BE":
        case "fr-FR":
        case "fr-MC":
        case "co-FR":
        case "oc-FR":
        case "ff-SN":
        case "wo-SN":
        case "gsw-FR":
        case "nl-BE":
        case "tzm-DZ":
            __input_global().__keyboard_locale = "AZERTY";
            break;
        case "cs-CZ":
        case "de-AT":
        case "de-CH":
        case "de-DE":
        case "de-LI":
        case "de-LU":
        case "fr-CH":
        case "fr-LU":
        case "sq-AL":
        case "hr-BA":
        case "hr-HR":
        case "hu-HU":
        case "lb-LU":
        case "rm-CH":
        case "sk-SK":
        case "sl-SI":
        case "dsb-DE":
        case "sr-BA":
        case "hsb-DE":
            __input_global().__keyboard_locale = "QWERTZ";
            break;
        default:
            __input_global().__keyboard_locale = "QWERTY";
            break;
    }
    if (((os_type == os_xboxone || os_type == os_gdk) || (os_type == os_ps4 || os_type == os_ps5) || os_type == os_switch) || ((false || os_type == os_gxgames) && !(os_type == os_macosx || os_type == os_linux || os_type == os_windows)))
    {
        __input_global().__keyboard_type = "async";
    }
    else if (os_type == os_android || (os_type == os_ios || os_type == os_tvos))
    {
        __input_global().__keyboard_type = "virtual";
        if (os_type == os_android)
        {
            var _map = os_get_info();
            if (ds_exists(_map, ds_type_map))
            {
                var _device = string(ds_map_find_value(_map, "DEVICE"));
                if (string_pos("_cheets", _device) > 1 || (string_pos("cheets_", _device) > 0 && string_pos("cheets_", _device) < (string_length(_device) - 6)))
                {
                    __input_global().__keyboard_type = "keyboard";
                }
                ds_map_destroy(_map);
            }
        }
    }
    else
    {
        __input_global().__keyboard_type = "keyboard";
    }
    if (__input_global().__on_steam_deck || os_type == os_switch || (os_type == os_android || (os_type == os_ios || os_type == os_tvos)) || (os_type == os_windows && false))
    {
        __input_global().__pointer_type = "touch";
    }
    else if (false && (os_type == os_ps4 || os_type == os_ps5))
    {
        __input_global().__pointer_type = "touchpad";
    }
    else if ((os_type == os_xboxone || os_type == os_gdk) || (os_type == os_ps4 || os_type == os_ps5) || os_type == os_switch)
    {
        __input_global().__pointer_type = "none";
    }
    else
    {
        __input_global().__pointer_type = "mouse";
    }
    _global.__gamepad_motion_support = (os_type == os_ps4 || os_type == os_ps5) || os_type == os_switch || _global.__using_steamworks;
    device_mouse_dbclick_enable(false);
    _global.__profile_array = undefined;
    _global.__profile_dict = undefined;
    _global.__default_profile_dict = undefined;
    _global.__verb_to_group_dict = {};
    _global.__group_to_verbs_dict = {};
    _global.__verb_group_array = [];
    _global.__icons = {};
    __input_global().__source_keyboard = new __input_class_source(UnknownEnum.Value_0);
    __input_global().__source_mouse = __input_global().__source_keyboard;
    __input_global().__source_touch = new __input_class_source(UnknownEnum.Value_3);
    __input_global().__source_gamepad = array_create(12, undefined);
    var _g = 0;
    repeat (12)
    {
        __input_global().__source_gamepad[_g] = new __input_class_source(UnknownEnum.Value_2, _g);
        _g++;
    }
    __input_finalize_default_profiles();
    __input_finalize_verb_groups();
    input_source_mode_set(UnknownEnum.Value_2);
    __input_validate_macros();
    return true;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3
}
