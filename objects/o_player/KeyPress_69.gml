var __nearby_items = ds_list_create();
var __num = collision_circle_list(x, y, 64, par_item, false, true, __nearby_items, false);
for (var __i = 0; __i < __num; ++__i) {
	var __current_item = __nearby_items[| __i];
    player_class.pickUpItem(__current_item);
    instance_destroy(__current_item);
}
ds_list_destroy(__nearby_items);
