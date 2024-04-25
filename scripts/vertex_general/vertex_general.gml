/// @function vertex_buffer_exists(__buffer);
/// @description Check if a vertex buffer exists (Is this buffer a vertex buffer?)

/// @param {Id.VertexBuffer} __buffer

function vertex_buffer_exists(__buffer){
    var __exists = false, __n,	___err;
	
    try {
		__n = vertex_get_buffer_size(__buffer);
		__exists = true;
	} catch (__err) {}
	
    return __exists;
}



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