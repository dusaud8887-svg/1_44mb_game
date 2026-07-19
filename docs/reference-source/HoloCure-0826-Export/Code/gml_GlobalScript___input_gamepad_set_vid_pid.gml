function __input_gamepad_set_vid_pid()
{
    if (false || os_type == os_gxgames)
    {
        vendor = "";
        product = "";
        xinput = undefined;
        if (os_type == os_gxgames)
        {
        }
        else
        {
            var _vendor_pos = string_pos("Vendor: ", description);
            var _product_pos = string_pos("Product: ", description);
            if (_vendor_pos > 0 && _product_pos > 0)
            {
                vendor = string_copy(description, _vendor_pos + 8, 4);
                product = string_copy(description, _product_pos + 9, 4);
                description = string_copy(description, 1, _vendor_pos - 1);
            }
            else
            {
                var _firefoxy = false;
                var _hyphen_count = string_count("-", description);
                var _vendor_slice, _product_slice, _work_string;
                if (_hyphen_count >= 2)
                {
                    _work_string = description;
                    var _hyphen_pos = string_pos("-", _work_string);
                    _vendor_slice = string_copy(_work_string, 1, _hyphen_pos - 1);
                    _work_string = string_delete(_work_string, 1, _hyphen_pos);
                    _hyphen_pos = string_pos("-", _work_string);
                    _product_slice = string_copy(_work_string, 1, _hyphen_pos - 1);
                    _work_string = string_delete(_work_string, 1, _hyphen_pos);
                    repeat (4 - string_length(_vendor_slice))
                    {
                        _vendor_slice = "0" + _vendor_slice;
                    }
                    repeat (4 - string_length(_product_slice))
                    {
                        _product_slice = "0" + _product_slice;
                    }
                    _vendor_slice = string_copy(_vendor_slice, 1, 4);
                    _product_slice = string_copy(_product_slice, 1, 4);
                    _firefoxy = true;
                    var _i = 1;
                    repeat (4)
                    {
                        var _ord = ord(string_char_at(_vendor_slice, _i));
                        if (!((_ord >= 48 && _ord <= 57) || (_ord >= 65 && _ord <= 70) || (_ord >= 97 && _ord <= 102)))
                        {
                            _firefoxy = false;
                            break;
                        }
                        _i++;
                    }
                }
                if (_firefoxy)
                {
                    vendor = _vendor_slice;
                    product = _product_slice;
                    description = _work_string;
                }
                else
                {
                    __input_trace("Gamepad description could not be parsed. Bindings for this gamepad may be incorrect (was \"", description, "\")");
                }
            }
            if (is_string(vendor))
            {
                vendor = string_copy(vendor, 3, 2) + string_copy(vendor, 1, 2);
            }
            if (is_string(product))
            {
                product = string_copy(product, 3, 2) + string_copy(product, 1, 2);
            }
        }
    }
    else if (!(false || os_type == os_gxgames) && ((os_type == os_macosx || os_type == os_linux || os_type == os_windows) || os_type == os_android))
    {
        if (os_type == os_windows)
        {
            var _legacy = __input_string_contains(guid, "000000000000504944564944");
            var _result = __input_gamepad_guid_parse(guid, _legacy, false);
            vendor = _result.vendor;
            product = _result.product;
            xinput = index < 4;
        }
        else if (os_type == os_macosx || os_type == os_linux || os_type == os_android)
        {
            var _result = __input_gamepad_guid_parse(guid, false, false);
            vendor = _result.vendor;
            product = _result.product;
            xinput = undefined;
        }
        else
        {
            __input_trace("Warning! OS type check fell through unexpectedly (os_type = ", os_type, ")");
            description = gamepad_get_description(index);
            vendor = "";
            product = "";
            xinput = undefined;
        }
    }
    else
    {
        description = gamepad_get_description(index);
        vendor = "";
        product = "";
        xinput = undefined;
    }
}
