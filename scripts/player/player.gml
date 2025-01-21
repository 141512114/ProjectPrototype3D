/// @function Player()
/// @description Player class

function Player() : Entity() constructor {
	self.inst_inventory = instance_create(0, 0, 0, o_player_inventory, "General");

	/// @function pickUpItem();
	/// @description Pick up an item

	/// @param {Asset.GMObject} __item

	pickUpItem = function (__item) {
		var __inventory = self.inst_inventory.inventory_manager_class;
		__inventory.addItemToStorage(__item.item_class.getIdentity());
	}
}
