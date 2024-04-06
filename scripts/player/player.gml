/// @function Player()
/// @description Player class

function Player() : Entity() constructor {
	/// @function pickUpItem();
	/// @description Pick up nearby items
	
	pickUpItem = function () {
		var __pos = getEntityPosition();
		var __nearby_items = ds_list_create();
		var __num = collision_circle_list(__pos[0], __pos[1], 64, par_item, false, true, __nearby_items, false);
		if (__num > 0) {
		    for (var __i = 0; __i < __num; ++__i;) {
				var __current_item = __nearby_items[| __i];
		        instance_destroy(__current_item);
		    }
		}
		ds_list_destroy(__nearby_items);
	}
}