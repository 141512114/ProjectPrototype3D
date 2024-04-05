/// @function Item()
/// @description Item class

function Item() constructor {
    self.identity = {};

    /// @function setIdentity(new_identity);
	/// @description Set the identity of the item

    /// @param {Struct} __new_identity

    setIdentity = function (__new_identity) {
        self.identity = __new_identity;
    }

    /// @function getIdentity();
	/// @description Get the identity of the item

    /// @returns {Struct}

    getIdentity = function () {
        return self.identity;
    }
}
