if(keyboard_check_pressed(vk_space))
{
	go = !go;
}

if(keyboard_check_pressed(vk_up))
{
	camera_set_view_size(view_camera[0], camera_get_view_width(view_camera[0]) - 1600, camera_get_view_height(view_camera[0]) - 1200);
	camera_set_view_pos(view_camera[0], camera_get_view_x(view_camera[0]) + 800, camera_get_view_y(view_camera[0]) + 600);
}

if(keyboard_check_pressed(vk_down))
{
	camera_set_view_size(view_camera[0], camera_get_view_width(view_camera[0]) + 1600, camera_get_view_height(view_camera[0]) + 1200);
	camera_set_view_pos(view_camera[0], camera_get_view_x(view_camera[0]) - 800, camera_get_view_y(view_camera[0]) - 600);
}

if(keyboard_check_pressed(ord("W")))
{
	camera_set_view_pos(view_camera[0], camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]) - 500);
}

if(keyboard_check_pressed(ord("S")))
{
	camera_set_view_pos(view_camera[0], camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]) + 500);
}

if(keyboard_check_pressed(ord("A")))
{
	camera_set_view_pos(view_camera[0], camera_get_view_x(view_camera[0]) - 500, camera_get_view_y(view_camera[0]));
}

if(keyboard_check_pressed(ord("D")))
{
	camera_set_view_pos(view_camera[0], camera_get_view_x(view_camera[0]) + 500, camera_get_view_y(view_camera[0]));
}

if(keyboard_check_pressed(ord("N")))
{
	var _parameter_file = file_text_open_write("number.txt");
	
	if(real(number) < 9)
	{
		file_text_write_string(_parameter_file, "0" + string(real(number) + 1));
		file_text_close(_parameter_file);
	}
	
	else if(real(number) >= 9 && real(number) < 99)
	{
		file_text_write_string(_parameter_file, string(real(number) + 1));
		file_text_close(_parameter_file);
	}
	
	game_restart();
}

if(keyboard_check_pressed(ord("P")))
{
	var _parameter_file = file_text_open_write("number.txt");
	
	if(real(number) > 0 && real(number) <= 10)
	{
		file_text_write_string(_parameter_file, "0" + string(real(number) - 1));
		file_text_close(_parameter_file);
	}
	
	else if(real(number) > 10)
	{
		file_text_write_string(_parameter_file, string(real(number) - 1));
		file_text_close(_parameter_file);
	}
	
	game_restart();
}

if(keyboard_check_pressed(vk_escape))
{
	var _number_file = file_text_open_write("number.txt");
	file_text_write_string(_number_file, "00");
	file_text_close(_number_file);
	
	game_restart();
}

if(solved || !go) exit;
	
var _possible_tiles = [];
	
for(var _i = 0; _i < 2; _i++)
{	
	var _neighbour_a = current_a;
	var _neighbour_c = current_c - 1 + _i * 2;
	var _neighbour_r = current_r;
		
	if(_neighbour_c < -column_num || _neighbour_c > column_num) continue;
		
	if(map[_neighbour_a][column_num + _neighbour_c][row_num + _neighbour_r] == end_tile)
	{
		solved = true;
		
		for(var _j = 0; _j < array_length(path); _j++)
		{
			var _path_tile_a = path[_j][0];
			var _path_tile_c = path[_j][1];
			var _path_tile_r = path[_j][2];
		
			var _path_tile = instance_create_layer(global.origin + global.tile_size * (_path_tile_a / 2 + _path_tile_c), global.origin - global.tile_size * (sqrt(3) + (_path_tile_a / 2 + _path_tile_r)), "instances", obj_hexagon);
			
			with(_path_tile)
			{
				image_index = 5;
				depth = -1000;
			}
		}
		exit;
	}
	
	if(map[_neighbour_a][column_num + _neighbour_c][row_num + _neighbour_r] == normal_tile && explored[_neighbour_a][column_num + _neighbour_c][row_num + _neighbour_r] == false)
	{
		array_push(_possible_tiles, [_neighbour_a, _neighbour_c, _neighbour_r]);
	}
}
	
for(var _i = 0; _i < 4; _i++)
{
	var _neighbour_a = 1 - current_a;
	var _neighbour_c = current_c + current_a - 1 + (_i % 2);
	var _neighbour_r = current_r + current_a + floor(_i / 2) * -1;
		
	if(_neighbour_r < -row_num || _neighbour_r > row_num || _neighbour_c > column_num || _neighbour_c < -column_num) continue;
		
	if(map[_neighbour_a][column_num + _neighbour_c][row_num + _neighbour_r] == end_tile)
	{
		solved = true;
		
		for(var _j = 0; _j < array_length(path); _j++)
		{
			var _path_tile_a = path[_j][0];
			var _path_tile_c = path[_j][1];
			var _path_tile_r = path[_j][2];
		
			var _path_tile = instance_create_layer(global.origin + global.tile_size * (_path_tile_a / 2 + _path_tile_c), global.origin - global.tile_size * (sqrt(3) + (_path_tile_a / 2 + _path_tile_r)), "instances", obj_hexagon);
			
			with(_path_tile)
			{
				image_index = 5;
				depth = -1000;
			}
		}
		exit;
	}
	
	else if(map[_neighbour_a][column_num + _neighbour_c][row_num + _neighbour_r] == normal_tile && explored[_neighbour_a][column_num + _neighbour_c][row_num + _neighbour_r] == false)
	{
		array_push(_possible_tiles, [_neighbour_a, _neighbour_c, _neighbour_r]);
	}
}

var _num_of_possible_tiles = array_length(_possible_tiles);

if(_num_of_possible_tiles > 0)
{	
	
	var _selected_a = _possible_tiles[0][0];
	var _selected_c = _possible_tiles[0][1];
	var _selected_r = _possible_tiles[0][2];
	
	if(_num_of_possible_tiles > 1)
	{
		array_push(nodes, current_a, current_c, current_r);
	}
	
	var _explored = instance_create_layer(global.origin + global.tile_size * (_selected_a / 2 + _selected_c), global.origin - global.tile_size * (sqrt(3) + (_selected_a / 2 + _selected_r)), "instances", obj_hexagon);
			
	with(_explored)
	{
		image_index = 4;
		depth = -500;
	}
	
	current_a = _selected_a;
	current_c = _selected_c;
	current_r = _selected_r;
	explored[_selected_a][column_num + _selected_c][row_num + _selected_r] = true;
	array_push(path, [_selected_a, _selected_c, _selected_r]);
}

else
{
	current_r = array_pop(nodes);
	current_c = array_pop(nodes);
	current_a = array_pop(nodes);
	
	while(path[array_length(path) - 1][0] != current_a || path[array_length(path) - 1][1] != current_c || path[array_length(path) - 1][2] != current_r)
	{
		array_pop(path);
	}
}