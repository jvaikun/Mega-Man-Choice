extends Control

onready var fade_screen = $FadeScreen
onready var start_prompt = $StartPrompt

onready var menu_data = {
	"main":$Main.get_children(),
	"load":$Load/LoadFile/SaveList.get_children(),
	"options":$Options.get_children(),
}
# Options Menu
# Controller Config - Keyboard, Gamepad
# Audio - Master, Music, SFX, Music version [NES/Arranged]
# Display - Scale [1x, 2x, 3x, 4x, Fullscreen], Widescreen/Native, V-Sync [ON/OFF], Border [Disable if Native]
# Gameplay - Charge bar [on/off], Damage nums [on/off], Weapon wheel [on/off], Pause on Pickup [on/off]
# Option description in bar below menu



var menu_name = "main"
var menu_index = 0 setget set_index


func set_index(val):
	menu_index = clamp(val, 0, menu_data[menu_name].size() - 1)
	for i in menu_data[menu_name].size():
		if i == menu_index:
			menu_data[menu_name][i].self_modulate = Color(1, 0, 0)
		else:
			menu_data[menu_name][i].self_modulate = Color(1, 1, 1)


func _ready():
	if OS.get_name() == "HTML5":
		$Load/LoadFile.hide()
		$Load/Password.show()
		$Main/Quit.hide()
		menu_data.main.pop_back()
	else:
		$Load/LoadFile.show()
		$Load/Password.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_prompt.visible:
		if Input.is_action_just_pressed("game_action"):
			start_prompt.hide()
			$Main.show()
			set_index(0)
	else:
		if Input.is_action_just_pressed("game_up"):
			self.menu_index -= 1
		if Input.is_action_just_pressed("game_down"):
			self.menu_index += 1
		if Input.is_action_just_pressed("game_action"):
			match menu_index:
				0:
					fade_screen.go_to_scene("res://Menu/MenuChoice.tscn")
				1:
					transition("load")
				2:
					transition("options")
				3:
					get_tree().quit()
		if Input.is_action_just_pressed("game_jump"):
			if menu_name != "main":
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
	menu_name = type
	set_index(0)
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
		"options":
			$Transition.material.set_shader_param("mask", load("res://Menu/Transition/mask_wipe_out.tres"))
			$Main.hide()
			$Options.show()
	var trans_tween = get_tree().create_tween()
	trans_tween.tween_method(self, "set_transition", 0.0, 1.0, 0.5)
	trans_tween.play()
	yield(trans_tween, "finished")
	$Transition.hide()

