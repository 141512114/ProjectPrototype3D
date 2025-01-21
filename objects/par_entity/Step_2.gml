/// @description Get angle between own position and player position

var __animation_speed = 10;
var __frame_duration = 1 / __animation_speed;

frame_time += __animation_speed * delta_time;
// show_debug_message(frame_time);

// If enough time has passed to advance the frame
if (frame_time >= __frame_duration) {
    image_index += 1;
    frame_time -= __frame_duration;
    // Loop the animation if it exceeds the number of frames in the sprite
    if (image_index >= sprite_get_number(entity_sprite)) {
        image_index = 0;
    }
}

if (!instance_exists(look_at)) then exit;

var __position = entity_class.getEntityPosition();
var __xx = x-__position[0], __yy = y+__position[1];
var __dx = look_at.x-__position[0], __dy = look_at.y+__position[1];

plane_rot = point_direction(__xx, __yy, __dx, __dy) - 90;
