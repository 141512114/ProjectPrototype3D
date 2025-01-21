/// @description Instantiate the player instance

image_speed = 0;
image_index = 0;

// Z axis
z = 0;

player_class = new Player();
// feather ignore once GM1041
player_class.setParentId(self);

// Settings
sensitivity = 17;

look_at = -1;
plane_rot = 0;

// Create the camera object
var __inst_camera = instance_create(x, y, z, o_camera, "Camera");
__inst_camera.view_target = id;
