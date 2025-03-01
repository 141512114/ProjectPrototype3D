// Enable lighting

draw_set_color(c_white);

shader_set(shd_lighting);

shader_set_uniform_f(shader_get_uniform(shd_lighting, "u_vLightDir"), -1, 1, -1);
shader_set_uniform_f(shader_get_uniform(shd_lighting, "u_vLightColor"), 1, 1, 1, 1);
