/// @description Draw 3d world

// Reset screen so it doesn't get filled with the ground getting "duplicated"
draw_clear(c_black);
draw_set_color(c_white);

show_debug_overlay(true);

// Make camera 3d
var __view_mat = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1);
var __proj_mat = matrix_build_projection_perspective_fov(-fov, window_get_width() / window_get_height(), znear, zfar);

camera_set_view_mat(global.camera, __view_mat);
camera_set_proj_mat(global.camera, __proj_mat);
camera_apply(global.camera);

// Draw grid
vertex_submit(grid_vertex_buffer, pr_linelist, -1);

// Draw every 3d object in the scene / room
if (instance_exists(par_draw)) {
	with (par_draw) {
		event_perform(ev_draw, 0);
	}
}

shader_reset();
