/// @description Initialize 3d-stuff

// Inherit the parent event
event_inherited();

model_class.setTexture(spr_six_sides_test);
if (vertex_buffer_exists(vertex_model)) then vertex_delete_buffer(vertex_model);
vertex_model = model_class.createModelVertex();