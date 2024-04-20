/// @description Initialize 3d-stuff

image_speed = 0;
image_index = 0;

// Z axis
z = 0;

// Create entity class
entity_class = new Entity();
// feather ignore once GM1041
entity_class.setParentId(self);

// Create model class
model_class = new Model();
// feather ignore GM1041
model_class.setParentId(self);
model_class.createModelData(SPRITE);
model_class.setPosition(DEFAULT_CUBE_SIZE/2, DEFAULT_CUBE_SIZE/2);
vertex_model = model_class.createModelVertex();

// Entity settings
look_at = o_player;
plane_rot = 0;