/// @function draw_sprite_3d(__sprite, __subimg, __x, __y, __z, __x_scale, __y_scale, __x_rot, __y_rot, __z_rot)
/// @description A method to draw a sprite in 3d space

function draw_sprite_3d(__sprite, __subimg, __x, __y, __z, __x_scale, __y_scale, __x_rot, __y_rot, __z_rot) {
	var __default_mat = matrix_get(matrix_world);
	matrix_set(matrix_world, matrix_build(__x, __y, __z, __x_rot+90, __y_rot, -__z_rot, 1, 1, 1));
	draw_sprite_ext(__sprite, __subimg, 0, 0, __x_scale, __y_scale, 0, c_white, 1);
	matrix_set(matrix_world, __default_mat);
}
