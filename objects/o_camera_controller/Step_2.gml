/// @description Take a screenshot

if (keyboard_check_pressed(vk_f2)) {
    screen_save(screenshot_dir + "screenshot_" + string(current_time) + ".png")
}