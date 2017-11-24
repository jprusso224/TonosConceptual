/// @description Insert description here
// You can write your code in this editor

if(_dead)
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_big);
	draw_set_color(c_red);
	draw_text(room_width/2, room_height/2, "GAME OVER");
	
	draw_set_font(fnt_small);
	draw_text(room_width/2, room_height/2 + 50, "Press \"Enter\" to play again.");
}
else
{
	draw_self();
	draw_healthbar(0,0,100,16,_health,c_black,c_red,c_red,0,1,1);
}

if(instance_exists(obj_baddy) == false)
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_big);
	draw_set_color(c_white);
	draw_text(room_width/2, room_height/2, "YOU WIN!");
	
	draw_set_font(fnt_small);
	draw_text(room_width/2, room_height/2 + 50, "Press \"Enter\" to play again.");
}