/// @description Inherit the parent event

event_inherited();

// Modify model
model_class.setTexture(spr_flower);
model_class.setSize(DEFAULT_CUBE_SIZE/2, DEFAULT_CUBE_SIZE/2, DEFAULT_CUBE_SIZE/2);
model_class.clearVertexBuffers();
model_class.setModelData(CROSSED_SPRITE);