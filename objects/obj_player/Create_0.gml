/// @description Insert description here
// You can write your code in this editor

cooldown = 0;

_velocity = [0, 0];

ROLL_SPEED = 6;

enum player_movement_states{
	IDLE,
	WALKING,
	ROLLING,
	FALLING,
	DEAD
}

enum player_action_states{
	IDLE,
	SHOOTING,
}

enum player_sprite_direction
{
	RIGHT,
	LEFT,
	UP,
	DOWN
}

_health = 100;
_dead = false;

_move_state = player_movement_states.IDLE;
_action_state = player_action_states.IDLE;
_move_direction_cmd = player_sprite_direction.DOWN;
_look_direction_cmd = player_sprite_direction.DOWN;

var layer_id_col = layer_get_id("layer_tile_collisions");
_collision_tilemap_id = layer_tilemap_get_id(layer_id_col);

var layer_id_base = layer_get_id("layer_tile_base");
_base_tilemap_id = layer_tilemap_get_id(layer_id_base);

cursor_sprite = spr_crosshair;
window_set_cursor(cr_none);

x = obj_spawn.x;
y = obj_spawn.y;