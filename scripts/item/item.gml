/// @function Item()
/// @description Item class

function Item() constructor {
    self.item_id = -1;
    self.identity = {};

    /// @function setItemId(id);
	/// @description Set the id of the item

    /// @param {Real} __id

    setItemId = function(__id) {
        self.item_id = __id;
        self.findIdentity();
    }

    /// @function setIdentity(new_identity);
	/// @description Set the identity of the item

    /// @param {Struct} __new_identity

    setIdentity = function (__new_identity) {
        self.identity = __new_identity;
    }

    /// @function findIdentity();
	/// @description Find the identity of an item inside the item datamap by the item id

    findIdentity = function () {
        var __identity_map = ds_map_find_value(global.item_database, self.item_id);
        var __identity_keys = ds_map_keys_to_array(__identity_map), __identity_values = ds_map_values_to_array(__identity_map);

        var __identity = {};

        for (var __i = 0; __i < array_length(__identity_keys); __i++) {
            var __key = __identity_keys[__i];
            __identity[$ __key] = __identity_values[__i];
        }

        self.setIdentity(__identity);
    }

    /// @function getIdentity();
	/// @description Get the identity of the item

    /// @returns {Struct}

    getIdentity = function () {
        return self.identity;
    }
}
