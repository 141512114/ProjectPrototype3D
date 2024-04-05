/// @description Inherit the parent event

event_inherited();

// Modify model and reset its parent
// feather ignore once GM1041
model_class.setParentId(self);
model_class.setTexture(spr_flower);