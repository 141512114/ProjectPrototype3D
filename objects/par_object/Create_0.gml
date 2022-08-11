/// @description Initialize 3d-stuff

// Z axis
z = 0;

// Store model
model_class = new Model();
model_class.setParentId(id);
model_class.setPosition(DEFAULT_CUBE_SIZE/2, DEFAULT_CUBE_SIZE/2);
model_class.setTexture(spr_six_sides_test);
model_class.setModelData(SQUARE);