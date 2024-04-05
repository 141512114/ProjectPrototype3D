/// @function InventoryManager()
/// @description InventoryManager class

function InventoryManager() constructor {
    self.storage = ds_list_create();

    /// @function getStorage();
	/// @description Get the storage

    /// @returns {Id.DsList}

    getStorage = function () {
        return self.storage;
    }

    /// @function addItemToStorage(new_item);
	/// @description Add a new item to the storage

    /// @param {Struct|any} __new_item

    addItemToStorage = function (__new_item) {
        if (!ds_exists(getStorage(), ds_type_list)) return;
        ds_list_add(getStorage(), __new_item);
    }

    /// @function releaseDSList();
	/// @description Release the ds list stored in this object and free memory

    releaseDSList = function () {
        if (!ds_exists(getStorage(), ds_type_list)) return;
        ds_list_destroy(getStorage());
    }
}
