/// @description Player controls

// Quit game
if (keyboard_check_pressed(vk_escape)) then game_end();

// Lock cursor to the center of the window
window_set_cursor(cr_none);
window_mouse_set(window_get_width() / 2, window_get_height() / 2);
// Rotation (roll, pitch)
var __look_dir = entity_class.getEntityViewDirection();
entity_class.setEntityViewDirection(__look_dir + (window_mouse_get_x() - window_get_width() / 2) / sensitivity);
	
// Movement
var __w_s_move = sign(keyboard_check(ord("W")) - keyboard_check(ord("S")));
var __a_d_move = sign(keyboard_check(ord("D")) - keyboard_check(ord("A")));
	
var __dpos = entity_class.entityMoveSet(__w_s_move, __a_d_move);
entity_class.manipulateEntityPosition(__dpos[0], __dpos[1], __dpos[2]);

// Ability to open doors / paths
var __look_dir_x = ((__look_dir == 0 || __look_dir == 360) ? 1 : ((__look_dir == 180) ? -1 : 0));
var __look_dir_y = ((__look_dir == 270) ? 1 : ((__look_dir == 90) ? -1 : 0));
var __door_in_sight = instance_place(x+__look_dir_x, y+__look_dir_y, o_door);
if (__door_in_sight) {
	if (keyboard_check_pressed(ord("F"))) then instance_destroy(__door_in_sight);
}