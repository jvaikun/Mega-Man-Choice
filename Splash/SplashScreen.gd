extends Control

onready var fade_screen = $FadeScreen


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "AutoPlay":
		fade_screen.go_to_scene("res://Menu/MenuTitle.tscn")

