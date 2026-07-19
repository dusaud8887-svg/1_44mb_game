function glr_init()
{
    global.GLR_VIEW = 0;
    global.GLR_ZOOM = 1;
    global.GLR_DEBUG_ACTIVE = true;
    var l = ds_list_create();
    global.GLR_DEBUG_OPTIONS = l;
    ds_list_add(l, "Quality");
    ds_list_add(l, "Fxaa");
    ds_list_add(l, "Directional Light");
    ds_list_add(l, "Occlusion");
    ds_list_add(l, "Shadow Blur");
    if (debug_mode)
    {
        global.GLR_ERROR_ARGUMENT_LIGHT = "ERROR: the script argument is not a light";
        global.GLR_ERROR_ARGUMENT_LIGHTSIMPLE = "ERROR: the script argument is not a simple light";
        global.GLR_ERROR_ARGUMENT_MESH = "ERROR: the script argument is not a mesh";
        global.GLR_ERROR_VERTEX_COUNT = "ERROR: the max number of vertices in GM:HTML5 module is 999";
    }
    global.GLR_MATRIX_WORLD_IDENTITY = matrix_get(2);
    var s_width, s_height;
    if (argument_count < 3)
    {
        if (view_enabled)
        {
            var cam = view_camera[global.GLR_VIEW];
            s_width = camera_get_view_width(cam);
            s_height = camera_get_view_height(cam);
        }
        else
        {
            s_width = room_width;
            s_height = room_height;
        }
    }
    else
    {
        s_width = argument[1];
        s_height = argument[2];
        global.GLR_VIEW = argument[3];
    }
    global.GLR_WIDTH = s_width;
    global.GLR_HEIGHT = s_height;
    var q = clamp(argument[0], 0.05, 1);
    global.GLR_MAIN_QUALITY = q;
    global.GLR_DIRECTIONAL_QUALITY = q;
    global.GLR_MAIN_SURFACE_WIDTH = s_width * global.GLR_MAIN_QUALITY;
    global.GLR_MAIN_SURFACE_HEIGHT = s_height * global.GLR_MAIN_QUALITY;
    var _depth_setting = surface_get_depth_disable();
    surface_depth_disable(false);
    global.GLR_MAIN_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH, global.GLR_MAIN_SURFACE_HEIGHT);
    surface_depth_disable(_depth_setting);
    global.GLR_BACKGROUND_RECEIVE_SHADOWS = true;
    global.GLR_BLUR_ENABLED = false;
    global.GLR_BLUR_SURFACE = -1;
    global.GLR_AMBIENT_COLOR = 1118481;
    global.GLR_DIRECTIONAL_ENABLED = false;
    global.GLR_DIRECTIONAL_SURFACE = -1;
    global.GLR_DIRECTIONAL_WIDTH = s_width * global.GLR_DIRECTIONAL_QUALITY;
    global.GLR_DIRECTIONAL_HEIGHT = s_height * global.GLR_DIRECTIONAL_QUALITY;
    global.GLR_DIRECTIONAL_CLEAR = true;
    global.GLR_DEPTH_SURFACE = -1;
    global.GLR_APP_SURFACE_COPY = -1;
    global.GLR_MAX_DEPTH = 16777215;
    global.GLR_OCCLUSION_ENABLED = false;
    global.GLR_OCCLUSION_INTENSITY = 1;
    global.GLR_FXAA_ENABLED = false;
    global.GLR_MESH_DYN_LIST = ds_list_create();
    global.GLR_MESH_STC_LIST = ds_list_create();
    global.GLR_MESH_SORTED_LIST = ds_list_create();
    global.GLR_SPR_DYN_LIST = ds_list_create();
    global.GLR_SPR_STC_LIST = ds_list_create();
    global.GLR_DEP_DYN_LIST = ds_list_create();
    global.GLR_RECEIVER_LIST = ds_list_create();
    global.GLR_DIR_CUSTOM_LIST = ds_list_create();
    global.GLR_SHADOWAREA_LIST = ds_list_create();
    global.GLR_DIRECTIONAL_QUEUE = ds_priority_create();
    global.GLR_DIRECTIONAL_TEMP_QUEUE = ds_priority_create();
    global.GLR_DIRECTIONAL_STRENGTH = 0.5;
    global.GLR_DIRECTIONAL_ANGLE = 320;
    global.GLR_DIRECTIONAL_LENGTH = 0.2;
    global.GLR_LIGHT_LIST = ds_list_create();
    global.GLR_LIGHT_LIST_SIMPLE = ds_list_create();
    global.GLR_OCCLUSION_LIST = ds_list_create();
    global.GLR_OCCLUSION_LIST_INST = ds_list_create();
    global.GLR_ILLUM_BUFFER = buffer_create(global.GLR_MAIN_SURFACE_WIDTH * global.GLR_MAIN_SURFACE_HEIGHT * 4, buffer_fixed, 4);
    global.GLR_OS_MESH_SHADER = 23;
    global.GLR_OS_MESH_SHADER_STATIC = 25;
    global.GLR_OS_GAMMA_SHADER = 39;
    global.GLR_OS_GAMMA_SHADER_FXAA = 1;
    global.GLR_OS_GAMMA_SHADER_BLUR = 16;
    global.GLR_OS_DIRECTIONAL_SHADER = 12;
    global.GLR_OS_DIRECTIONAL_CUSTOM_SHADER = 38;
    if (os_type == os_android || os_type == os_ios)
    {
        global.GLR_OS_GAMMA_SHADER = 13;
        global.GLR_OS_GAMMA_SHADER_FXAA = 7;
        global.GLR_OS_DIRECTIONAL_SHADER = 12;
        global.GLR_OS_MESH_SHADER = 34;
        global.GLR_OS_MESH_SHADER_STATIC = 40;
        global.GLR_OS_DIRECTIONAL_CUSTOM_SHADER = 10;
    }
    global.GLR_UNIF_LIGHT_OFFSET = shader_get_uniform(global.GLR_OS_MESH_SHADER, "LightOffset");
    global.GLR_UNIF_LIGHT_STRENGTH = shader_get_uniform(global.GLR_OS_MESH_SHADER, "strength");
    global.GLR_UNIF_SHADOW_DEPTH = shader_get_uniform(global.GLR_OS_MESH_SHADER, "uShadowDepth");
    global.GLR_UNIF_MESH_MATDEPTH = shader_get_uniform(global.GLR_OS_MESH_SHADER, "uMatDepth");
    global.GLR_UNIF_LIGHT_OFFSET_STATIC = shader_get_uniform(global.GLR_OS_MESH_SHADER_STATIC, "LightOffset");
    global.GLR_UNIF_LIGHT_STRENGTH_STATIC = shader_get_uniform(global.GLR_OS_MESH_SHADER_STATIC, "strength");
    global.GLR_UNIF_SHADOW_DEPTH_STATIC = shader_get_uniform(global.GLR_OS_MESH_SHADER_STATIC, "uShadowDepth");
    global.GLR_UNIF_LIGHT_SCALE_SPR = shader_get_uniform(glr_shader_shadow_sprite, "uScale");
    global.GLR_UNIF_LIGHT_OFFSET_SPR = shader_get_uniform(glr_shader_shadow_sprite, "LightOffset");
    global.GLR_UNIF_DIRECTIONAL = shader_get_uniform(global.GLR_OS_DIRECTIONAL_SHADER, "direction");
    global.GLR_UNIF_DIRECTIONAL_DEPTH = shader_get_uniform(global.GLR_OS_DIRECTIONAL_SHADER, "uShadowDepth");
    global.GLR_UNIF_DIRECTIONAL_AMBIENT = shader_get_uniform(glr_shader_directional_gamma, "uAmbient");
    global.GLR_UNIF_DIRECTIONAL_AMBIENT = shader_get_uniform(glr_shader_directional_gamma_ext, "uAmbient");
    global.GLR_UNIF_MESH_COLOR = shader_get_uniform(glr_shader_mesh_color, "uColor");
    global.GLR_UNIF_LIGHT_INTENSITY = shader_get_uniform(glr_shader_light, "uIntensity");
    global.GLR_UNIF_LIGHT_INTENSITY_SIMPLE = shader_get_uniform(glr_shader_light_simple, "uIntensity");
    global.GLR_UNIF_OCCLUSION = shader_get_uniform(glr_shader_ambient_occlusion, "uOcclusionIntensity");
    global.GLR_UNIF_GAMMA_FXAA_SIZE = shader_get_uniform(global.GLR_OS_GAMMA_SHADER_FXAA, "frameBufSize");
    global.GLR_UNIF_FXAA_SIZE = shader_get_uniform(glr_shader_fxaa, "frameBufSize");
    global.GLR_UNIF_RECEIVER = shader_get_uniform(glr_shader_receiver_gamma, "uAmbient");
    global.GLR_SAMPLER_APP = shader_get_sampler_index(global.GLR_OS_GAMMA_SHADER, "uAppSampler");
    global.GLR_SAMPLER_APP_BLUR = shader_get_sampler_index(global.GLR_OS_GAMMA_SHADER_BLUR, "uAppSampler");
    global.GLR_SAMPLER_APP_FXAA = shader_get_sampler_index(global.GLR_OS_GAMMA_SHADER_FXAA, "uAppSampler");
    global.GLR_SAMPLER_DIRECTIONAL = shader_get_sampler_index(glr_shader_directional_gamma_ext, "uSampler");
    global.GLR_SAMPLER_DIRECTIONAL_CUSTOM = shader_get_sampler_index(global.GLR_OS_DIRECTIONAL_CUSTOM_SHADER, "uSamplerDepth");
    global.GLR_UNIF_DIRECTIONAL_CUSTOM_DEPTH = shader_get_uniform(global.GLR_OS_DIRECTIONAL_CUSTOM_SHADER, "uShadowDepth");
    global.GLR_SHADOWSPRITE_ENABLED = shader_is_compiled(glr_shader_shadow_sprite);
    vertex_format_begin();
    vertex_format_add_position_3d();
    global.GLR_VERTEX_FORMAT = vertex_format_end();
    vertex_format_begin();
    vertex_format_add_position();
    global.GLR_MODEL_FORMAT = vertex_format_end();
    global.GLR_MAT_IDENTITY = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
    global.GLR_M_R = 18;
    global.GLR_M_G = 14;
    global.GLR_M_B = 32;
    global.GLR_S_R = 32;
    global.GLR_S_G = 28;
    global.GLR_S_B = 46;
    global.GLR_N_R = 93;
    global.GLR_N_G = 88;
    global.GLR_N_B = 103;
    global.GLR_A_R = 243;
    global.GLR_A_G = 238;
    global.GLR_A_B = 203;
    global.GLR_E_R = 183;
    global.GLR_E_G = 128;
    global.GLR_E_B = 73;
    global.GLR_AMBIENT_R = 0;
    global.GLR_AMBIENT_G = 0;
    global.GLR_AMBIENT_B = 0;
}
