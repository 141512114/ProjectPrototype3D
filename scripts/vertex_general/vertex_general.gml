/// @function vertex_add_point(vertex_buffer, x, y, z, x_normal, y_normal, z_normal, u, v, color, alpha);
/// @description Add a vertex point to any vertex buffer

/// @param {Id.VertexBuffer} __v_buffer
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

function vertex_add_point(__v_buffer, __xx, __yy, __zz, __nx, __ny, __nz, __u, __v, __color = c_white, __alpha = 1) {
	vertex_position_3d(__v_buffer, __xx, __yy, __zz);
	vertex_normal(__v_buffer, __nx, __ny, __nz);
	vertex_texcoord(__v_buffer, __u, __v);
	vertex_color(__v_buffer, __color, __alpha);
}

/// @function vertex_remove_face(model);
/// @description Remove specific faces of the model, if it cannot be seen by the player anyways (good for static objects)

/// @param {Id.VertexBuffer} __model

function vertex_remove_face(__model) {
	// Make sure there is a model to work with
	if (is_undefined(__model)) then return;
	
	// Check where the (static) object might hit another (static) object
	var __lx, __rx, __fy, __by, __s_obj = o_wall;
		
	__lx = place_meeting(x-1, y, __s_obj);
	__rx = place_meeting(x+1, y, __s_obj);
	__fy = place_meeting(x, y+1, __s_obj);
	__by = place_meeting(x, y-1, __s_obj);
		
	if (__lx || __rx || __fy || __by) {
		var __model_ds_list = ds_list_create();
		var __model_buffer = buffer_create_from_vertex_buffer(__model, buffer_fixed, 1);
			
		// Load every valid value of every vertex based on collisions with closeby blocks
		var __model_buffer_size = buffer_get_size(__model_buffer); for (var __i=0; __i<__model_buffer_size; __i+=36) {
			var __nx = buffer_peek(__model_buffer, __i + 12, buffer_f32);
			var __ny = buffer_peek(__model_buffer, __i + 16, buffer_f32);
			var __nz = buffer_peek(__model_buffer, __i + 20, buffer_f32);

			if (((__lx && __nx != -1 || !__lx) && (__rx && __nx != 1 || !__rx)) && ((__fy && __ny != 1 || !__fy) && (__by && __ny != -1 || !__by))) {
				var __xx = buffer_peek(__model_buffer, __i + 0, buffer_f32);
				var __yy = buffer_peek(__model_buffer, __i + 4, buffer_f32);
				var __zz = buffer_peek(__model_buffer, __i + 8, buffer_f32);
					
				var __u = buffer_peek(__model_buffer, __i + 24, buffer_f32);
				var __v = buffer_peek(__model_buffer, __i + 28, buffer_f32);
			
				var __int_r = buffer_peek(__model_buffer, __i + 32, buffer_u8);
				var __int_g = buffer_peek(__model_buffer, __i + 33, buffer_u8);
				var __int_b = buffer_peek(__model_buffer, __i + 34, buffer_u8);
				var __alpha = buffer_peek(__model_buffer, __i + 35, buffer_u8);
					
				// Save these extracted values into a seperated ds_list
				ds_list_add(__model_ds_list, __xx, __yy, __zz, __nx, __ny, __nz, __u, __v, __int_r, __int_g, __int_b, __alpha);
			}
		}
		
		vertex_delete_buffer(__model);
		buffer_delete(__model_buffer);
			
		// Create a new buffer for our "new" model
		var __buffer_size = 36 * ds_list_size(__model_ds_list);
		var __new_model_buffer = buffer_create(__buffer_size, buffer_fixed, 1);
		
		// Use the stored values in the ds_list and build a new model
		for (var __i=0; __i<ds_list_size(__model_ds_list)-1; __i+=12) {
			var __xx = ds_list_find_value(__model_ds_list, __i + 0);
			var __yy = ds_list_find_value(__model_ds_list, __i + 1);
			var __zz = ds_list_find_value(__model_ds_list, __i + 2);
		
			var __nx = ds_list_find_value(__model_ds_list, __i + 3);
			var __ny = ds_list_find_value(__model_ds_list, __i + 4);
			var __nz = ds_list_find_value(__model_ds_list, __i + 5);
		
			var __u = ds_list_find_value(__model_ds_list, __i + 6);
			var __v = ds_list_find_value(__model_ds_list, __i + 7);
			
			var __int_r = ds_list_find_value(__model_ds_list, __i + 8);
			var __int_g = ds_list_find_value(__model_ds_list, __i + 9);
			var __int_b = ds_list_find_value(__model_ds_list, __i + 10);
			var __alpha = ds_list_find_value(__model_ds_list, __i + 11);
			
			buffer_write(__new_model_buffer, buffer_f32, __xx);
			buffer_write(__new_model_buffer, buffer_f32, __yy);
			buffer_write(__new_model_buffer, buffer_f32, __zz);
			
			buffer_write(__new_model_buffer, buffer_f32, __nx);
			buffer_write(__new_model_buffer, buffer_f32, __ny);
			buffer_write(__new_model_buffer, buffer_f32, __nz);
			
			buffer_write(__new_model_buffer, buffer_f32, __u);
			buffer_write(__new_model_buffer, buffer_f32, __v);
			
			buffer_write(__new_model_buffer, buffer_u8, __int_r);
			buffer_write(__new_model_buffer, buffer_u8, __int_g);
			buffer_write(__new_model_buffer, buffer_u8, __int_b);
			buffer_write(__new_model_buffer, buffer_u8, __alpha);
		}
		
		// Convert the buffer into a vertex buffer
		__model = vertex_create_buffer_from_buffer(__new_model_buffer, global.vformat);
		buffer_delete(__new_model_buffer);
		ds_list_destroy(__model_ds_list);
	}
		
	return __model;
}