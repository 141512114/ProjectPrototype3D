/// @function buffer_create_point(x, y, z, normal_x, normal_y, normal_z, u, v color, alpha);
/// @description Create a plane shape and return it as a buffer

/// @param {Id.Buffer} __buffer_home
/// @param {real} __xx
/// @param {real} __yy
/// @param {real} __zz
/// @param {real} __nx
/// @param {real} __ny
/// @param {real} __nz
/// @param {real} __u
/// @param {real} __v
/// @param {real} __color
/// @param {real} __alpha
	
function buffer_create_point(
	__buffer_home,
	__xx = 0,
	__yy = 0,
	__zz = 0,
	__nx = 0,
	__ny = 1,
	__nz = 0,
	__u = -1,
	__v = -1,
	__color = c_white,
	__alpha = 1
) {
	if (is_undefined(__buffer_home)) return;
	
	buffer_write(__buffer_home, buffer_f32, __xx);
	buffer_write(__buffer_home, buffer_f32, __yy);
	buffer_write(__buffer_home, buffer_f32, __zz);
	buffer_write(__buffer_home, buffer_s32, __nx);
	buffer_write(__buffer_home, buffer_s32, __ny);
	buffer_write(__buffer_home, buffer_s32, __nz);
	buffer_write(__buffer_home, buffer_f32, __u);
	buffer_write(__buffer_home, buffer_f32, __v);
	buffer_write(__buffer_home, buffer_u8, color_get_red(__color));
	buffer_write(__buffer_home, buffer_u8, color_get_blue(__color));
	buffer_write(__buffer_home, buffer_u8, color_get_green(__color));
	buffer_write(__buffer_home, buffer_u8, __alpha);
}

/// @function buffer_shape_plane(x, y, z, size, rotation, texture_map, color, alpha);
/// @description Create a plane shape and return it as a buffer

/// @param {real} __xx
/// @param {real} __yy
/// @param {real} __zz
/// @param {array} __size
/// @param {array} __rotation
/// @param {array} __tex_map
/// @param {real} __color
/// @param {real} __alpha

/// @returns {Id.Buffer|undefined}

function buffer_shape_plane(
	__xx = 0,
	__yy = 0,
	__zz = 0,
	__size = [DEFAULT_CUBE_SIZE, 0, DEFAULT_CUBE_SIZE],
	__rotation = [0, 0, 0],
	__tex_map = [],
	__color = c_white,
	__alpha = 1
) {
	if (is_undefined(__tex_map)) then return undefined;
	show_debug_message("What the buffer got: " + string(__tex_map) + ", length: " + string(array_length(__tex_map)));
	
	// Create texture map info (UV data)
	var __tex_left, __tex_top, __tex_right, __tex_bottom;
	__tex_left		= __tex_map[0];
	__tex_top		= __tex_map[1];
	__tex_right		= __tex_map[2];
	__tex_bottom	= __tex_map[3];
	
	var __transformation_matrix = matrix_build(0, 0, 0, __rotation[0], __rotation[1], __rotation[2], 1, 1, 1);
	
	var __temp_buffer = buffer_create(216, buffer_fixed, 1);
	buffer_seek(__temp_buffer, buffer_seek_start, 0);
	
	var __buffer_points_info = [
		[__xx-__size[0]/2, __yy, __zz,				0, -1, 0, __tex_left, __tex_bottom],
		[__xx-__size[0]/2, __yy, __zz+__size[2],	0, -1, 0, __tex_left, __tex_top],
		[__xx+__size[0]/2, __yy, __zz,				0, -1, 0, __tex_right, __tex_bottom],
		[__xx+__size[0]/2, __yy, __zz+__size[2],	0, -1, 0, __tex_right, __tex_top],
		[__xx+__size[0]/2, __yy, __zz,				0, -1, 0, __tex_right, __tex_bottom],
		[__xx-__size[0]/2, __yy, __zz+__size[2],	0, -1, 0, __tex_left, __tex_top],
	];
	
	for (var __p = 0; __p <= array_length(__buffer_points_info)-1; __p++) {
		var __current_point = __buffer_points_info[__p];
		var __px = __current_point[0], __py = __current_point[1], __pz = __current_point[2];
		var __pnx = __current_point[3], __pny = __current_point[4], __pnz = __current_point[5];
		var __pu = __current_point[6], __pv = __current_point[7];
		// Transform points according to the given matrix
		var __new_position = matrix_transform_vertex(__transformation_matrix, __px, __py, __pz);
		buffer_create_point(__temp_buffer, __new_position[0], __new_position[1], __new_position[2], __pnx, __pny, __pnz, __pu, __pv, __color, __alpha);
	}
	
	show_debug_message("########################## INSIDE THE CREATION PROCESS ###########################");
	
	for (var __i = 0; __i < buffer_get_size(__temp_buffer); __i += 36) {
		var __temp_xx = buffer_peek(__temp_buffer, __i + 0, buffer_f32);
		var __temp_yy = buffer_peek(__temp_buffer, __i + 4, buffer_f32);
		var __temp_zz = buffer_peek(__temp_buffer, __i + 8, buffer_f32);
					
		var __nx = buffer_peek(__temp_buffer, __i + 12, buffer_s32);
		var __ny = buffer_peek(__temp_buffer, __i + 16, buffer_s32);
		var __nz = buffer_peek(__temp_buffer, __i + 20, buffer_s32);
					
		var __u = buffer_peek(__temp_buffer, __i + 24, buffer_f32);
		var __v = buffer_peek(__temp_buffer, __i + 28, buffer_f32);
		
		var __int_r = buffer_peek(__temp_buffer, __i + 32, buffer_u8);
		var __int_g = buffer_peek(__temp_buffer, __i + 33, buffer_u8);
		var __int_b = buffer_peek(__temp_buffer, __i + 34, buffer_u8);
		var __temp_alpha = buffer_peek(__temp_buffer, __i + 35, buffer_u8);
			
		show_debug_message(
			"One vertex point (in buffer): " +
			string(__temp_xx) + ", " +
			string(__temp_yy) + ", " +
			string(__temp_zz) + ", " +
			string(__nx) + ", " +
			string(__ny) + ", " +
			string(__nz) + ", " +
			string(__u) + ", " +
			string(__v) + ", " +
			string(__int_r) + ", " +
			string(__int_g) + ", " +
			string(__int_b) + ", " +
			string(__temp_alpha)
		);
	}
	
	return __temp_buffer;
}

/// @function vertex_create_sprite(x, y, z, size, texture_map, color, alpha);
/// @description Create a plane model and return it as a vertex buffer

/// @param {real} __xx
/// @param {real} __yy
/// @param {real} __zz
/// @param {array} __size
/// @param {array} __tex_map
/// @param {real} __color
/// @param {real} __alpha

/// @returns {Id.Buffer}

function vertex_create_sprite(__xx = 0, __yy = 0, __zz = 0, __size = [DEFAULT_CUBE_SIZE, 0, DEFAULT_CUBE_SIZE], __tex_map = [], __color = c_white, __alpha = 1) {
	return buffer_shape_plane(__xx, __yy, __zz, __size, [0, 0, 0], __tex_map[0], __color, __alpha);
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

/// @returns {Id.Buffer}

function vertex_create_crossed_sprite(__xx = 0, __yy = 0, __zz = 0, __size = [DEFAULT_CUBE_SIZE, 0, DEFAULT_CUBE_SIZE], __tex_map = [], __color = c_white, __alpha = 1) {
	// Create crossed sprite plane
	var __buffer_shape_crossed_planes = [
		buffer_shape_plane(__xx, __yy, __zz, __size, [0, 45, 0], __tex_map[0], __color, __alpha),
		buffer_shape_plane(__xx, __yy, __zz, __size, [0, -45, 0], __tex_map[0], __color, __alpha)
	];
	
	var __buffer_size_bytes = buffer_get_size(__buffer_shape_crossed_planes[0]);
	var __buffer_combined_shape = buffer_create(__buffer_size_bytes * array_length(__buffer_shape_crossed_planes), buffer_fixed, 1);
	for (var __i = 0; __i <= array_length(__buffer_shape_crossed_planes)-1; __i++) {
		buffer_copy(__buffer_shape_crossed_planes[__i], 0, __buffer_size_bytes, __buffer_combined_shape, __buffer_size_bytes * __i);
		buffer_delete(__buffer_shape_crossed_planes[__i]);
	}

	return __buffer_combined_shape;
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

/// @returns {Id.Buffer|undefined}

function vertex_create_cube(__xx = 0, __yy = 0, __zz = 0, __size = [DEFAULT_CUBE_SIZE, DEFAULT_CUBE_SIZE, DEFAULT_CUBE_SIZE], __tex_map = [], __color = c_white, __alpha = 1) {
	if (is_undefined(__tex_map)) then return undefined;
	
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
	
	// Create cube shapw
	var __buffer_shape_cube = [
		buffer_shape_plane(__xx, __yy, __zz, __size, [0, 0, 0],		__face_front, __color, __alpha),
		buffer_shape_plane(__xx, __yy, __zz, __size, [0, 90, 0],	__face_right, __color, __alpha),
		buffer_shape_plane(__xx, __yy, __zz, __size, [0, 180, 0],	__face_back, __color, __alpha),
		buffer_shape_plane(__xx, __yy, __zz, __size, [0, -90, 0],	__face_left, __color, __alpha),
		buffer_shape_plane(__xx, __yy, __zz, __size, [0, 0, 90],	__face_top, __color, __alpha),
		buffer_shape_plane(__xx, __yy, __zz, __size, [0, 0, -90],	__face_bottom, __color, __alpha)
	];
	
	var __buffer_size_bytes = buffer_get_size(__buffer_shape_cube[0]);
	var __buffer_combined_shape = buffer_create(__buffer_size_bytes * array_length(__buffer_shape_cube), buffer_fixed, 1);
	for (var __i = 0; __i <= array_length(__buffer_shape_cube)-1; __i++) {
		buffer_copy(__buffer_shape_cube[__i], 0, __buffer_size_bytes, __buffer_combined_shape, __buffer_size_bytes * __i);
		buffer_delete(__buffer_shape_cube[__i]);
	}

	return __buffer_combined_shape;
}