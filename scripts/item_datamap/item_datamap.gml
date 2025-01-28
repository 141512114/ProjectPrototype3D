#region Primitive datamaps which contain information about an item each and will be collected inside a global variable

var __item_flower = ds_map_create();
ds_map_add(__item_flower, "name", "Flower");
ds_map_add(__item_flower, "sprite", spr_flower);

#endregion

// A globally available database containing information about every item in the game
global.item_database = ds_map_create();
ds_map_add_map(global.item_database, 1, __item_flower);
