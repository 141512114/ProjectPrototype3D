/// @description Initialize 3d world

// GPU settings
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

gpu_set_cullmode(cull_counterclockwise);

// Initialize camera settings
fov = 80;
player_height = 40;

znear = 1;
zfar = 1000;

view_target = o_player;

// Important for camera direction
xfrom = 0;
yfrom = 0;
zfrom = 0;

xto = 0;
yto = 0;
zto = 0;

// Important for grid
grid_vertex_buffer = create_grid(0, 0, 0, 64, room_width, room_height, c_white, 1);