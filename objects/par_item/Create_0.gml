/// @description Instantiate item

image_speed = 0;
image_index = 0;

// Z axis
z = 0;

// Create the item class
item_class = new Item();

// Create the model
model_class = new Model();
// feather ignore once GM1041
model_class.setParentId(self);
model_class.clearVertexBuffers();
model_class.createModelData(CROSSED_SPRITE);
model_class.setPosition(DEFAULT_CUBE_SIZE/2, DEFAULT_CUBE_SIZE/2);
model_class.setSize(DEFAULT_CUBE_SIZE/2, DEFAULT_CUBE_SIZE/2, DEFAULT_CUBE_SIZE/2);