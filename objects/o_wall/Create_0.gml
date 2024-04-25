/// @description Inherit the parent event

event_inherited();

// Remove unnecessary faces
model_class.removeJunkFaces();
if (vertex_buffer_exists(vertex_model)) then vertex_delete_buffer(vertex_model);
vertex_model = model_class.createModelVertex();