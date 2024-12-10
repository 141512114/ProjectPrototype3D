/// @description Instantiate item

image_speed = 0;
image_index = 0;

// Z axis
z = 0;

// Create the item class
item_class = new Item();

// Create the model
model_class = new CrossedSprite();
// feather ignore once GM1041
model_class.setParentId(self);
model_class.createModelData();
model_class.setPosition(DEFAULT_CUBE_SIZE/2, DEFAULT_CUBE_SIZE/2);
model_class.setSize(DEFAULT_CUBE_SIZE/2, DEFAULT_CUBE_SIZE/2, DEFAULT_CUBE_SIZE/2);
vertex_model = model_class.createModelVertex();
