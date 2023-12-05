/// @function Entity()
/// @description Entity class

function Entity() : Model() constructor {
	_max_health_points = 2;
	_health_points = _max_health_points;
	_look_dir = 0;
	_move_speed = 8;
	
	/// @function getHealthPoints();
	/// @description Get health points of the entity
	
	getHealthPoints = function() {
		return _health_points;
	}
	
	/// @function getMaxHealthPoints();
	/// @description Get the maximum health points of the entity
	
	getMaxHealthPoints = function() {
		return _max_health_points;
	}
	
	/// @function setHealthPoints();
	/// @description Set health points of the entity
	
	/// @param {real} __hp
	
	setHealthPoints = function(__hp) {
		_health_points = __hp;
	}
	
	/// @function setMaxHealthPoints();
	/// @description Set the maximum health points of the entity
	
	/// @param {real} __max_hp
	
	setMaxHealthPoints = function(__max_hp) {
		_max_health_points = __max_hp;
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
		__parent.x = __x;
		__parent.y = __y;
		__parent.z = __z;
	}
	
	/// @function getMoveSpeed();
	/// @description Get movement speed of the entity
	
	getMoveSpeed = function() {
		return _move_speed;
	}
	
	/// @function setMoveSpeed(move_speed);
	/// @description Set movement speed of the entity
	
	/// @param {real} __move_speed
	
	setMoveSpeed = function(__move_speed) {
		_move_speed = __move_speed;
	}
	
	/// @function getEntityViewDirection();
	/// @description Get view direction of entity
	
	getEntityViewDirection = function() {
		return _look_dir;
	}
	
	/// @function setEntityViewDirection(look_dir);
	/// @description Set view direction of entity
	
	/// @param {real} __look_dir
	
	setEntityViewDirection = function(__look_dir) {
		if (__look_dir < 0 || __look_dir > 360) then __look_dir = abs(abs(__look_dir) - 360);
		_look_dir = __look_dir;
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
			__dx += __s_h_move * dcos(_look_dir) * __move_speed;
			__dy += __s_h_move * dsin(-_look_dir) * __move_speed;
			__len = __move_speed;
		}
		// Movement on the y-axis (vertical)
		if (__s_v_move != 0) {
			__dx += __s_v_move * dsin(-_look_dir) * __move_speed;
			__dy += -__s_v_move * dcos(_look_dir) * __move_speed;
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
		var __parent_pos = getEntityPosition();
		
		// Fix diagonal movement (speed fix)
		var __dir = point_direction(0, 0, __dx, __dy);
		var __len_x = 0, __len_y = 0;
		__len_x = lengthdir_x(__len, __dir);
		__len_y = lengthdir_y(__len, __dir);
		
		// Check if there is a solid object in front of the player
		// And if so: hinder him on moving through it
		if (checkEntityCollision(__dx, 0) == true) then __len_x = 0;
		if (checkEntityCollision(0, __dy) == true) then __len_y = 0;

		setEntityPosition(__parent_pos[0]+__len_x, __parent_pos[1]+__len_y);
	}
	
	/// @function checkEntityCollision(__dx, __dy);
	/// @description Check for any collision with any solid object
	
	/// @param {real} __dx
	/// @param {real} __dy
	
	checkEntityCollision = function(__dx = 0, __dy = 0) {
		var __parent = getParentId();
		if (is_undefined(__parent) || !instance_exists(__parent)) then return;
		with (__parent) {
			if (place_meeting(x+__dx, y+__dy, par_solid)) {
				while (!place_meeting(x+sign(__dx), y+sign(__dy), par_solid)) {
					x += sign(__dx);
					y += sign(__dy);
				}
				return true;
			}
		}
		return false;
	}
}