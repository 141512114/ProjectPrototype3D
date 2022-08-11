/// @description Initialize settings

// Vertex format
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
global.vformat = vertex_format_end();

// Create camera controller
instance_create(x, y, 0, o_camera_controller, "Camera");