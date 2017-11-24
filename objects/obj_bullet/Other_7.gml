/// @description Insert description here
// You can write your code in this editor
if(_bullet_state == bullet_states.COLLIDING
	&& sprite_index == spr_bullet_collide)
{
	instance_destroy();
}