extends Control

onready var fade_screen = $FadeScreen

var chapter = "chap1"
var set = "set1"
var current = "city"
var choice_data = {
	"chap1":{
		"set1":{
			"city":{"caption":"CITY", "clear":false},
			"road":{"caption":"ROAD", "clear":false},
			"forest":{"caption":"FOREST", "clear":false},
		},
		"set2":{
			"office":{"caption":"OFFICES", "clear":false},
			"power":{"caption":"POWER PLANT", "clear":false},
			"weather":{"caption":"WEATHER CENTER", "clear":false},
		},
		"set3":{
			"punch":{"caption":"PUNCH GANG", "clear":false},
			"element":{"caption":"ELEMENTAL", "clear":false},
		},
	},
	"chap2":{
		"set1":{
			"boss1":{"caption":"BOSS 1", "clear":false},
			"boss2":{"caption":"BOSS 2", "clear":false},
			"boss3":{"caption":"BOSS 3", "clear":false},
		},
	},
	"chap3":{
	},
}
var choice_index = 0 setget set_choice


func set_choice(val):
	if val < 0:
		choice_index = $Choices.get_child_count() - 1
	elif val >= $Choices.get_child_count():
		choice_index = 0
	else:
		choice_index = val
	$Choices/Choice1/Frame/Select.visible = (choice_index == 0)
	$Choices/Choice2/Frame/Select.visible = (choice_index == 1)


func _ready():
	print($Choices.get_child_count())
	set_choice(0)
	load_choices("chap1")


func _process(delta):
	if Input.is_action_just_pressed("game_left"):
		self.choice_index -= 1
	if Input.is_action_just_pressed("game_right"):
		self.choice_index += 1


func load_choices(index):
	$Choices/Choice1/Frame/Image.texture = load(choice_data[index][0].image)
	$Choices/Choice1/Caption.text = choice_data[index][0].caption
	$Choices/Choice2/Frame/Image.texture = load(choice_data[index][1].image)
	$Choices/Choice2/Caption.text = choice_data[index][1].caption

