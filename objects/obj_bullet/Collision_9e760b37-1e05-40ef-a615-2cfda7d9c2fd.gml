/// @description Insert description here
// You can write your code in this editor
if(_bullet_state == bullet_states.TRAVELING)
{
	_bullet_state = bullet_states.COLLIDING;
	audio_sound_pitch(snd_hit, random_range(1, 1.4));
	audio_play_sound(snd_hit,0,0);
}