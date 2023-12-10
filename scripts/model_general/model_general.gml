/// @function model_choose_variant(variant, tex_map);

/// @param {real|any} __variant
/// @param {array} __tex_map
/// @param {array} __size

/// @returns {Id.VertexBuffer}

function model_choose_variant(__variant = SQUARE, __tex_map = [], __size = [DEFAULT_CUBE_SIZE, DEFAULT_CUBE_SIZE, DEFAULT_CUBE_SIZE]) {
	if (is_undefined(__tex_map)) then return -1;
	
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