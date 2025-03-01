/// @description Draw model in 3 dimensions and set up the entity in its 3d environment

event_inherited();

gpu_set_cullmode(cull_noculling);

model_class.drawModelVertex(vertex_model);

gpu_set_cullmode(cull_counterclockwise);

shader_reset();