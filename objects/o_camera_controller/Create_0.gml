/// @description Set up camera

// Constants
#macro CAMERA_WIDTH		1920 / 2
#macro CAMERA_HEIGHT	1080 / 2
#macro WINDOW_SCALE		1.5

// Set up camera
var __window_width = CAMERA_WIDTH * WINDOW_SCALE, __window_height = CAMERA_HEIGHT * WINDOW_SCALE;
window_set_size(__window_width, __window_height);
surface_resize(application_surface, __window_width, __window_height);

global.camera = view_get_camera(0);
camera_set_view_pos(global.camera, 0, 0);
camera_set_view_size(global.camera, CAMERA_WIDTH, CAMERA_HEIGHT);

screenshot_dir = working_directory + "screens/";
if (!directory_exists(screenshot_dir)) {
    directory_create(screenshot_dir);
}