extends VBoxContainer

onready var main_menu = $MenuOptions/Content/Main.get_children()
onready var sub_menus = [
	{"head":"DISPLAY","list":$MenuOptions/Content/Display,
	"size":$MenuOptions/Content/Display.get_child_count()},
	{"head":"SOUND","list":$MenuOptions/Content/Sound,
	"size":$MenuOptions/Content/Sound.get_child_count()},
	{"head":"CONTROLS","list":$MenuOptions/Content/Controls,
	"size":$MenuOptions/Content/Controls.get_child_count()},
	{"head":"GAMEPLAY","list":$MenuOptions/Content/Gameplay,
	"size":$MenuOptions/Content/Gameplay.get_child_count()},
]

var sub_index = 0 setget set_sub
var menu_index = 0 setget set_index


func set_sub(val):
	if val == -1:
		sub_index = val
		$MenuOptions/Content/Main.show()
		$MenuOptions/Content/Header.text = "OPTIONS"
		for sub in sub_menus:
			sub.list.hide()
	else:
		$MenuOptions/Content/Main.hide()
		sub_index = clamp(val, 0, sub_menus.size()-1)
		$MenuOptions/Content/Header.text = sub_menus[sub_index].head
		for i in sub_menus.size():
			sub_menus[i].list.visible = (i == sub_index)


func set_index(val):
	if sub_index == -1:
		menu_index = clamp(val, 0, main_menu.size()-1)
		for i in main_menu.size():
			if i == menu_index:
				main_menu[i].modulate = Color(1,0,0)
			else:
				main_menu[i].modulate = Color(1,1,1)
	else:
		menu_index = clamp(val, 0, sub_menus[sub_index].size-1)
		for i in sub_menus[sub_index].size:
			if i == menu_index:
				sub_menus[sub_index].list.get_child(i).modulate = Color(1,0,0)
			else:
				sub_menus[sub_index].list.get_child(i).modulate = Color(1,1,1)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_sub(-1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		if Input.is_action_just_pressed("game_up"):
			self.menu_index -= 1
		if Input.is_action_just_pressed("game_down"):
			self.menu_index += 1
		if Input.is_action_just_pressed("game_action"):
			set_sub(menu_index)
			set_index(0)
		if Input.is_action_just_pressed("game_jump"):
			set_sub(-1)
			set_index(0)

