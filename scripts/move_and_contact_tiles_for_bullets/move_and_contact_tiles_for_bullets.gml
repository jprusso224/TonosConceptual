///@param tile_map id
///@param tile_size
///@param velocity_array

var tile_map_id = argument0;
var tile_size = argument1;
var velocity = argument2;

var vector2_x = 0;
var vector2_y = 1;

var bullet_collision = false;

//Move horizontally
x += velocity[vector2_x];

//Moving right
if(velocity[vector2_x] > 0)
{
	var tile_right = tile_collide_at_points(tile_map_id, 
											[bbox_right, bbox_top], 
											[bbox_right, bbox_bottom]);
											
	if(tile_right)
	{
		velocity[@ vector2_x] = 0;	
		bullet_collision = true;
	}
}
else if(velocity[vector2_x] < 0) // Moving left
{
	var tile_left = tile_collide_at_points(tile_map_id, 
											[bbox_left, bbox_top], 
											[bbox_left, bbox_bottom]);
	if(tile_left)
	{
		velocity[@ vector2_x] = 0;	
		bullet_collision = true;
	}									
}
else
{
	// not moving horizontally
}

//Move vertically
y += velocity[vector2_y];

//Moving down
if(velocity[vector2_y] > 0)
{
	var tile_bottom = tile_collide_at_points(tile_map_id, 
											[bbox_left, bbox_bottom], 
											[bbox_right, bbox_bottom])
											
	if(tile_bottom)
	{
		velocity[@ vector2_y] = 0;
		bullet_collision = true;
	}
}
else if(velocity[vector2_y] < 0) //Moving up
{
	var tile_top = tile_collide_at_points(tile_map_id, 
											[bbox_left, bbox_top+16], 
											[bbox_right, bbox_top+16])
											
	if(tile_top)
	{
		velocity[@ vector2_y] = 0;	
		bullet_collision = true;
	}
}
else
{
	//not moving vertically
}
	
return bullet_collision;