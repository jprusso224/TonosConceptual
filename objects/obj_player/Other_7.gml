/// @description Insert description here
// You can write your code in this editor

///FALLING ANIMATION END
if( _move_state == player_movement_states.FALLING && sprite_index == spr_player_falling )
{
	image_speed = 0;
	x = obj_spawn.x;
	y = obj_spawn.y;
	_move_state = player_movement_states.IDLE;
	sprite_index = spr_player_down;
	
	_health -= 25;
	audio_sound_pitch(snd_hit, random_range(1, 1.4));
	audio_play_sound(snd_hit,0,0);
}

///ROLLING ANIMATION END
if( _move_state == player_movement_states.ROLLING 
	&& (sprite_index == spr_player_roll_right 
		|| sprite_index == spr_player_roll_left
		|| sprite_index == spr_player_roll_down
		|| sprite_index == spr_player_roll_up))
{
	image_speed = 0;
	_move_state = player_movement_states.IDLE;
}