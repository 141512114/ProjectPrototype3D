/// @description Draw model in 3 dimensions and set up the entity in its 3d environment

draw_set_color(c_white);

gpu_set_cullmode(cull_noculling);

model_class.drawModelVertex();

gpu_set_cullmode(cull_counterclockwise);