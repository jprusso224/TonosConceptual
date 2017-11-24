/// @description Insert description here
// You can write your code in this editor

var vector_2x = 0;
var vector_2y = 1;

_velocity = [0, 0];

var good_decision = false;

var x_check = 0;
var y_check = 0;

/*
* HANDLE MIND STATE
*/
switch(_mind_state)
{
	case baddy_mind_states.IDLE:
	break;
	case baddy_mind_states.GUARDING:
	break;
	case baddy_mind_states.PATROLLING:
	break;
	case baddy_mind_states.ROAMING:
	{
		//Random movement
		if(_move_decision_cooldown < 1)
		{
			//decide to idle, look, or move.
			var decision = irandom_range(0,2);

			//choose direction to look
			var direction_cmd = irandom_range(0,3);
			var temp_look_dir = baddy_sprite_direction.DOWN; 
			
			switch(decision)
			{
				case 0: //IDLE
				break;
				case 1: //LOOK
				case 2: //MOVE
				{
					switch(direction_cmd)
					{
						case 0: temp_look_dir = baddy_sprite_direction.RIGHT; break;
						case 1: temp_look_dir = baddy_sprite_direction.LEFT; break;
						case 2: temp_look_dir = baddy_sprite_direction.UP; break;
						case 3: temp_look_dir = baddy_sprite_direction.DOWN; break;
					}
				}
				break;
			}
			
			//choose direction to move
			
			var temp_direction = baddy_sprite_direction.RIGHT; 
			
			switch(decision)
			{
				case 0: //IDLE
				case 1: //LOOK
				{
					_move_state = baddy_move_states.IDLE;
					good_decision = true;
				}
				break;
				case 2: //MOVE
				{
					switch(direction_cmd)
					{
						case 0: //RIGHT 
						{
							x_check = x + 32;
							y_check = y;
							temp_direction = baddy_sprite_direction.RIGHT; 
						}
						break;
						case 1: 
						{
							x_check = x - 32;
							y_check = y;
							temp_direction = baddy_sprite_direction.LEFT; 
						}
						break;
						case 2: 
						{
							x_check = x;
							y_check = y - 32;
							temp_direction = baddy_sprite_direction.UP; 
						}
						break;
						case 3: 
						{
							x_check = x;
							y_check = y + 32;
							temp_direction = baddy_sprite_direction.DOWN; 
						}
						break;
					}
					
					_move_state = baddy_move_states.WALKING;
				}
				break;
			}
		
			if(tile_collide_at_points(_base_tilemap_id,[x_check,y_check])
				&& tile_collide_at_points(_collision_tilemap_id,[x_check,y_check]) == false)
			{
				good_decision = true;
			}
		
			if(good_decision) //Otherwise keep trying to make a good decision
			{
				_look_direction_cmd = temp_look_dir;
				_move_direction_cmd = temp_direction;
				_move_decision_cooldown = MAX_MOVE_DECISION_COOLDOWN;
			}
		}
		
	}
	break;
	case baddy_mind_states.ENGAGING:
	{
		var player_dead = false;
		
		if(_action_cooldown < 1) //Shoot twice!
		{	
			with(obj_player)
			{
				player_dead = _dead;
			}
			
			if(player_dead == false)
			{
				audio_play_sound(snd_blaster,0,0);
				instance_create_layer(x,y,"layer_bullets",obj_bullet_baddy);
				_action_state = baddy_action_states.SHOOTING;
			
				_action_cooldown = 30;
			}
		}
	}
	break;
	default:
	break;
}

_move_decision_cooldown -= 1;

/*
* HANDLE MOVEMENT
*/

switch(_move_state)
{
	case baddy_move_states.IDLE:
	//Execute move state IDLE
	{
		switch(_look_direction_cmd)
		{
			case baddy_sprite_direction.RIGHT:
			{
				sprite_index=spr_baddy_right;
			}
			break;
			case baddy_sprite_direction.LEFT:
			{
				sprite_index=spr_baddy_left;
			}
			break;
			case baddy_sprite_direction.UP:
			{
				sprite_index=spr_baddy_up;
			}
			break;
			case baddy_sprite_direction.DOWN:
			{
				sprite_index=spr_baddy_down;
			}
			break;
			default:
			break;
		}
		
		image_index=0;
		image_speed=0;
	}
	break;
	case baddy_move_states.WALKING:
	//Execute move state WALKING
	{
		switch(_move_direction_cmd)
		{
			case baddy_sprite_direction.RIGHT:
			{
				_velocity[vector_2x] = 2;
				x_check = x + 16;
				y_check = y;
			}
			break;
			case baddy_sprite_direction.LEFT:
			{
				_velocity[vector_2x] = -2;
				x_check = x - 16;
				y_check = y;
			}
			break;
			case baddy_sprite_direction.UP:
			{
				_velocity[vector_2y] = -2;
				x_check = x;
				y_check = y - 16;
			}
			break;
			case baddy_sprite_direction.DOWN:
			{
				_velocity[vector_2y] = 2;
				x_check = x;
				y_check = y + 16;
			}
			break;
			default:
			break;
		}
		
		switch(_look_direction_cmd)
		{
			case baddy_sprite_direction.RIGHT:
			{
				sprite_index=spr_baddy_right;
			}
			break;
			case baddy_sprite_direction.LEFT:
			{
				sprite_index=spr_baddy_left;
			}
			break;
			case baddy_sprite_direction.UP:
			{
				sprite_index=spr_baddy_up;
			}
			break;
			case baddy_sprite_direction.DOWN:
			{
				sprite_index=spr_baddy_down;
			}
			break;
			default:
			break;
		}
		
		image_speed=2;
		
		if(tile_collide_at_points(_base_tilemap_id,[x_check,y_check])
			&& tile_collide_at_points(_collision_tilemap_id,[x_check,y_check]) == false)
		{
			//Move along
		}
		else
		{
			//STOP! Reavaluate life choices.
			_move_decision_cooldown = 0;
		}
	}
	break;
	case baddy_move_states.FALLING:
	{
		//sprite_index = spr_player_falling;
		//image_speed = 0.5;
	}
	break;
	default:
	break;
}

move_and_contact_tiles(_collision_tilemap_id, 32, _velocity, true);

if(_health <= 0)
{
	audio_sound_pitch(snd_explosion, random_range(0.8, 1.2));
	audio_play_sound(snd_dead,0,0);
	instance_destroy();
}

if(instance_exists(obj_player))
{
	var distToPlayer = distance_to_point(obj_player.x, obj_player.y)
	
	if(distToPlayer < _look_distance)
	{
		_mind_state = baddy_mind_states.ENGAGING;
	}
	else
	{
		_mind_state = baddy_mind_states.ROAMING;
	}
	
}

_action_cooldown -= 1;