/// @description Insert description here
// You can write your code in this editor
if(_move_state == player_movement_states.DEAD)
{
	room_restart();
}

if(instance_exists(obj_baddy) == false)
{
	room_restart();
}