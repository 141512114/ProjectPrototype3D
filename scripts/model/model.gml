/// @function Model()
/// @description Model class

function Model() constructor {
	self._parent			= undefined;
	
	self._model_type		= undefined;
	self._model_data		= undefined;
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
	
	/// @returns {Any|Undefined}
	
	getParentId = function() {
		return self._parent;
	}
	
	/// @function setParentId(id);
	/// @description Set parent (object index or id) of ingame model
	
	/// @param {Asset.GMObject|any} __parent
	
	setParentId = function(__parent) {
		self._parent = __parent;
	}
	
	/// @function getModelData();
	/// @description Get data of model
	
	/// @returns {Id.VertexBuffer|undefined}
	
	getModelData = function() {
		return self._model_data;
	}
	
	/// @function getModelType();
	/// @description Get type of model
	
	/// @returns {real|undefined}
	
	getModelType = function() {
		return self._model_type;
	}
	
	/// @function setModelData(model);
	/// @description Set model data
	
	/// @param {real|Id.VertexBuffer} __model_data
	
	setModelData = function(__model_data) {
		self._model_type = typeof(__model_data) == "number" ? __model_data : MODEL;
		self._model_data = (is_undefined(__model_data)) ? undefined : model_choose_variant(__model_data, _model_texture_map, _size);
	}
	
	/// @function removeJunkFaces();
	/// @description Remove unnecessary faces of the (best would be static) model, which the player won't see anyways
	
	removeJunkFaces = function() {
		var __parent = getParentId();
		setModelData(vertex_remove_face(__parent, getModelData()));
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
		self._size = [__x_size, __y_size, __z_size];
		applySize();
	}
	
	/// @function applySize();
	/// @description Apply size to the model (IMPORTANT! Shouldn't be used during runtime. Use setTransform() instead)
	
	applySize = function() {
		var __model = getModelData(), __size = getSize();
		
		// Make sure there is a model to work with
		if (is_undefined(__model)) then return;
		
		var __model_buffer = buffer_create_from_vertex_buffer(__model, buffer_fixed, 1);
			
		// Rewrite the x-, y-, and z-sizing data of all vertices (change positions)
		var __model_buffer_size = buffer_get_size(__model_buffer), __j = 0; for (var __i=0; __i<__model_buffer_size; __i+=36) {
			var __x_orientation = 0, __y_orientation = 0, __z_orientation = 0;
				
			var __x = buffer_peek(__model_buffer, __i + 0, buffer_f32),
				__y = buffer_peek(__model_buffer, __i + 4, buffer_f32),
				__z = buffer_peek(__model_buffer, __i + 8, buffer_f32);
				
			if (__i+36 >= __model_buffer_size) {
				__x_orientation = sign(__x);
				__y_orientation = sign(__y);
				__z_orientation = sign(__z);
			} else {
				var __x2 = buffer_peek(__model_buffer, __i+36 + 0, buffer_f32),
					__y2 = buffer_peek(__model_buffer, __i+36 + 4, buffer_f32),
					__z2 = buffer_peek(__model_buffer, __i+36 + 8, buffer_f32);
					
				var __x_vec = sign(__x - __x2), __y_vec = sign(__y - __y2), __z_vec = sign(__z - __z2);
				__x_orientation = (__x == __x2) ? sign(__x) : ((__x_vec == 0) ? -1 : __x_vec);
				__y_orientation = (__y == __y2) ? sign(__y) : ((__y_vec == 0) ? 1 : __y_vec);
				__z_orientation = (__z == 0 && __z2 == 0) ? 0 : ((__z_vec == 0 || __z_vec == -1) ? __z_vec+1 : __z_vec);
			}
				
			buffer_poke(__model_buffer, __i + 0, buffer_f32, 0 + __x_orientation * __size[0]/2); // X
			buffer_poke(__model_buffer, __i + 4, buffer_f32, 0 + __y_orientation * __size[1]/2); // Y
			buffer_poke(__model_buffer, __i + 8, buffer_f32, 0 + __z_orientation * __size[2]); // Z
			__j++;
		}

		// feather ignore once GM1041
		setModelData(vertex_create_buffer_from_buffer(__model_buffer, global.vformat));
		buffer_delete(__model_buffer);
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
		return (is_undefined(self._model_texture)) ? sprite_get_texture(-1, 0) : sprite_get_texture(self._model_texture, 0);
	}
	
	/// @function getSprite();
	/// @description Get the sprite of ingame model
	
	/// @returns {Asset.GMSprite}
	
	getSprite = function() {
		return (is_undefined(self._model_texture)) ? spr_none : self._model_texture;
	}
	
	/// @function setTexture(texture);
	/// @description Set the texture of ingame model
	
	/// @param {Asset.GMSprite|any} __tex
	
	setTexture = function(__tex = spr_none) {
		self._model_texture = __tex;
		generateTetxtureMap();
		if (is_undefined(getModelData())) return;
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
		var __model = getModelData(), __tex_map = getTextureMap();
		
		// Make sure there is a model to work with
		if (is_undefined(__model) || is_undefined(__tex_map)) then return;
		
		// Create uv data map from texture map
		var __uv_data = [];
		for (var __i = 0; __i < array_length(__tex_map); __i++) {
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
			
		var __model_buffer = buffer_create_from_vertex_buffer(__model, buffer_fixed, 1);
			
		// Rewrite the uv data of all vertices
		var __model_buffer_size = buffer_get_size(__model_buffer);
		for (var __f = 0; __f < array_length(__uv_data)-1; __f++;) {
			var __offset =  36 * __f;
			if (__offset > __model_buffer_size) break;
			buffer_poke(__model_buffer, __offset + 24, buffer_f32, __uv_data[__f][0]); // U
			buffer_poke(__model_buffer, __offset + 28, buffer_f32, __uv_data[__f][1]); // V
		}

		// feather ignore once GM1041
		setModelData(vertex_create_buffer_from_buffer(__model_buffer, global.vformat));
		buffer_delete(__model_buffer);
	}
	
	// This has to be set here, otherwise it will cause an error because of the missing existance of the function
	setTexture();
	
	/// @function clearVertexBuffers();
	/// @description Clear all vertex buffers, which are currently used by this class
	
	clearVertexBuffers = function() {
		var __model = getModelData();
		if (is_undefined(__model)) return;
		vertex_delete_buffer(__model);
	}
}