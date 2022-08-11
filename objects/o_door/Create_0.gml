/// @description Inherit the parent event

event_inherited();

// Modify model
model_class.setSize(32, DEFAULT_CUBE_SIZE, DEFAULT_CUBE_SIZE);
model_class.applySize();
model_class.setTexture(spr_test_door);