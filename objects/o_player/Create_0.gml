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

// Find the camera object and assign the player as the view target
var __inst_camera = instance_find(o_camera, 0);
__inst_camera.view_target = self;
