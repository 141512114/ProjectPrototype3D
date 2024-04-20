/// @function Model()
/// @description Model class

function Model() constructor {
	self._parent			= undefined;
	
	self._model_type		= undefined;
	self._model_data		= undefined;
	self._model_texture		= spr_none;
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
	
	/// @returns {Id.Buffer}
	
	getModelData = function() {
		return self._model_data;
	}
	
	/// @function setModelData(model);
	/// @description Set model data
	
	/// @param {Id.Buffer} __model_data
	
	setModelData = function(__model_data) {
		if (is_undefined(__model_data)) return;
		if (buffer_exists(self._model_data)) then buffer_delete(self._model_data);
		self._model_data = __model_data;
	}
	
	/// @function createModelData(model);
	/// @description Get data of model
	
	/// @params {Any} __model_type
	
	createModelData = function(__model_type) {
		setModelType(__model_type);

		var __temp_x = 0, __temp_y = 0, __temp_z = 0, __temp_size = getSize(), __temp_tex_map = self._model_texture_map;
		
		var __temp_buffer; switch (self._model_type) {
			case SQUARE:
				__temp_buffer =	vertex_create_cube(__temp_x, __temp_y, __temp_z, __temp_size, __temp_tex_map);
				break;
			case SPRITE:
				__temp_buffer =	vertex_create_sprite(__temp_x, __temp_y, __temp_z, __temp_size, __temp_tex_map);
				break;
			case CROSSED_SPRITE:
				__temp_buffer =	vertex_create_crossed_sprite(__temp_x, __temp_y, __temp_z, __temp_size, __temp_tex_map);
				break;
		}
		
		setModelData(__temp_buffer);
		applyTextureMap();
	}
	
	/// @function createModelVertex();
	/// @description Create the vertex buffer for displaying the model data ingame
	
	/// @returns {Id.VertexBuffer|undefined}
	
	createModelVertex = function() {
		if (is_undefined(self._model_data) || !buffer_exists(self._model_data)) return;
		var __v_buffer = vertex_create_buffer_from_buffer(self._model_data, global.vformat);
		vertex_freeze(__v_buffer);
		return __v_buffer;
	}
	
	/// @function drawModelVertex();
	/// @description Draw the vertex buffer to the screen. Or rather: submit it to the queue
	
	drawModelVertex = function(__v_buffer) {
		if (is_undefined(__v_buffer) || !vertex_buffer_exists(__v_buffer)) return;
		var __parent = getParentId(), __position = getPosition(), __rotation = getRotation(), __transform = getTransform();
		var __model_x = __parent.x+__position[0], __model_y = __parent.y+__position[1], __model_z = __parent.z+__position[2];
		
		matrix_set(
			matrix_world,
			matrix_build(__model_x, __model_y, __model_z, __rotation[0], __rotation[1], __rotation[2], __transform[0], __transform[1], __transform[2])
		);
		vertex_submit(__v_buffer, pr_trianglelist, getTexture());
		matrix_set(matrix_world, matrix_build_identity());
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
		var __model_buffer = self._model_data;
		if (is_undefined(__model_buffer) || !buffer_exists(__model_buffer)) return;
		
		var __size = [
			__x_size / self._size[0],
			__y_size / self._size[1],
			__z_size / self._size[2]
		];
		
		var __model_buffer_size = buffer_get_size(__model_buffer);
		var __temp_buffer = buffer_create(__model_buffer_size, buffer_fixed, 1);
		buffer_copy(__model_buffer, 0, __model_buffer_size, __temp_buffer, 0);
		
		// Rewrite the x-, y-, and z-sizing data of all vertices (change positions)
		for (var __vt = 0; __vt < __model_buffer_size; __vt += 108) {
			for (var __vp = 0; __vp < 108; __vp += 36) {
				var __current_offset = __vt + __vp;
				
				var __x = buffer_peek(__temp_buffer, __current_offset + 0, buffer_f32);
				var __y = buffer_peek(__temp_buffer, __current_offset + 4, buffer_f32);
				var __z = buffer_peek(__temp_buffer, __current_offset + 8, buffer_f32);
				
				if (__current_offset + 36 < 108) {
					var __x2 = buffer_peek(__temp_buffer, __current_offset + 36 + 0, buffer_f32);
					var __y2 = buffer_peek(__temp_buffer, __current_offset + 36 + 4, buffer_f32);
					var __z2 = buffer_peek(__temp_buffer, __current_offset + 36 + 8, buffer_f32);
					
					var __prev_size = [
						__x2 - __x,
						__y2 - __y,
						__z2 - __z
					];
					
					var __new_size = matrix_build(__prev_size[0], __prev_size[1], __prev_size[2], 0, 0, 0, __size[0], __size[1], __size[2]);
					
					buffer_poke(__temp_buffer, __current_offset + 0, buffer_f32, (__x - __prev_size[0]) + __new_size[0]); // X
					buffer_poke(__temp_buffer, __current_offset + 4, buffer_f32, (__y - __prev_size[1]) + __new_size[1]); // Y
					buffer_poke(__temp_buffer, __current_offset + 8, buffer_f32, (__z - __prev_size[2]) + __new_size[2]); // Z
					
					buffer_poke(__temp_buffer, __current_offset + 36 + 0, buffer_f32, (__x2 - __prev_size[0]) + __new_size[0]); // X2
					buffer_poke(__temp_buffer, __current_offset + 36 + 4, buffer_f32, (__y2 - __prev_size[1]) + __new_size[1]); // Y2
					buffer_poke(__temp_buffer, __current_offset + 36 + 8, buffer_f32, (__z2 - __prev_size[2]) + __new_size[2]); // Z2
				}
			}
		}
		
		self._size = [__x_size, __y_size, __z_size];

		setModelData(__temp_buffer);
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
		return sprite_get_texture(self._model_texture, 0);
	}
	
	/// @function getSprite();
	/// @description Get the sprite of ingame model
	
	/// @returns {Asset.GMSprite}
	
	getSprite = function() {
		return self._model_texture;
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
		var __sprite = self._model_texture, __new_tex_map = [];
		if (is_undefined(__sprite) || !sprite_exists(__sprite)) return;
		for(var __i = 0; __i < sprite_get_number(__sprite); __i++) {
			__new_tex_map[__i] = sprite_get_uvs(__sprite, __i);
		}
		setTetxtureMap(__new_tex_map);
	}
	
	/// @function applyTextureMap();
	/// @description Apply texture map to the model
	
	applyTextureMap = function() {
		var __model_buffer = self._model_data, __tex_map = self._model_texture_map;
		if (is_undefined(__model_buffer) || !buffer_exists(__model_buffer)) then return;
		
		// Create uv data map from texture map
		var __uv_data = []; for (var __i = 0; __i <= array_length(__tex_map)-1; __i++) {
			var __current_face = __tex_map[__i];
			array_push(__uv_data,
				[
					[__current_face[0], __current_face[3]],
					[__current_face[0], __current_face[1]],
					[__current_face[2], __current_face[3]]
				],
				[
					[__current_face[2], __current_face[1]],
					[__current_face[2], __current_face[3]],
					[__current_face[0], __current_face[1]]
				]
			);
		}
		
		if (array_length(__uv_data) <= 0) return;
		
		var __model_buffer_size = buffer_get_size(__model_buffer);
		var __temp_buffer = buffer_create(__model_buffer_size, buffer_fixed, 1);
		buffer_copy(__model_buffer, 0, __model_buffer_size, __temp_buffer, 0);
			
		// Rewrite the uv data of all vertices
		for (var __vt = 0; __vt < __model_buffer_size; __vt += 108) {
			var __current_index = (__vt <= 0) ? 0 :  __vt / 108, __current_triangle = [];
			if (__current_index > array_length(__uv_data)-1) {
				var __modulo = 	(__current_index-array_length(__uv_data)) % 2;
				var __prev_index = (array_length(__uv_data)-1) - (1 - __modulo);
				__current_triangle = __uv_data[__prev_index];
			} else {
				__current_triangle = __uv_data[__current_index];
			}
			for (var __vp = 0; __vp <= array_length(__current_triangle)-1; __vp++) {
				var __offset =  __vt + 36 * __vp;
				if (__offset > __model_buffer_size) break;
				var __u = __current_triangle[__vp][0], __v = __current_triangle[__vp][1];
				buffer_poke(__temp_buffer, __offset + 24, buffer_f32, __u);
				buffer_poke(__temp_buffer, __offset + 28, buffer_f32, __v);
			}
		}
		
		setModelData(__temp_buffer);
	}
	
	// This has to be set here, otherwise it will cause an error because of the missing existance of the function
	setTexture();
	
	/// @function clearBuffers();
	/// @description Clear any and every buffer which is currently used by this class
	
	clearBuffers = function() {
		var __model = self._model_data;
		if (!is_undefined(__model) && buffer_exists(__model)) then buffer_delete(__model);
	}
}