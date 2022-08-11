/// @function Model()
/// @description Model class

function Model() constructor {
	_parent				= undefined;
	
	_model_data			= undefined;
	_model_texture		= undefined;
	_model_texture_map	= undefined;
	
	_x = 0;
	_y = 0;
	_z = 0;
	
	_size = [DEFAULT_CUBE_SIZE, DEFAULT_CUBE_SIZE, DEFAULT_CUBE_SIZE];
	_rotation = [0, 0, 0];
	_transform = [1, 1, 1];
	
	/// @function getParentId();
	/// @description Get parent id of ingame model. The parent is the host of this model class
	
	getParentId = function() {
		if (_parent == undefined) return;
		return _parent.id;
	}
	
	/// @function setParentId(id);
	/// @description Set parent (object index or id) of ingame model
	
	/// @param {real} id
	
	setParentId = function(__parent) {
		_parent = __parent;
	}
	
	/// @function getModelData();
	/// @description Get size of ingame model
	
	getModelData = function() {
		if (_model_data == undefined) return;
		return _model_data;
	}
	
	/// @function setModelData(model);
	/// @description Set size of ingame model
	
	/// @param {pointer} model
	
	setModelData = function(__model_data) {
		_model_data = (is_undefined(__model_data)) ? undefined : model_choose_variant(__model_data, _model_texture_map, _size);
	}
	
	/// @function removeJunkFaces();
	/// @description Remove unnecessary faces of the (best would be static) model, which the player won't see anyways
	
	removeJunkFaces = function() {
		var __parent = getParentId();
		if (is_undefined(__parent) || !instance_exists(__parent)) return;
		with (__parent) { other.setModelData(vertex_remove_face(other.getModelData())); }
	}
	
	/// @function getPosition();
	/// @description Get position properties of ingame model
	
	getPosition = function() {
		return [_x, _y, _z];
	}
	
	/// @function setPosition(x, y, z);
	/// @description Set position properties of ingame model
	
	/// @param {real} x
	/// @param {real} y
	/// @param {real} z
	
	setPosition = function(__x = 0, __y = 0, __z = 0) {
		_x = __x;
		_y = __y;
		_z = __z;
	}
	
	/// @function getSize();
	/// @description Get size of ingame model
	
	getSize = function() {
		return _size;
	}
	
	/// @function setSize(width, length, height);
	/// @description Set size of ingame model
	
	/// @param {real} width
	/// @param {real} length
	/// @param {real} height
	
	setSize = function(__x_size, __y_size, __z_size) {
		_size = [__x_size, __y_size, __z_size];
	}
	
	/// @function applySize();
	/// @description Apply size to the model (IMPORTANT! Shouldn't be used during runtime. Use setTransform() instead)
	
	applySize = function() {
		var __model = getModelData(), __size = getSize();
		
		// Make sure there is a model to work with
		if (is_undefined(__model)) then return;
		
		var __model_buffer = buffer_create_from_vertex_buffer(__model, buffer_fixed, 1);
			
		// Rewrite the x-, y-, and z-sizing data of all vertices (change positions)
		var __model_buffer_size = buffer_get_size(__model_buffer), j = 0; for (var i=0; i<__model_buffer_size; i+=36) {
			var __x_orientation = 0, __y_orientation = 0, __z_orientation = 0;
				
			var __x = buffer_peek(__model_buffer, i + 0, buffer_f32);
			var __y = buffer_peek(__model_buffer, i + 4, buffer_f32);
			var __z = buffer_peek(__model_buffer, i + 8, buffer_f32);
				
			if (i+36 >= __model_buffer_size) {
				__x_orientation = sign(__x);
				__y_orientation = sign(__y);
				__z_orientation = sign(__z);
			} else {
				var __x2 = buffer_peek(__model_buffer, i+36 + 0, buffer_f32);
				var __y2 = buffer_peek(__model_buffer, i+36 + 4, buffer_f32);
				var __z2 = buffer_peek(__model_buffer, i+36 + 8, buffer_f32);
					
				var __x_vec = sign(__x - __x2), __y_vec = sign(__y - __y2), __z_vec = sign(__z - __z2);
				__x_orientation = (__x == __x2) ? sign(__x) : ((__x_vec == 0) ? -1 : __x_vec);
				__y_orientation = (__y == __y2) ? sign(__y) : ((__y_vec == 0) ? 1 : __y_vec);
				__z_orientation = (__z == 0 && __z2 == 0) ? 0 : ((__z_vec == 0 || __z_vec == -1) ? __z_vec+1 : __z_vec);
			}
				
			buffer_poke(__model_buffer, i + 0, buffer_f32, 0 + __x_orientation * __size[0]/2); // X
			buffer_poke(__model_buffer, i + 4, buffer_f32, 0 + __y_orientation * __size[1]/2); // Y
			buffer_poke(__model_buffer, i + 8, buffer_f32, 0 + __z_orientation * __size[2]); // Z
			j++;
		}

		setModelData(vertex_create_buffer_from_buffer(__model_buffer, global.vformat));
		buffer_delete(__model_buffer);
	}
	
	/// @function getTransform();
	/// @description Get transform properties of ingame model
	
	getTransform = function() {
		return _transform;
	}
	
	/// @function setTransform(x, y, z);
	/// @description Set transform properties of ingame model
	
	/// @param {real} x
	/// @param {real} y
	/// @param {real} z
	
	setTransform = function(__x_transform, __y_transform, __z_transform) {
		_transform = [__x_transform, __y_transform, __z_transform];
	}
	
	/// @function getRotation();
	/// @description Get rotation properties of ingame model
	
	getRotation = function() {
		return _rotation;
	}
	
	/// @function setRotation(x, y, z);
	/// @description Set rotation properties of ingame model
	
	/// @param {real} x
	/// @param {real} y
	/// @param {real} z
	
	setRotation = function(__x_rotation, __y_rotation, __z_rotation) {
		_rotation = [__x_rotation, __y_rotation, __z_rotation];
	}
	
	/// @function getTextureMap();
	/// @description Get texture map of ingame model
	
	getTextureMap = function() {
		return _model_texture_map;
	}
	
	/// @function setTetxtureMap(tex_map);
	/// @description Set texture map of ingame model
	
	/// @param {array} texture_map
	
	setTetxtureMap = function(__tex_map) {
		_model_texture_map = __tex_map;
	}
	
	/// @function generateTetxtureMap();
	/// @description Generate texture map of ingame model
	
	generateTetxtureMap = function() {
		if (!is_undefined(_model_texture) && sprite_exists(_model_texture)) {
			var __subimg_count = sprite_get_number(_model_texture);
			
			for(var i = 0; i < __subimg_count; i++) {
				_model_texture_map[i] = sprite_get_uvs(_model_texture, i);
			}
		}
	}
	
	/// @function applyTextureMap();
	/// @description Apply texture map to the model
	
	applyTextureMap = function() {
		var __model = getModelData(), __tex_map = getTextureMap();
		
		// Make sure there is a model to work with
		if (is_undefined(__model) || is_undefined(__tex_map)) then return;
		
		// Assign uv data to every face of the square
		// face_...[0] = left, face_...[1] = top, face_...[2] = right, face_...[3] = bottom
		var __face_front, __face_right, __face_back, __face_left, __face_top, __face_bottom;
	
		if (array_length(__tex_map) <= 1) {
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
			
		var __new_tex_map = [
			[__face_front[0], __face_front[3]],
			[__face_front[0], __face_front[1]],
			[__face_front[2], __face_front[3]],
			[__face_front[2], __face_front[1]],
			[__face_front[2], __face_front[3]],
			[__face_front[0], __face_front[1]],
			// ------------------------------//
			[__face_right[0], __face_right[3]],
			[__face_right[0], __face_right[1]],
			[__face_right[2], __face_right[3]],
			[__face_right[2], __face_right[1]],
			[__face_right[2], __face_right[3]],
			[__face_right[0], __face_right[1]],
			// ------------------------------//
			[__face_back[0], __face_back[3]],
			[__face_back[0], __face_back[1]],
			[__face_back[2], __face_back[3]],
			[__face_back[2], __face_back[1]],
			[__face_back[2], __face_back[3]],
			[__face_back[0], __face_back[1]],
			// ------------------------------//
			[__face_left[0], __face_left[3]],
			[__face_left[0], __face_left[1]],
			[__face_left[2], __face_left[3]],
			[__face_left[2], __face_left[1]],
			[__face_left[2], __face_left[3]],
			[__face_left[0], __face_left[1]],
			// ------------------------------//
			[__face_top[0], __face_top[3]],
			[__face_top[0], __face_top[1]],
			[__face_top[2], __face_top[3]],
			[__face_top[2], __face_top[1]],
			[__face_top[2], __face_top[3]],
			[__face_top[0], __face_top[1]],
			// ------------------------------//
			[__face_bottom[0], __face_bottom[3]],
			[__face_bottom[0], __face_bottom[1]],
			[__face_bottom[2], __face_bottom[3]],
			[__face_bottom[2], __face_bottom[1]],
			[__face_bottom[2], __face_bottom[3]],
			[__face_bottom[0], __face_bottom[1]]
		];
			
		var __model_buffer = buffer_create_from_vertex_buffer(__model, buffer_fixed, 1);
			
		// Rewrite the uv data of all vertices
		var __model_buffer_size = buffer_get_size(__model_buffer), j = 0; for (var i=0; i<__model_buffer_size; i+=36) {
			buffer_poke(__model_buffer, i + 24, buffer_f32, __new_tex_map[j][0]); // U
			buffer_poke(__model_buffer, i + 28, buffer_f32, __new_tex_map[j][1]); // V
			j++;
		}

		setModelData(vertex_create_buffer_from_buffer(__model_buffer, global.vformat));
		buffer_delete(__model_buffer);
	}
	
	/// @function getTexture();
	/// @description Get texture of ingame model
	
	getTexture = function() {
		return (is_undefined(_model_texture)) ? -1 : sprite_get_texture(_model_texture, 0);
	}
	
	/// @function setTexture(texture);
	/// @description Set texture of ingame model
	
	/// @param {real} texture
	
	setTexture = function(__tex) {
		_model_texture = __tex;
		generateTetxtureMap();
		if (!is_undefined(_model_data)) then applyTextureMap();
	}
	
	// This has to be set here, otherwise it will cause an error because of the missing existance of the function
	setTexture(spr_none);
	
	/// @function clearVertexBuffers();
	/// @description Clear all vertex buffers, which are currently used by this class
	
	clearVertexBuffers = function() {
		var __model = getModelData();
		if (!is_undefined(__model)) then vertex_delete_buffer(__model);
	}
}