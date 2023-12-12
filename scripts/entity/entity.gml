/// @function Entity()
/// @description Entity class

function Entity() : Model() constructor {
	self._max_health_points = 2;
	self._health_points = self._max_health_points;
	self._look_dir = 0;
	self._move_speed = 6;
	
	/// @function getHealthPoints();
	/// @description Get health points of the entity
	
	getHealthPoints = function() {
		return self._health_points;
	}
	
	/// @function getMaxHealthPoints();
	/// @description Get the maximum health points of the entity
	
	getMaxHealthPoints = function() {
		return self._max_health_points;
	}
	
	/// @function setHealthPoints();
	/// @description Set health points of the entity
	
	/// @param {real} __hp
	
	setHealthPoints = function(__hp) {
		self._health_points = __hp;
	}
	
	/// @function setMaxHealthPoints();
	/// @description Set the maximum health points of the entity
	
	/// @param {real} __max_hp
	
	setMaxHealthPoints = function(__max_hp) {
		self._max_health_points = __max_hp;
	}
	
	/// @function getEntityPosition();
	/// @description Get position properties of entity
	
	getEntityPosition = function() {
		var __parent = getParentId();
		return (is_undefined(__parent)) ? [] : [__parent.x, __parent.y, __parent.z];
	}
	
	/// @function setEntityPosition(x, y, z);
	/// @description Set position properties of entity
	
	/// @param {real} __x
	/// @param {real} __y
	/// @param {real} __z
	
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
	
	getMoveSpeed = function() {
		return self._move_speed;
	}
	
	/// @function setMoveSpeed(move_speed);
	/// @description Set movement speed of the entity
	
	/// @param {real} __move_speed
	
	setMoveSpeed = function(__move_speed) {
		self._move_speed = __move_speed;
	}
	
	/// @function getEntityViewDirection();
	/// @description Get view direction of entity
	
	getEntityViewDirection = function() {
		return self._look_dir;
	}
	
	/// @function setEntityViewDirection(look_dir);
	/// @description Set view direction of entity
	
	/// @param {real} __look_dir
	
	setEntityViewDirection = function(__look_dir) {
		if (__look_dir < 0 || __look_dir > 360) then __look_dir = abs(abs(__look_dir) - 360);
		self._look_dir = __look_dir;
	}
	
	/// @function entityMoveSet(horizontal, vertical);
	/// @description Calculate entity moves
	
	/// @param {real} __h_move
	/// @param {real} __v_move
	
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
	
	manipulateEntityPosition = function(__dx, __dy, __len = 0) {
		var __parent = getParentId();
		
		// Fix diagonal movement (speed fix)
		var __dir = point_direction(0, 0, __dx, __dy);
		
		// Check if there is a solid object in front of the player
		// And if so: hinder him on moving through it
		if (checkEntityCollision(__dx, 0, __len) == false) then __parent.x += round(lengthdir_x(__len, __dir));
		if (checkEntityCollision(0, __dy, __len) == false) then __parent.y += round(lengthdir_y(__len, __dir));
	}
	
	/// @function checkEntityCollision(__dx, __dy, __len);
	/// @description Check for any collision with any solid object
	
	/// @param {real} __dx
	/// @param {real} __dy
	/// @param {real} __len
	
	checkEntityCollision = function(__dx, __dy, __len = 0) {
		var __parent = getParentId();
		if (is_undefined(__parent) || !instance_exists(__parent)) then return false;
		
		var __dir = point_direction(0, 0, __dx, __dy);
		var __len_x = 0, __len_y = 0;
		__len_x = round(lengthdir_x(__len, __dir));
		__len_y = round(lengthdir_y(__len, __dir));
		
		with (__parent) {
			if (place_meeting(x+__len_x, y+__len_y, [par_solid, par_entity])) {
				while (!place_meeting(x+sign(__len_x), y+sign(__len_y), [par_solid, par_entity])) {
					x += sign(__len_x);
					y += sign(__len_y);
				}
				return true;
			}
		}
		return false;
	}
}