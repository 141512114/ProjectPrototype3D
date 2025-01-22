var __look_dir = player_class.getEntityViewDirection();

var __hitbox_x = lengthdir_x(64, __look_dir);
var __hitbox_y = lengthdir_y(64, __look_dir);

var __hitbox = instance_create(x + __hitbox_x, y + __hitbox_y, z, o_player_hitbox);
__hitbox.image_angle = __look_dir;
__hitbox.alarm[0] = 1;
