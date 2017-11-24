/// @description Insert description here
// You can write your code in this editor

var vector_2x = 0;
var vector_2y = 1;

_velocity = [0, 0];

if(_move_state == player_movement_states.IDLE || _move_state = player_movement_states.WALKING)
{
	
	_move_state = player_movement_states.IDLE;
	
	// Poll the keybaord for move commandes
	if(keyboard_check(ord("D")))
	{
		_move_state = player_movement_states.WALKING;
		_move_direction_cmd = player_sprite_direction.RIGHT;
	}

	if(keyboard_check(ord("A")))
	{
		_move_state = player_movement_states.WALKING;
		_move_direction_cmd = player_sprite_direction.LEFT;
	}

	if(keyboard_check(ord("W")))
	{
		_move_state = player_movement_states.WALKING;
		_move_direction_cmd = player_sprite_direction.UP;
	}

	if(keyboard_check(ord("S")))
	{
		_move_state = player_movement_states.WALKING;
		_move_direction_cmd = player_sprite_direction.DOWN;
	}
	
	// Fire bullet
	if(_action_state == player_action_states.IDLE)
	{
		
		//look where you aree going unless commanded otherwise
		if(_move_state = player_movement_states.WALKING)
		{
			_look_direction_cmd = _move_direction_cmd;
		}
		
		if(mouse_check_button(mb_left))
		{
			audio_play_sound(snd_blaster,0,0);
			
			instance_create_layer(x,y,"layer_bullets",obj_bullet);
			_action_state = player_action_states.SHOOTING;
			cooldown = 10;
			
			//Get mouse location and turn that direction
			var xdif = mouse_x - x;
			var ydif = mouse_y - y;
			
			if(xdif > 0) //mouse right of player
			{
				if(xdif > abs(ydif)) //mouse mostly right
				{
					_look_direction_cmd = player_sprite_direction.RIGHT;
				}
				else if(ydif > 0) //mouse more down
				{
					_look_direction_cmd = player_sprite_direction.DOWN;
				}
				else //mouse more up
				{
					_look_direction_cmd = player_sprite_direction.UP;
				}
			}
			else //mouse left of player
			{
				if(abs(xdif) > abs(ydif)) //mouse mostly left
				{
					_look_direction_cmd = player_sprite_direction.LEFT;
				}
				else if(ydif > 0) //mouse more down
				{
					_look_direction_cmd = player_sprite_direction.DOWN;
				}
				else //mouse more up
				{
					_look_direction_cmd = player_sprite_direction.UP;
				}
			}
			
			if(_move_state = player_movement_states.IDLE)
			{
				_move_direction_cmd = _look_direction_cmd;
			}
			
		}
	}

	cooldown = cooldown - 1;
}

switch(_move_state)
{
	case player_movement_states.IDLE:
	//Execute move state IDLE
	{
		switch(_look_direction_cmd)
		{
			case player_sprite_direction.RIGHT:
			{
				sprite_index=spr_player_right;
			}
			break;
			case player_sprite_direction.LEFT:
			{
				sprite_index=spr_player_left;
			}
			break;
			case player_sprite_direction.UP:
			{
				sprite_index=spr_player_up;
			}
			break;
			case player_sprite_direction.DOWN:
			{
				sprite_index=spr_player_down;
			}
			break;
			default:
			break;
		}
		
		image_index=0;
		image_speed=0;
	}
	break;
	case player_movement_states.WALKING:
	//Execute move state WALKING
	{
		switch(_move_direction_cmd)
		{
			case player_sprite_direction.RIGHT:
			{
				_velocity[vector_2x] = 2;
			}
			break;
			case player_sprite_direction.LEFT:
			{
				_velocity[vector_2x] = -2;
			}
			break;
			case player_sprite_direction.UP:
			{
				_velocity[vector_2y] = -2;
			}
			break;
			case player_sprite_direction.DOWN:
			{
				_velocity[vector_2y] = 2;
			}
			break;
			default:
			break;
		}
		
		switch(_look_direction_cmd)
		{
			case player_sprite_direction.RIGHT:
			{
				sprite_index=spr_player_right;
			}
			break;
			case player_sprite_direction.LEFT:
			{
				sprite_index=spr_player_left;
			}
			break;
			case player_sprite_direction.UP:
			{
				sprite_index=spr_player_up;
			}
			break;
			case player_sprite_direction.DOWN:
			{
				sprite_index=spr_player_down;
			}
			break;
			default:
			break;
		}
		
		image_speed=2;
	}
	break;
	case player_movement_states.ROLLING:
	{

		image_speed=1;
		
		switch(_move_direction_cmd)
		{
			case player_sprite_direction.RIGHT:
			{
				_velocity[vector_2x] = ROLL_SPEED;
				sprite_index=spr_player_roll_right; 
			}
			break;
			case player_sprite_direction.LEFT:
			{
				_velocity[vector_2x] = -ROLL_SPEED;
				sprite_index=spr_player_roll_left;
			}
			break;
			case player_sprite_direction.UP:
			{
				_velocity[vector_2y] = -ROLL_SPEED;
				sprite_index=spr_player_roll_up;
			}
			break;
			case player_sprite_direction.DOWN:
			{
				_velocity[vector_2y] = ROLL_SPEED;
				sprite_index=spr_player_roll_down;
			}
			break;
			default:
			break;
		}
	}
	break;
	case player_movement_states.FALLING:
	{
		sprite_index = spr_player_falling;
		image_speed = 0.5;
	}
	break;
	case player_movement_states.DEAD:
	{
		
	}
	default:
	break;
}

move_and_contact_tiles(_collision_tilemap_id, 32, _velocity, true);

//Fall if no floor
if(tile_collide_at_points(_base_tilemap_id, 
						  [bbox_left, bbox_bottom-1], 
			              [bbox_right-1, bbox_bottom-1]) == false)
{

	_move_state = player_movement_states.FALLING;
		
	//move to center of tile...
}

//If we aren't dead yet, perform action
switch(_action_state)
{
	case player_action_states.IDLE:
	break;
	case player_action_states.SHOOTING:
	{
		if(cooldown < 1)
		{
			_action_state = player_action_states.IDLE;
		}
	}
	break;
	default:
	break;
}

if(_health <= 0)
{
	_dead = true;
	_move_state = player_movement_states.DEAD;
}