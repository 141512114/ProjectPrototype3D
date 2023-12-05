/// @function instance_create(x, y, z, object[, layer, depth]);
/// @description Create an instance at a given position (x, y, z) on a specified layer

/// @param {real} __xx
/// @param {real} __yy
/// @param {real} __zz
/// @param {Asset.GMObject|any} __object
/// @param {string} __on_layer
/// @param {real} __w_depth

function instance_create(__xx, __yy, __zz, __object, __on_layer = "Instances", __w_depth = 0){
	var __this_layer = layer_get_id(__on_layer); if (!layer_exists(__this_layer)) {
		__this_layer = layer_create(__w_depth, __on_layer);
	}
	
	var __inst = instance_create_layer(__xx, __yy, __this_layer, __object);
	__inst.z = __zz;
	
	return __inst;
}