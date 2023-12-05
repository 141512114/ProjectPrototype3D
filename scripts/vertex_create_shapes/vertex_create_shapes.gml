/// @function vertex_create_sprite(x, y, z, size, color, alpha);
/// @description Create a plane model and return it as a vertex buffer

/// @param {real} __xx
/// @param {real} __yy
/// @param {real} __zz
/// @param {array} __size
/// @param {array} __tex_map
/// @param {real} __color
/// @param {real} __alpha

function vertex_create_sprite(__xx = 0, __yy = 0, __zz = 0, __size = [DEFAULT_CUBE_SIZE, 0, DEFAULT_CUBE_SIZE], __tex_map = [], __color = c_white, __alpha = 1) {
	if (is_undefined(__tex_map)) then return;
	
	// Create texture map info (UV data)
	var __tex_left, __tex_top, __tex_right, __tex_bottom;
	__tex_left		= __tex_map[0][0];
	__tex_top		= __tex_map[0][1];
	__tex_right		= __tex_map[0][2];
	__tex_bottom	= __tex_map[0][3];
	
	// Create sprite plane
	var __v_plane = vertex_create_buffer();
	vertex_begin(__v_plane, global.vformat);
	
	// Sprite plane: front
	vertex_add_point(__v_plane, __xx-__size[0]/2, __yy, __zz,				0, -1, 0, __tex_left,		__tex_bottom, __color, __alpha);
	vertex_add_point(__v_plane, __xx-__size[0]/2, __yy, __zz+__size[2],		0, -1, 0, __tex_left,		__tex_top,	__color, __alpha);
	vertex_add_point(__v_plane, __xx+__size[0]/2, __yy, __zz,				0, -1, 0, __tex_right,		__tex_bottom, __color, __alpha);
	
	vertex_add_point(__v_plane, __xx+__size[0]/2, __yy, __zz+__size[2],		0, -1, 0, __tex_right,		__tex_top,	__color, __alpha);
	vertex_add_point(__v_plane, __xx+__size[0]/2, __yy, __zz,				0, -1, 0, __tex_right,		__tex_bottom, __color, __alpha);
	vertex_add_point(__v_plane, __xx-__size[0]/2, __yy, __zz+__size[2],		0, -1, 0, __tex_left,		__tex_top,	__color, __alpha);
	
	vertex_end(__v_plane);
	
	return __v_plane;
}

/// @function vertex_create_crossed_sprite(x, y, z, size, color, alpha);
/// @description Create a crossed plane model and return it as a vertex buffer

/// @param {real} __xx
/// @param {real} __yy
/// @param {real} __zz
/// @param {array} __size
/// @param {array} __tex_map
/// @param {real} __color
/// @param {real} __alpha

function vertex_create_crossed_sprite(__xx = 0, __yy = 0, __zz = 0, __size = [DEFAULT_CUBE_SIZE, 0, DEFAULT_CUBE_SIZE], __tex_map = [], __color = c_white, __alpha = 1) {
	if (is_undefined(__tex_map)) then return;
	
	// Create texture map info (UV data)
	var __tex_left, __tex_top, __tex_right, __tex_bottom;
	__tex_left		= __tex_map[0][0];
	__tex_top		= __tex_map[0][1];
	__tex_right		= __tex_map[0][2];
	__tex_bottom	= __tex_map[0][3];
	
	// Create crossed sprite plane
	var __v_plane = vertex_create_buffer();
	vertex_begin(__v_plane, global.vformat);
	
	// Make sure the diagonal faces are at correct size and won't get stretched
	var __point_dir = point_direction(__xx, __yy, __xx+__size[0]/2, __yy+__size[1]/2);
	var __len_x = lengthdir_x(__size[0]/2, __point_dir);
	var __len_y = lengthdir_y(__size[1]/2, __point_dir);
	
	// Sprite plane: front
	vertex_add_point(__v_plane, -__len_x,	-__len_y,	__zz,				0, -1, 0, __tex_left,		__tex_bottom, __color, __alpha);
	vertex_add_point(__v_plane, -__len_x,	-__len_y,	__zz+__size[2],		0, -1, 0, __tex_left,		__tex_top,	__color, __alpha);
	vertex_add_point(__v_plane, __len_x,	__len_y,	__zz,				0, -1, 0, __tex_right,		__tex_bottom, __color, __alpha);
	
	vertex_add_point(__v_plane, __len_x,	__len_y,	__zz+__size[2],		0, -1, 0, __tex_right,		__tex_top,	__color, __alpha);
	vertex_add_point(__v_plane, __len_x,	__len_y,	__zz,				0, -1, 0, __tex_right,		__tex_bottom, __color, __alpha);
	vertex_add_point(__v_plane, -__len_x,	-__len_y,	__zz+__size[2],		0, -1, 0, __tex_left,		__tex_top,	__color, __alpha);
	
	// Sprite plane: back
	vertex_add_point(__v_plane, -__len_x,	__len_y,	__zz,				0, -1, 0, __tex_left,		__tex_bottom, __color, __alpha);
	vertex_add_point(__v_plane, -__len_x,	__len_y,	__zz+__size[2],		0, -1, 0, __tex_left,		__tex_top,	__color, __alpha);
	vertex_add_point(__v_plane, __len_x,	-__len_y,	__zz,				0, -1, 0, __tex_right,		__tex_bottom, __color, __alpha);
	
	vertex_add_point(__v_plane, __len_x,	-__len_y,	__zz+__size[2],		0, -1, 0, __tex_right,		__tex_top,	__color, __alpha);
	vertex_add_point(__v_plane, __len_x,	-__len_y,	__zz,				0, -1, 0, __tex_right,		__tex_bottom, __color, __alpha);
	vertex_add_point(__v_plane, -__len_x,	__len_y,	__zz+__size[2],		0, -1, 0, __tex_left,		__tex_top,	__color, __alpha);
	
	vertex_end(__v_plane);
	
	return __v_plane;
}

/// @function vertex_create_cube(x, y, z, size, color, alpha);
/// @description Create a cube model and return it as a vertex buffer

/// @param {real} __xx
/// @param {real} __yy
/// @param {real} __zz
/// @param {array} __size
/// @param {array} __tex_map
/// @param {real} __color
/// @param {real} __alpha

function vertex_create_cube(__xx = 0, __yy = 0, __zz = 0, __size = [DEFAULT_CUBE_SIZE, DEFAULT_CUBE_SIZE, DEFAULT_CUBE_SIZE], __tex_map = [], __color = c_white, __alpha = 1) {
	if (is_undefined(__tex_map)) then return;
	
	// Assign uv data to every face of the square
	// face_...[0] = left, face_...[1] = top, face_...[2] = right, face_...[3] = bottom
	var __face_front, __face_right, __face_back, __face_left, __face_top, __face_bottom;
	
	if (array_length(__tex_map) == 1) {
		__face_front	= __tex_map[0];
		__face_right	= __tex_map[0];
		__face_back		= __tex_map[0];
		__face_left		= __tex_map[0];
		__face_top		= __tex_map[0];
		__face_bottom	= __tex_map[0];
	} else {
		__face_front	= __tex_map[0];
		__face_right	= __tex_map[1];
		__face_back		= __tex_map[2];
		__face_left		= __tex_map[3];
		__face_top		= __tex_map[4];
		__face_bottom	= __tex_map[5];
	}
	
	// Create cube model
	var __v_cube = vertex_create_buffer();
	vertex_begin(__v_cube, global.vformat);
	
	// Cube model: front
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy-__size[1]/2,	__zz,					0, -1, 0, __face_front[0], __face_front[3], __color, __alpha);
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy-__size[1]/2,	__zz+__size[2],			0, -1, 0, __face_front[0], __face_front[1], __color, __alpha);
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy-__size[1]/2,	__zz,					0, -1, 0, __face_front[2], __face_front[3], __color, __alpha);
	
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy-__size[1]/2,	__zz+__size[2],			0, -1, 0, __face_front[2], __face_front[1], __color, __alpha);
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy-__size[1]/2,	__zz,					0, -1, 0, __face_front[2], __face_front[3], __color, __alpha);
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy-__size[1]/2,	__zz+__size[2],			0, -1, 0, __face_front[0], __face_front[1], __color, __alpha);
	
	// Cube model: right
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy-__size[1]/2,	__zz,					1, 0, 0, __face_right[0], __face_right[3], __color, __alpha);
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy-__size[1]/2,	__zz+__size[2],			1, 0, 0, __face_right[0], __face_right[1], __color, __alpha);
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy+__size[1]/2,	__zz,					1, 0, 0, __face_right[2], __face_right[3], __color, __alpha);
	
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy+__size[1]/2,	__zz+__size[2],			1, 0, 0, __face_right[2], __face_right[1], __color, __alpha);
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy+__size[1]/2,	__zz,					1, 0, 0, __face_right[2], __face_right[3], __color, __alpha);
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy-__size[1]/2,	__zz+__size[2],			1, 0, 0, __face_right[0], __face_right[1], __color, __alpha);
	
	// Cube model: back
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy+__size[1]/2,	__zz,					0, 1, 0, __face_back[0], __face_back[3], __color, __alpha);
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy+__size[1]/2,	__zz+__size[2],			0, 1, 0, __face_back[0], __face_back[1], __color, __alpha);
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy+__size[1]/2,	__zz,					0, 1, 0, __face_back[2], __face_back[3], __color, __alpha);
	
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy+__size[1]/2,	__zz+__size[2],			0, 1, 0, __face_back[2], __face_back[1], __color, __alpha);
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy+__size[1]/2,	__zz,					0, 1, 0, __face_back[2], __face_back[3], __color, __alpha);
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy+__size[1]/2,	__zz+__size[2],			0, 1, 0, __face_back[0], __face_back[1], __color, __alpha);

	// Cube model: left
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy+__size[1]/2,	__zz,					-1, 0, 0, __face_left[0], __face_left[3], __color, __alpha);
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy+__size[1]/2,	__zz+__size[2],			-1, 0, 0, __face_left[0], __face_left[1], __color, __alpha);
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy-__size[1]/2,	__zz,					-1, 0, 0, __face_left[2], __face_left[3], __color, __alpha);
	
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy-__size[1]/2,	__zz+__size[2],			-1, 0, 0, __face_left[2], __face_left[1], __color, __alpha);
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy-__size[1]/2,	__zz,					-1, 0, 0, __face_left[2], __face_left[3], __color, __alpha);
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy+__size[1]/2,	__zz+__size[2],			-1, 0, 0, __face_left[0], __face_left[1], __color, __alpha);
	
	// Cube model: top
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy-__size[1]/2,	__zz+__size[2],			0, 0, 1, __face_top[0], __face_top[3], __color, __alpha);
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy+__size[1]/2,	__zz+__size[2],			0, 0, 1, __face_top[0], __face_top[1], __color, __alpha);
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy-__size[1]/2,	__zz+__size[2],			0, 0, 1, __face_top[2], __face_top[3], __color, __alpha);

	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy+__size[1]/2,	__zz+__size[2],			0, 0, 1, __face_top[2], __face_top[1], __color, __alpha);
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy-__size[1]/2,	__zz+__size[2],			0, 0, 1, __face_top[2], __face_top[3], __color, __alpha);
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy+__size[1]/2,	__zz+__size[2],			0, 0, 1, __face_top[0], __face_top[1], __color, __alpha);
	
	// Cube model: bottom
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy+__size[1]/2,	__zz,					0, 0, -1, __face_bottom[0], __face_bottom[3], __color, __alpha);
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy-__size[1]/2,	__zz,					0, 0, -1, __face_bottom[0], __face_bottom[1], __color, __alpha);
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy+__size[1]/2,	__zz,					0, 0, -1, __face_bottom[2], __face_bottom[3], __color, __alpha);
	
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy-__size[1]/2,	__zz,					0, 0, -1, __face_bottom[2], __face_bottom[1], __color, __alpha);
	vertex_add_point(__v_cube, __xx+__size[0]/2,	__yy+__size[1]/2,	__zz,					0, 0, -1, __face_bottom[2], __face_bottom[3], __color, __alpha);
	vertex_add_point(__v_cube, __xx-__size[0]/2,	__yy-__size[1]/2,	__zz,					0, 0, -1, __face_bottom[0], __face_bottom[1], __color, __alpha);

	vertex_end(__v_cube);
	
	return __v_cube;
}