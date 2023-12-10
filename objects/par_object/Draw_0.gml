/// @description Draw model in 3 dimensions and set up the entity in its 3d environment

draw_set_color(c_white);

var __position = model_class.getPosition(),
	__rotation = model_class.getRotation(),
	__transform = model_class.getTransform();
matrix_set(matrix_world, matrix_build(
		x+__position[0], y+__position[1], z+__position[2],
		__rotation[0], __rotation[1], __rotation[2],
		__transform[0], __transform[1], __transform[2]));
if (!is_undefined(model_class.getModelData())) {
	var __model = model_class.getModelData();
	var __tex = model_class.getTexture();
	
	vertex_submit(__model, pr_trianglelist, __tex);
}
matrix_set(matrix_world, matrix_build_identity());