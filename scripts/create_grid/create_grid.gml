/// @function create_grid(x_start, y_start, z_start, cell_size, grid_width, grid_height, color, alpha);
/// @description Create a grid on a start position (x, y, z) with any width and height (two dimensional)

/// @param {real} __x_start
/// @param {real} __y_start
/// @param {real} __z_start
/// @param {real} __cell_size
/// @param {real} __grid_width
/// @param {real} __grid_height
/// @param {real} __color
/// @param {real} __alpha

function create_grid(__x_start, __y_start, __z_start, __cell_size, __grid_width, __grid_height, __color, __alpha){
	// Convert the color in its rgb values
	var __int_r = color_get_red(__color);
	var __int_g = color_get_green(__color);
	var __int_b = color_get_blue(__color);
	
	// Make the alpha value into an 8-bit integer (0 - 255)
	var __int_a = 255 * __alpha;
	
	var __grid_h_amount_lines = floor(__grid_width / __cell_size);
	var __grid_v_amount_lines = floor(__grid_height / __cell_size);
	
	var __grid_buffer = buffer_create(72 * (__grid_h_amount_lines + __grid_v_amount_lines + 2), buffer_fixed, 1);
	
	// Write every horizontal line to the buffer
	for (var __i = 0; __i <= __grid_h_amount_lines; __i++) {
		var __x1 = __x_start + (__cell_size * __i);
		var __y1 = __y_start;
		var __z1 = __z_start;
		
		var __x2 = __x_start + (__cell_size * __i);
		var __y2 = __y_start + __grid_height;
		var __z2 = __z_start;
		
		// First vertex point position (the "from"-coord)
		buffer_write(__grid_buffer, buffer_f32, __x1);
		buffer_write(__grid_buffer, buffer_f32, __y1);
		buffer_write(__grid_buffer, buffer_f32, __z1);
	
		// Normal vector (not important for a line though)
		buffer_write(__grid_buffer, buffer_s32, 0);
		buffer_write(__grid_buffer, buffer_s32, 0);
		buffer_write(__grid_buffer, buffer_s32, 0);
	
		// Texcoord (not important too)
		buffer_write(__grid_buffer, buffer_u32, 0);
		buffer_write(__grid_buffer, buffer_u32, 0);
	
		// ____color values and __alpha value (r, g, b, a)
		buffer_write(__grid_buffer, buffer_u8, __int_r);
		buffer_write(__grid_buffer, buffer_u8, __int_g);
		buffer_write(__grid_buffer, buffer_u8, __int_b);
		buffer_write(__grid_buffer, buffer_u8, __int_a);
	
		// Second vertex point position (the "to"-coord)
		buffer_write(__grid_buffer, buffer_f32, __x2);
		buffer_write(__grid_buffer, buffer_f32, __y2);
		buffer_write(__grid_buffer, buffer_f32, __z2);
	
		// Normal vector (not important for a line though)
		buffer_write(__grid_buffer, buffer_s32, 0);
		buffer_write(__grid_buffer, buffer_s32, 0);
		buffer_write(__grid_buffer, buffer_s32, 0);
	
		// Texcoord (not important too)
		buffer_write(__grid_buffer, buffer_u32, 0);
		buffer_write(__grid_buffer, buffer_u32, 0);
	
		// Color values and alpha value (r, g, b, a)
		buffer_write(__grid_buffer, buffer_u8, __int_r);
		buffer_write(__grid_buffer, buffer_u8, __int_g);
		buffer_write(__grid_buffer, buffer_u8, __int_b);
		buffer_write(__grid_buffer, buffer_u8, __int_a);
	}
	// Write every vertical line to the buffer
	for (var __j = 0; __j <= __grid_v_amount_lines; __j++) {
		var __x1 = __x_start;
		var __y1 = __y_start + (__cell_size * __j);
		var __z1 = __z_start;
		
		var __x2 = __x_start + __grid_width;
		var __y2 = __y_start + (__cell_size * __j);
		var __z2 = __z_start;
		
		// First vertex point position (the "from"-coord)
		buffer_write(__grid_buffer, buffer_f32, __x1);
		buffer_write(__grid_buffer, buffer_f32, __y1);
		buffer_write(__grid_buffer, buffer_f32, __z1);
	
		// Normal vector (not important for a line though)
		buffer_write(__grid_buffer, buffer_s32, 0);
		buffer_write(__grid_buffer, buffer_s32, 0);
		buffer_write(__grid_buffer, buffer_s32, 0);
	
		// Texcoord (not important too)
		buffer_write(__grid_buffer, buffer_u32, 0);
		buffer_write(__grid_buffer, buffer_u32, 0);
	
		// Color values and alpha value (r, g, b, a)
		buffer_write(__grid_buffer, buffer_u8, __int_r);
		buffer_write(__grid_buffer, buffer_u8, __int_g);
		buffer_write(__grid_buffer, buffer_u8, __int_b);
		buffer_write(__grid_buffer, buffer_u8, __int_a);
	
		// Second vertex point position (the "to"-coord)
		buffer_write(__grid_buffer, buffer_f32, __x2);
		buffer_write(__grid_buffer, buffer_f32, __y2);
		buffer_write(__grid_buffer, buffer_f32, __z2);
	
		// Normal vector (not important for a line though)
		buffer_write(__grid_buffer, buffer_s32, 0);
		buffer_write(__grid_buffer, buffer_s32, 0);
		buffer_write(__grid_buffer, buffer_s32, 0);
	
		// Texcoord (not important too)
		buffer_write(__grid_buffer, buffer_u32, 0);
		buffer_write(__grid_buffer, buffer_u32, 0);
	
		// Color values and alpha value (r, g, b, a)
		buffer_write(__grid_buffer, buffer_u8, __int_r);
		buffer_write(__grid_buffer, buffer_u8, __int_g);
		buffer_write(__grid_buffer, buffer_u8, __int_b);
		buffer_write(__grid_buffer, buffer_u8, __int_a);
	}
	
	var __grid_vertex_buffer = vertex_create_buffer_from_buffer(__grid_buffer, global.vformat);
	buffer_delete(__grid_buffer);
	
	return __grid_vertex_buffer;
}