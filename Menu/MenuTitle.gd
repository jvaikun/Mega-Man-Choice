extends Control

onready var fade_screen = $FadeScreen

var menu_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("game_action"):
		match menu_index:
			0:
				fade_screen.go_to_scene("res://Menu/StageSelect/StageSelect.tscn")

