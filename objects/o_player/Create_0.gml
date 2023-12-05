/// @description Inherit the parent event

event_inherited();

// Remove model
entity_class.clearVertexBuffers();
entity_class.setModelData();
// feather ignore once GM1019
entity_class.setTexture(undefined);
entity_class.setTetxtureMap();

// Settings
sensitivity = 13;

look_at = -1;

// Create camera object
var __inst = instance_create(x, y, z, o_camera, "Camera");
__inst.view_target = id;