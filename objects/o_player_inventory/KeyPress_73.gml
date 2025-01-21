var __inventory = inventory_manager_class.getStorage();

show_debug_message("-----------------");
show_debug_message("Inventory size: " + string(ds_list_size(__inventory)));

for (var __i = 0; __i < ds_list_size(__inventory); __i++) {
    var __current_slot = ds_list_find_value(__inventory, __i);
    if (!is_struct(__current_slot)) continue;
    show_debug_message("Item name: " + string(__current_slot.name));
}

show_debug_message("-----------------");
