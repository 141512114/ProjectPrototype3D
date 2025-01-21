/// @description Delete vertex buffer

delete item_class.identity;

model_class.clearBuffers();
if (vertex_buffer_exists(vertex_model)) then vertex_delete_buffer(vertex_model);

// Delete classes which makeup this instance
delete model_class;
delete item_class;
