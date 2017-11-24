/// @description Insert description here
// You can write your code in this editor

if(_bullet_state == bullet_states.TRAVELING)
{
	_bullet_state = bullet_states.COLLIDING;
	audio_sound_pitch(snd_explosion, random_range(0.8, 1.2));
	audio_play_sound(snd_explosion,0,0);
	
	with(other)
	{
		_health -= 20;
	}
	
}