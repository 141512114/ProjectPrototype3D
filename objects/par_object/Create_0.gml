/// @description Initialize 3d-stuff

image_speed = 0;
image_index = 0;

// Z axis
z = 0;

// Store model
model_class = new Model();
// feather ignore once GM1041
model_class.setParentId(self);
model_class.createModelData(SQUARE);
model_class.setPosition(DEFAULT_CUBE_SIZE/2, DEFAULT_CUBE_SIZE/2, DEFAULT_CUBE_SIZE);
model_class.setTexture(spr_six_sides_test);
vertex_model = model_class.createModelVertex();