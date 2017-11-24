/// @description Insert description here
// You can write your code in this editor
//Set up bullet movement

if(instance_exists(obj_player))
{
	direction = point_direction(x,y,obj_player.x,obj_player.y);
	direction = direction + random_range(-1,1);
	var temp_speed = 7.5;

	var dx = temp_speed * dcos(direction);
	var dy = temp_speed * -dsin(direction);

	_velocity = [dx, dy];

	_bullet_state = bullet_states.TRAVELING;

	var layer_id_col = layer_get_id("layer_tile_collisions");
	_collision_tilemap_id = layer_tilemap_get_id(layer_id_col);
}
else
{
	instance_destroy();
}

//image_angle = direction;/// @description Insert description here
// You can write your code in this editor
