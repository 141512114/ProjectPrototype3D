/// @function Entity()
/// @description Entity class

function Entity() constructor {
	self._parent			= undefined;
	
	self._max_health_points = 2;
	self._health_points		= self._max_health_points;
	self._look_dir			= 0;
	self._move_speed		= 6;
	
	/// @function getParentId();
	/// @description Get parent id of the entity
	/// @returns {Any|Undefined}
	
	getParentId = function() {
		return self._parent;
	}
	
	/// @function setParentId(id);
	/// @description Set parent (object index or id) of entity
	
	/// @param {Asset.GMObject|any} __parent
	
	setParentId = function(__parent) {
		self._parent = __parent;
	}

	/// @function getHealthPoints();
	/// @description Get health points of the entity
	
	/// @returns {Real}

	getHealthPoints = function() {
		return self._health_points;
	}

	/// @function getMaxHealthPoints();
	/// @description Get the maximum health points of the entity
	
	/// @returns {Real}

	getMaxHealthPoints = function() {
		return self._max_health_points;
	}

	/// @function setHealthPoints(hp);
	/// @description Set health points of the entity

	/// @param {real} __hp
	
	/// @returns

	setHealthPoints = function(__hp) {
		self._health_points = __hp;
	}

	/// @function setMaxHealthPoints(max_hp);
	/// @description Set the maximum health points of the entity

	/// @param {real} __max_hp
	
	/// @returns

	setMaxHealthPoints = function(__max_hp) {
		self._max_health_points = __max_hp;
	}

	/// @function getEntityPosition();
	/// @description Get position properties of entity
	
	/// @returns {Array}

	getEntityPosition = function() {
		var __parent = getParentId();
		return (is_undefined(__parent)) ? [] : [__parent.x, __parent.y, __parent.z];
	}

	/// @function setEntityPosition(x, y, z);
	/// @description Set position properties of entity

	/// @param {real} __x
	/// @param {real} __y
	/// @param {real} __z
	
	/// @returns

	setEntityPosition = function(__x = 0, __y = 0, __z = 0) {
		var __parent = getParentId();
		if (is_undefined(__parent) || !instance_exists(__parent)) then return;
		with (__parent) {
			x = round(__x);
			y = round(__y);
			z = round(__z);
		}
	}

	/// @function getMoveSpeed();
	/// @description Get movement speed of the entity
	
	/// @returns {Real}

	getMoveSpeed = function() {
		return self._move_speed;
	}

	/// @function setMoveSpeed(move_speed);
	/// @description Set movement speed of the entity

	/// @param {real} __move_speed
	
	/// @returns

	setMoveSpeed = function(__move_speed) {
		self._move_speed = __move_speed;
	}

	/// @function getEntityViewDirection();
	/// @description Get view direction of entity
	
	/// @returns {Real}

	getEntityViewDirection = function() {
		return self._look_dir;
	}

	/// @function setEntityViewDirection(look_dir);
	/// @description Set view direction of entity

	/// @param {real} __look_dir
	
	/// @returns

	setEntityViewDirection = function(__look_dir) {
		if (__look_dir < 0 || __look_dir > 360) then __look_dir = abs(abs(__look_dir) - 360);
		self._look_dir = __look_dir;
	}

	/// @function entityMoveSet(horizontal, vertical);
	/// @description Calculate entity moves

	/// @param {real} __h_move
	/// @param {real} __v_move
	
	/// @returns {Array<Real>}

	entityMoveSet = function(__h_move, __v_move) {
		var __s_h_move = sign(__h_move), __s_v_move = sign(__v_move);
		var __move_speed = getMoveSpeed();
		var __dx = 0, __dy = 0, __len = 0;
		// Movement on the x-axis (horizontal)
		if (__s_h_move != 0) {
			__dx += __s_h_move * dcos(self._look_dir) * __move_speed;
			__dy += __s_h_move * dsin(-self._look_dir) * __move_speed;
			__len = __move_speed;
		}
		// Movement on the y-axis (vertical)
		if (__s_v_move != 0) {
			__dx += __s_v_move * dsin(-self._look_dir) * __move_speed;
			__dy += -__s_v_move * dcos(self._look_dir) * __move_speed;
			__len = __move_speed;
		}

		return [__dx, __dy, __len];
	}

	/// @function manipulateEntityPosition(__dx, __dy, __len);
	/// @description Manipulate the position of an entity (on x/y axes)

	/// @param {real} __dx
	/// @param {real} __dy
	/// @param {real} __len
	
	/// @returns

	manipulateEntityPosition = function(__dx, __dy, __len = 0) {
		var __parent = getParentId();
		var __pos = getEntityPosition();

		// Fix diagonal movement (speed fix)
		var __dir = point_direction(0, 0, __dx, __dy);

		// Check if there is a solid object in front of the entity
		// And if so: hinder him on moving through it
		if (checkEntityCollision(__dx, 0, __len) == false) then __parent.x += round(lengthdir_x(__len, __dir));
		if (checkEntityCollision(0, __dy, __len) == false) then __parent.y += round(lengthdir_y(__len, __dir));
	}

	/// @function checkEntityCollision(__dx, __dy, __len);
	/// @description Check for any collision with any solid object

	/// @param {real} __dx
	/// @param {real} __dy
	/// @param {real} __len
	
	/// @returns {bool}

	checkEntityCollision = function(__dx, __dy, __len = 0) {
		var __parent = getParentId();
		if (is_undefined(__parent) || !instance_exists(__parent)) then return false;

		var __dir = point_direction(0, 0, __dx, __dy);
		var __len_x = 0, __len_y = 0;
		__len_x = round(lengthdir_x(__len, __dir));
		__len_y = round(lengthdir_y(__len, __dir));
		
		var __can_collide = [par_object, par_entity];

		with (__parent) {
			if (place_meeting(x+__len_x, y+__len_y, __can_collide)) {
				while (!place_meeting(x+sign(__len_x), y+sign(__len_y), __can_collide)) {
					x += sign(__len_x);
					y += sign(__len_y);
				}
				return true;
			}
		}
		return false;
	}
}
