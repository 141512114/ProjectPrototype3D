/// @description Inherit the parent event

event_inherited();

item_class.setItemId(1);

// Modify model and reset its parent
model_class.setTexture(spr_flower);
if (vertex_buffer_exists(vertex_model)) then vertex_delete_buffer(vertex_model);
vertex_model = model_class.createModelVertex();
