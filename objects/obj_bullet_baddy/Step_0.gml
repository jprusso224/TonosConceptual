/// @description Insert description here
// You can write your code in this editor

switch(_bullet_state)
{
	case bullet_states.TRAVELING:
	{
		if(move_and_contact_tiles_for_bullets(_collision_tilemap_id, 32, _velocity))
		{
			_bullet_state = bullet_states.COLLIDING;
			audio_sound_pitch(snd_hit, random_range(1, 1.4));
			audio_play_sound(snd_hit,0,0);
		}
	}
	break;
	case bullet_states.COLLIDING:
	{
		//change sprite index to collision/explosion
		//when explosion animation complete, destroy this object
		sprite_index = spr_bullet_baddy_collide;
	}
	break;
	default:
	break;
}