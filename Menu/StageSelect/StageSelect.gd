extends Control

onready var fade_screen = $FadeScreen

var menu_data = [
	[
		{"stage":"res://Levels/Levels/Grassland_1_2OP.tscn", "pos":Vector2(24, 17)},
		{"stage":"res://Levels/Levels/Grassland_1_2OP.tscn", "pos":Vector2(24, 81)},
		{"stage":"res://Levels/Levels/Grassland_1_2OP.tscn", "pos":Vector2(24, 145)},
	],
	[
		{"stage":"res://Levels/Levels/Grassland_1_2OP.tscn", "pos":Vector2(104, 17)},
		{"stage":"", "pos":Vector2(104, 81)},
		{"stage":"res://Levels/Levels/Grassland_1_2OP.tscn", "pos":Vector2(104, 145)},
	],
	[
		{"stage":"res://Levels/Levels/Grassland_1_2OP.tscn", "pos":Vector2(184, 17)},
		{"stage":"res://Levels/Levels/Grassland_1_2OP.tscn", "pos":Vector2(184, 81)},
		{"stage":"res://Levels/Levels/Grassland_1_2OP.tscn", "pos":Vector2(184, 145)},
	],
]
var menu_pos = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	move_cursor()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("game_up"):
		menu_pos.y -= 1
		move_cursor()
	if Input.is_action_just_pressed("game_down"):
		menu_pos.y += 1
		move_cursor()
	if Input.is_action_just_pressed("game_left"):
		menu_pos.x -= 1
		move_cursor()
	if Input.is_action_just_pressed("game_right"):
		menu_pos.x += 1
		move_cursor()
	if Input.is_action_just_pressed("game_action"):
		if menu_data[menu_pos.x][menu_pos.y].stage != "":
			fade_screen.go_to_scene(menu_data[menu_pos.x][menu_pos.y].stage)


func move_cursor():
	menu_pos.x = clamp(menu_pos.x, 0, 2)
	menu_pos.y = clamp(menu_pos.y, 0, 2)
	$MegaManHead.frame_coords = menu_pos
	$Cursor.rect_position = menu_data[menu_pos.x][menu_pos.y].pos
