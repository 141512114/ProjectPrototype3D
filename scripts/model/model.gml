/// @function Model()
/// @description Model class

function Model() constructor {
	self._parent			= undefined;
	
	self._model_type		= undefined;
	self._model_data		= undefined;
	self._model_data_raw	= undefined;
	self._model_texture		= undefined;
	self._model_texture_map	= undefined;
	
	self._x					= 0;
	self._y					= 0;
	self._z					= 0;
	
	self._size				= [DEFAULT_CUBE_SIZE, DEFAULT_CUBE_SIZE, DEFAULT_CUBE_SIZE];
	self._rotation			= [0, 0, 0];
	self._transform			= [1, 1, 1];
	
	/// @function getParentId();
	/// @description Get parent id of ingame model. The parent is the host of this model class
	
	/// @returns {Any}
	
	getParentId = function() {
		return self._parent;
	}
	
	/// @function setParentId(id);
	/// @description Set parent (object index or id) of ingame model
	
	/// @param {Asset.GMObject|any} __parent
	
	setParentId = function(__parent) {
		self._parent = __parent;
	}
	
	/// @function getModelType();
	/// @description Get type of model
	
	/// @returns {real}
	
	getModelType = function() {
		return self._model_type;
	}
	
	/// @function setModelType();
	/// @description Set type of model
	
	/// @params {real} __model_type
	
	setModelType = function(__model_type) {
		self._model_type = typeof(__model_type) == "number" ? __model_type : MODEL;
	}
	
	/// @function getModelData();
	/// @description Get data of model
	
	/// @returns {Id.VertexBuffer}
	
	getModelData = function() {
		return self._model_data;
	}
	
	/// @function setModelData(model);
	/// @description Set model data
	
	/// @param {Id.VertexBuffer} __model_data
	
	setModelData = function(__model_data) {
		if (is_undefined(__model_data)) return;
		if (vertex_buffer_exists(self._model_data)) then vertex_delete_buffer(self._model_data);
		self._model_data = __model_data;
		vertex_freeze(self._model_data);
	}
	
	/// @function getRawModelData();
	/// @description Get data of model
	
	/// @returns {Id.Buffer|any}
	
	getRawModelData = function() {
		return self._model_data_raw;
	}
	
	/// @function setRawModelData(model);
	/// @description Set raw model data
	
	/// @param {Id.Buffer} __model_raw
	
	setRawModelData = function(__model_raw) {
		if (is_undefined(__model_raw)) return;
		if (buffer_exists(self._model_data_raw)) then buffer_delete(self._model_data_raw);
		
		self._model_data_raw = __model_raw;
		
		show_debug_message("##################################################");
		
		var __temp_buffer = self._model_data_raw;
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
	}
	
	/// @function createModelData(model);
	/// @description Get data of model
	
	/// @params {Any} __model_type
	
	createModelData = function(__model_type) {
		setModelType(__model_type);
		
		var __temp_model_data = self._model_type;
		var __temp_x = 0, __temp_y = 0, __temp_z = 0, __temp_size = getSize(), __temp_tex_map = self._model_texture_map;
		
		switch (__temp_model_data) {
			case SQUARE:
				__temp_model_data =	vertex_create_cube(__temp_x, __temp_y, __temp_z, __temp_size, __temp_tex_map);
			case SPRITE:
				__temp_model_data =	vertex_create_sprite(__temp_x, __temp_y, __temp_z, __temp_size, __temp_tex_map);
			case CROSSED_SPRITE:
				__temp_model_data =	vertex_create_crossed_sprite(__temp_x, __temp_y, __temp_z, __temp_size, __temp_tex_map);
		}
		
		updateModelData(__temp_model_data);
	}
	
	/// @function updateModelData(model);
	/// @description Update the raw model data
	
	/// @params {Id.Buffer} __model
	
	updateModelData = function(__model) {
		if (is_undefined(__model) || !buffer_exists(__model)) return;
		setRawModelData(__model);
	}
	
	/// @function createModelVertex(model);
	/// @description Apply the given model data to the final model data properties
	
	createModelVertex = function() {
		// Create a new vertex buffer from the raw material
		var __model_data = self._model_data_raw, __new_v_buffer = vertex_create_buffer_from_buffer(__model_data, global.vformat);
		setModelData(__new_v_buffer);
	}
	
	/// @function drawModelVertex();
	/// @description Draw the vertex buffer to the screen. Or rather: submit it to the queue
	
	drawModelVertex = function() {
		var __parent = getParentId(), __position = getPosition(), __rotation = getRotation(), __transform = getTransform();
		
		var __model_x = __parent.x+__position[0], __model_y = __parent.y+__position[1], __model_z = __parent.z+__position[2];
		
		matrix_set(
			matrix_world,
			matrix_build(__model_x, __model_y, __model_z, __rotation[0], __rotation[1], __rotation[2], __transform[0], __transform[1], __transform[2])
		);

		var __model = self._model_data,__tex = getTexture();
		vertex_submit(__model, pr_trianglelist, __tex);
	}
	
	/// @function removeJunkFaces();
	/// @description Remove unnecessary faces of the (best would be static) model, which the player won't see anyways
	
	removeJunkFaces = function() {
		// setModelData(vertex_remove_face(getParentId(), self._model_data));
	}
	
	/// @function getPosition();
	/// @description Get position properties of ingame model
	
	getPosition = function() {
		return [self._x, self._y, self._z];
	}
	
	/// @function setPosition(x, y, z);
	/// @description Set position properties of ingame model
	
	/// @param {real} __x
	/// @param {real} __y
	/// @param {real} __z
	
	setPosition = function(__x = 0, __y = 0, __z = 0) {
		self._x = __x;
		self._y = __y;
		self._z = __z;
	}
	
	/// @function getSize();
	/// @description Get size of ingame model
	
	/// @returns {Array<Real>}
	
	getSize = function() {
		return self._size;
	}
	
	/// @function setSize(width, length, height);
	/// @description Set size of ingame model
	
	/// @param {real} __x_size
	/// @param {real} __y_size
	/// @param {real} __z_size
	
	setSize = function(__x_size, __y_size, __z_size) {
		var __rotation = getRotation(), __model_buffer = self._model_data_raw;
		if (is_undefined(__model_buffer)) return;
		
		var __size = [
			__x_size / self._size[0],
			__y_size / self._size[1],
			__z_size / self._size[2]
		];
		
		var __model_buffer_size = buffer_get_size(__model_buffer);
		var __temp_buffer = buffer_create(__model_buffer_size, buffer_fixed, 1);
		buffer_copy(__model_buffer, 0, __model_buffer_size, __temp_buffer, 0);
			
		// Rewrite the x-, y-, and z-sizing data of all vertices (change positions)
		for (var __i = 0; __i < __model_buffer_size; __i += 36) {
			var __xx = buffer_peek(__temp_buffer, __i + 0, buffer_f32);
			var __yy = buffer_peek(__temp_buffer, __i + 4, buffer_f32);
			var __zz = buffer_peek(__temp_buffer, __i + 8, buffer_f32);
			
			var __new_size = matrix_build(__xx, __yy, __zz, __rotation[0], __rotation[1], __rotation[2], __size[0]/2, __size[1]/2, __size[2]);
				
			buffer_poke(__temp_buffer, __i + 0, buffer_f32, __new_size[0]); // X
			buffer_poke(__temp_buffer, __i + 4, buffer_f32, __new_size[1]); // Y
			buffer_poke(__temp_buffer, __i + 8, buffer_f32, __new_size[2]); // Z
		}
		
		self._size = [__x_size, __y_size, __z_size];

		updateModelData(__temp_buffer);
	}
	
	/// @function getTransform();
	/// @description Get transform properties of ingame model
	
	/// @returns {Array<Real>}
	
	getTransform = function() {
		return self._transform;
	}
	
	/// @function setTransform(x, y, z);
	/// @description Set transform properties of ingame model
	
	/// @param {real} __x_transform
	/// @param {real} __y_transform
	/// @param {real} __z_transform
	
	setTransform = function(__x_transform, __y_transform, __z_transform) {
		self._transform = [__x_transform, __y_transform, __z_transform];
	}
	
	/// @function getRotation();
	/// @description Get rotation properties of ingame model
	
	/// @returns {Array<Real>}
	
	getRotation = function() {
		return self._rotation;
	}
	
	/// @function setRotation(x, y, z);
	/// @description Set rotation properties of ingame model
	
	/// @param {real} __x_rotation
	/// @param {real} __y_rotation
	/// @param {real} __z_rotation
	
	setRotation = function(__x_rotation, __y_rotation, __z_rotation) {
		self._rotation = [__x_rotation, __y_rotation, __z_rotation];
	}
	
	/// @function getTexture();
	/// @description Get the texture of ingame model
	
	/// @returns {real|Pointer.Texture}
	
	getTexture = function() {
		return (is_undefined(self._model_texture) || !sprite_exists(self._model_texture)) ? sprite_get_texture(-1, 0) : sprite_get_texture(self._model_texture, 0);
	}
	
	/// @function getSprite();
	/// @description Get the sprite of ingame model
	
	/// @returns {Asset.GMSprite}
	
	getSprite = function() {
		return (is_undefined(self._model_texture) || !sprite_exists(self._model_texture)) ? spr_none : self._model_texture;
	}
	
	/// @function setTexture(texture);
	/// @description Set the texture of ingame model
	
	/// @param {Asset.GMSprite|any} __tex
	
	setTexture = function(__tex = spr_none) {
		self._model_texture = __tex;
		generateTetxtureMap();
		applyTextureMap();
	}
	
	/// @function getTextureMap();
	/// @description Get the texture map of ingame model
	
	/// @returns {Array<Array<Real>>}
	
	getTextureMap = function() {
		return self._model_texture_map;
	}
	
	/// @function setTetxtureMap(tex_map);
	/// @description Set the texture map of ingame model
	
	/// @param {Array<Array<Real>>} __tex_map
	
	setTetxtureMap = function(__tex_map = []) {
		self._model_texture_map = __tex_map;
	}
	
	/// @function generateTetxtureMap();
	/// @description Generate texture map of ingame model
	
	generateTetxtureMap = function() {
		var __sprite = getSprite(), __new_tex_map = [];
		for(var __i = 0; __i < sprite_get_number(__sprite); __i++) {
			__new_tex_map[__i] = sprite_get_uvs(__sprite, __i);
		}
		setTetxtureMap(__new_tex_map);
	}
	
	/// @function applyTextureMap();
	/// @description Apply texture map to the model
	
	applyTextureMap = function() {
		var __model_buffer = self._model_data_raw, __tex_map = self._model_texture_map;
		if (is_undefined(__model_buffer) || is_undefined(__tex_map)) then return;
		
		var __temp_buffer = buffer_create(buffer_get_size(__model_buffer), buffer_fixed, 1);
		buffer_copy(__model_buffer, 0, buffer_get_size(__model_buffer), __temp_buffer, 0);
		
		// Create uv data map from texture map
		var __uv_data = [];
		for (var __i = 0; __i <= array_length(__tex_map)-1; __i++) {
			var __current_face = __tex_map[__i];
			array_push(__uv_data,
				[__current_face[0], __current_face[3]],
				[__current_face[0], __current_face[1]],
				[__current_face[2], __current_face[3]],
				[__current_face[2], __current_face[1]],
				[__current_face[2], __current_face[3]],
				[__current_face[0], __current_face[1]]
			);
		}
		
		show_debug_message(sprite_get_name(getSprite()) + " " + string(__uv_data));
			
		// Rewrite the uv data of all vertices
		var __model_buffer_size = buffer_get_size(__temp_buffer);
		for (var __f = 0; __f <= array_length(__uv_data)-1; __f++) {
			var __offset =  36 * __f;
			if (__offset > __model_buffer_size) break;
			var __u = __uv_data[__f][0], __v = __uv_data[__f][1];
			show_debug_message("UV: " + string(__u) + "," + string(__v));
			buffer_poke(__temp_buffer, __offset + 24, buffer_f32, __u);
			buffer_poke(__temp_buffer, __offset + 28, buffer_f32, __v);
		}

		updateModelData(__temp_buffer);
	}
	
	// This has to be set here, otherwise it will cause an error because of the missing existance of the function
	setTexture();
	
	/// @function clearVertexBuffers();
	/// @description Clear all vertex buffers which are currently used by this class
	
	clearVertexBuffers = function() {
		var __model = self._model_data;
		if (!is_undefined(__model) && vertex_buffer_exists(__model)) {
			vertex_delete_buffer(__model);
		}
	}
	
	/// @function clearBuffers();
	/// @description Clear all buffers which are currently used by this class
	
	clearBuffers = function() {
		var __model = self._model_data_raw;
		if (!is_undefined(__model) && buffer_exists(__model)) {
			buffer_delete(__model);
		}
	}
	
	/// @function clearAllBuffers();
	/// @description Clear any and every buffer which is currently used by this class
	
	clearAllBuffers = function() {
		clearVertexBuffers();
		clearBuffers();
	}
}