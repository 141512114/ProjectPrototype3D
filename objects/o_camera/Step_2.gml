/// @description Calculate players viewing direction

// Exit this event if there is now target object
if (!instance_exists(view_target)) then exit;

xfrom = view_target.x + 32;
yfrom = view_target.y + 32;
zfrom = view_target.z + player_height;
	
// To whereever the user looks at
var __f_look_dir = view_target.entity_class.getEntityViewDirection();
xto = xfrom + dcos(__f_look_dir);
yto = yfrom - dsin(__f_look_dir);
zto = zfrom - dsin(0);