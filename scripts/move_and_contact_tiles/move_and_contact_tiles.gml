///@param tile_map id
///@param tile_size
///@param velocity_array
///@param move

var tile_map_id = argument0;
var tile_size = argument1;
var velocity = argument2;
var move = argument3;

var vector2_x = 0;
var vector2_y = 1;

//Move horizontally
if(move)
{
	x += velocity[vector2_x];
}

//Moving right
if(velocity[vector2_x] > 0)
{
	var tile_right = tile_collide_at_points(tile_map_id, 
											[bbox_right-1, bbox_top+16], 
											[bbox_right-1, bbox_bottom-1]);
											
	if(tile_right)
	{
		x = bbox_right & ~(tile_size - 1);
		x -=bbox_right - x;
		velocity[@ vector2_x] = 0;
	}
}
else if(velocity[vector2_x] < 0) // Moving left
{
	var tile_left = tile_collide_at_points(tile_map_id, 
											[bbox_left, bbox_top+16], 
											[bbox_left, bbox_bottom-1]);
	if(tile_left)
	{
		x = bbox_left & ~(tile_size - 1);
		x += tile_size + x - bbox_left;
		velocity[@ vector2_x] = 0;
	}									
}
else
{
	// not moving horizontally
}

//Move vertically
if(move)
{
	y += velocity[vector2_y];
}

//Moving down
if(velocity[vector2_y] > 0)
{
	var tile_bottom = tile_collide_at_points(tile_map_id, 
											[bbox_left, bbox_bottom-1], 
											[bbox_right-1, bbox_bottom-1])
											
	if(tile_bottom)
	{
		y = bbox_bottom & ~(tile_size - 1);
		y -= bbox_bottom - y;
		velocity[@ vector2_y] = 0;
	}
}
else if(velocity[vector2_y] < 0) //Moving up
{
	var tile_top = tile_collide_at_points(tile_map_id, 
											[bbox_left, bbox_top+16], 
											[bbox_right-1, bbox_top+16])
											
	if(tile_top)
	{
		y = (bbox_top+16) & ~(tile_size - 1);
		y += tile_size + y - bbox_top-16;
		velocity[@ vector2_y] = 0;
	}
}
else
{
	//not moving vertically
}
	