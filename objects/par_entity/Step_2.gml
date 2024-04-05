/// @description Get angle between own position and player position

if (!instance_exists(look_at)) then exit;

var __position = entity_class.getEntityPosition();
var __xx = x-__position[0], __yy = y+__position[1];
var __dx = look_at.x-__position[0], __dy = look_at.y+__position[1];

plane_rot = point_direction(__xx, __yy, __dx, __dy) - 90;
// feather ignore once GM1019
model_class.setRotation(0, 0, plane_rot);