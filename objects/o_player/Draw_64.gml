/// @description Draw debug UI

var __look_dir = entity_class.getEntityViewDirection();

draw_set_color(c_white);

draw_set_font(fn_default);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var __debug_colors = {
	_default: c_white,
	_player: c_lime,
}

var __x_off = 20, __y_off = 20, __to_draw = [
	[__debug_colors._player, ( "HP points: " + string(entity_class.getHealthPoints()) + " / " + string(entity_class.getMaxHealthPoints()) )],
	[__debug_colors._player, ( "Look direction (Angle): " + string(__look_dir) )],
	[__debug_colors._player, ( "X Position: " + string(x) )],
	[__debug_colors._player, ( "Y Position: " + string(y) )]
];

for(var __i = 0; __i < array_length(__to_draw); __i++) {
	draw_set_color(__to_draw[__i][0]);
	draw_text(__x_off, __y_off+__y_off*__i, __to_draw[__i][1]);
	draw_set_color(c_white);
}

delete __debug_colors;