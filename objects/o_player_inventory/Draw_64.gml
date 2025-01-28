/// @description Draw the inventory

var __inventory = inventory_manager_class.getStorage();

if (!ds_exists(__inventory, ds_type_list)) return;

var __screen_w = window_get_width(), __screen_y = window_get_height();

for (var __i = 0; __i < ds_list_size(__inventory); __i++) {
    var __current_slot = ds_list_find_value(__inventory, __i);
    var __sprite_w = sprite_get_width(__current_slot.sprite), __sprite_h = sprite_get_height(__current_slot.sprite);
    var __offset = 16;
    if (!is_struct(__current_slot)) continue;
    draw_sprite(
        __current_slot.sprite,
        0,
        (__screen_w / 2 + (__sprite_w + __offset) * __i - ((__sprite_w + __offset) / 2) * (ds_list_size(__inventory) - 1)) - __sprite_w / 2,
        __screen_y - __sprite_h - 32
        );
}
