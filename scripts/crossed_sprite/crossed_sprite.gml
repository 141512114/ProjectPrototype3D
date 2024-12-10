/// @function CrossedSprite(texture)
/// @description CrossedSprite class

/// @param {Asset.GMSprite} __texture

function CrossedSprite(__texture = spr_none) : Model() constructor {
    self._model_texture	= __texture;

    setTexture(__texture);

    /// @function createModelData();
	/// @description Get data of model

	createModelData = function() {
		var __temp_buffer =	vertex_create_crossed_sprite(0, 0, 0, getSize(), self._model_texture_map);

		setModelData(__temp_buffer);
		applyTextureMap();
	}
}
