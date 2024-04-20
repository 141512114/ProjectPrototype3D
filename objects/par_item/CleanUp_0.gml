/// @description Delete vertex buffer

model_class.clearBuffers();
if (vertex_buffer_exists(vertex_model)) then vertex_delete_buffer(vertex_model);
delete model_class;
delete item_class;