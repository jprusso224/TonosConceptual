///@param tile_map_id
///@param points...

var tile_map_id = argument[0];

// Found variable
var found = false;

// Point arrays vector
var vector2_x = 0;
var vector2_y = 1;

for(var i = 1; i < argument_count; i++)
{
	var point = argument[i];
	found = found || tilemap_get_at_pixel(tile_map_id, point[vector2_x], point[vector2_y]);
}

return found;