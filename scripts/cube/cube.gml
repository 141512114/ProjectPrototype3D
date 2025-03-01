/// @function Cube(texture)
/// @description Cube class

/// @param {Asset.GMSprite} __texture

function Cube(__texture = spr_none) : Model() constructor {
    self._model_texture	= __texture;

    setTexture(__texture);

    /// @function createModelData();
	/// @description Get data of model

	createModelData = function() {
		var __temp_buffer =	vertex_create_cube(0, 0, 0, getSize(), self._model_texture_map);
		/// feather ignore once GM1041
		setModelData(__temp_buffer);
		applyTextureMap();
	}
}
