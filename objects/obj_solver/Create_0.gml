jstring = "";
data = undefined;
global.tile_size = 128;
global.origin = room_width / 2 - global.tile_size;
size = 0;
map = [];
normal_tile = "TileType.NORMAL";
wall_tile = "TileType.WALL";
start_tile = "TileType.START"
end_tile = "TileType.END"
start_pos = [];
end_pos = [];
explored = [];
row_num = 0;
column_num = 0;
path = [];
solved = false;
nodes = [];
go = false;

var _parameter_file = file_text_open_read("number.txt")
number = string(file_text_readln(_parameter_file));
show_debug_message("The current labyrinth is labyrinth number: " + number + ".");
file_text_close(_parameter_file);
file = file_text_open_read("labyrinth_" + number + ".json");

while(file_text_eof(file) == false)
{
	jstring += file_text_readln(file);
}

file_text_close(file);

data = json_decode(jstring);

size = ds_list_size(data[? "tiles"]);

for(var _i = 0; _i < size; _i++) 
{
	var _row = data[? "tiles"][| _i][| 0][? "r"];
	var _column = data[? "tiles"][| _i][| 0][? "c"];
	
	if(_row > row_num)
	{
		row_num = _row;
	}
	
	if(_column > column_num)
	{
		column_num = _column;
	}
}

for(var _i = 0; _i < size; _i++) 
{
	var _a = data[? "tiles"][| _i][| 0][? "a"];
	var _c = data[? "tiles"][| _i][| 0][? "c"];
	var _r = data[? "tiles"][| _i][| 0][? "r"];
	var _type = data[? "tiles"][| _i][| 1][? "type"];
	
	map[_a][column_num + _c][row_num + _r] = _type;
	explored[_a][column_num + _c][row_num + _r] = false;
	
	var _tile = instance_create_layer(global.origin + global.tile_size * (_a / 2 + _c), global.origin - global.tile_size * (sqrt(3) + (_a / 2 + _r)), "instances", obj_hexagon);
	
	if(_type == normal_tile)
	{
		with(_tile)
		{
			image_index = 0;
		}
	}
	
	else if(_type == wall_tile)
	{
		with(_tile)
		{
			image_index = 1;
		}
	}
	
	else if(_type == start_tile)
	{
		start_pos = [_a, _c, _r];
		array_push(path, start_pos);
		explored[_a][column_num + _c][row_num + _r] = true;
		current_a = _a;
		current_c = _c;
		current_r = _r;
		
		with(_tile)
		{
			image_index = 2;
			depth = -10000;
		}
	}
	
	else if(_type == end_tile)
	{
		end_pos = [_a, _c, _r];
		
		with(_tile)
		{
			image_index = 3;
			depth = -10000;
		}
	}
	
}