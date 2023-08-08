extends Node

signal leveled_up

var choice_history = {
	"chapter1":"",
	"chapter2":"",
	"chapter3":"",
	"chapter4":"",
}
var progress = ["chapter1", 0]

var current_hp
var restore_hp_on_load = true
var is_died = false

func _ready() -> void:
	pass
