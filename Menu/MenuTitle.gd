extends Control

onready var fade_screen = $FadeScreen
onready var menu_list = $Main/MenuList.get_children()

var menu_index = 0 setget set_index
var is_idle = true


func set_index(val):
	var min_val = 0
	if !is_idle:
		min_val = 1
	menu_index = clamp(val, min_val, menu_list.size() - 1)
	for i in menu_list.size():
		if i == menu_index:
			menu_list[i].modulate = Color(1, 0, 0)
		else:
			menu_list[i].modulate = Color(1, 1, 1)


func _ready():
	for i in menu_list.size():
		menu_list[i].visible = (i == 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("game_up"):
		if !is_idle or !$Load.visible or !$Options.visible:
			self.menu_index -= 1
	if Input.is_action_just_pressed("game_down"):
		if !is_idle or !$Load.visible or !$Options.visible:
			self.menu_index += 1
	if Input.is_action_just_pressed("game_action"):
		match menu_index:
			0:
				is_idle = false
				for i in menu_list.size():
					menu_list[i].visible = (i != 0)
				set_index(1)
			1:
				fade_screen.go_to_scene("res://Menu/StageSelect/StageSelect.tscn")
			2:
				transition("load")
			3:
				transition("option")
			4:
				get_tree().quit()
	if Input.is_action_just_pressed("game_jump"):
		if menu_index in [2,3]:
			transition("main")


func set_transition(value):
	$Transition.material.set_shader_param("progress", value)


func transition(type):
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	var screenshot = ImageTexture.new()
	screenshot.create_from_image(img)
	$Transition.texture = screenshot
	$Transition.show()
	match type:
		"main":
			$Transition.material.set_shader_param("mask", load("res://Menu/Transition/mask_wipe_in.tres"))
			$Load.hide()
			$Options.hide()
			$Main.show()
		"load":
			$Transition.material.set_shader_param("mask", load("res://Menu/Transition/mask_wipe_out.tres"))
			$Main.hide()
			$Load.show()
		"option":
			$Transition.material.set_shader_param("mask", load("res://Menu/Transition/mask_wipe_out.tres"))
			$Main.hide()
			$Options.show()
	var trans_tween = get_tree().create_tween()
	trans_tween.tween_method(self, "set_transition", 0.0, 1.0, 1.0)
	trans_tween.play()
	yield(trans_tween, "finished")
	$Transition.hide()

