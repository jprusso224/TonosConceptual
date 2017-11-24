/// @description Insert description here
// You can write your code in this editor

enum baddy_move_states
{
	IDLE, //doing nothing
	WALKING,
	FALLING
}

enum baddy_mind_states
{
	IDLE, //doing nothing
	GUARDING, //standing still, looking for player
	ROAMING, //randomly walking around, looking for player
	PATROLLING, //following set path, looking for player
	ENGAGING, //player seen, maintaining line of sight, attack
}

enum baddy_action_states
{
	IDLE,
	SHOOTING
}

enum baddy_sprite_direction
{
	RIGHT,
	LEFT,
	UP,
	DOWN
}

MAX_MOVE_DECISION_COOLDOWN = 50;
MAX_BADDY_HEALTH = 100;

_health = MAX_BADDY_HEALTH;

_velocity = [0,0];
_action_cooldown = 0;
_move_decision_cooldown = 0;

_look_distance = 200;

_mind_state = baddy_mind_states.ROAMING;
_move_state = baddy_move_states.IDLE;
_action_state = baddy_action_states.IDLE;
_move_direction_cmd = baddy_sprite_direction.DOWN;
_look_direction_cmd = baddy_sprite_direction.DOWN;

var layer_id_col = layer_get_id("layer_tile_collisions");
_collision_tilemap_id = layer_tilemap_get_id(layer_id_col);

var layer_id_base = layer_get_id("layer_tile_base");
_base_tilemap_id = layer_tilemap_get_id(layer_id_base);