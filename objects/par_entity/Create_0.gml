/// @description Initialize 3d-stuff

image_speed = 1;
image_index = 0;

// Z axis
z = 0;

// Create entity class
entity_class = new Entity();
// feather ignore once GM1041
entity_class.setParentId(self);

// Entity settings
entity_sprite = spr_animation_test;
frame_time = 0;
look_at = o_player;
plane_rot = 0;
