/// @function model_choose_variant(variant, tex_map);

/// @param variant
/// @param {array} texture_map
/// @param {array} size

function model_choose_variant(__variant = SQUARE, __tex_map, __size = [DEFAULT_CUBE_SIZE, DEFAULT_CUBE_SIZE, DEFAULT_CUBE_SIZE]) {
	if (is_undefined(__tex_map)) then return;
	
	// Check which variant is chosen
	switch (__variant) {
		case SQUARE:
			return vertex_create_cube(0, 0, 0, __size, __tex_map);
		case SPRITE:
			return vertex_create_sprite(0, 0, 0, __size, __tex_map);
		case CROSSED_SPRITE:
			return vertex_create_crossed_sprite(0, 0, 0, __size, __tex_map);
		default: // Used for normal models
			return __variant;
	}
}