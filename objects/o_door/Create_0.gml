/// @description Inherit the parent event

event_inherited();

// Modify model
model_class.setSize(DEFAULT_CUBE_SIZE, DEFAULT_CUBE_SIZE/2, DEFAULT_CUBE_SIZE);
model_class.setTexture(spr_test_door);
if (vertex_buffer_exists(vertex_model)) then vertex_delete_buffer(vertex_model);
vertex_model = model_class.createModelVertex();