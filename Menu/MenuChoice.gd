extends Control

const CHOICES = {
	"chapter1": [
		{
			"image":"res://Menu/StageSelect/mug_current.png", 
			"caption":"CHAPTER 1\nCHOICE 1", 
			"stage":"res://Levels/Levels/Grassland_1_2OP.tscn"
		},
		{
			"image":"res://Menu/StageSelect/mug_paper.png",
			"caption":"CHAPTER 1\nCHOICE 2",
			"stage":"res://Levels/Levels/Grassland_1_2OP.tscn"
		},
	],
	"chapter2": [
		{
			"image":"res://Menu/StageSelect/mug_current.png", 
			"caption":"CHAPTER 2\nCHOICE 1", 
			"stage":"res://Levels/Levels/Grassland_1_2OP.tscn"
		},
		{
			"image":"res://Menu/StageSelect/mug_paper.png",
			"caption":"CHAPTER 2\nCHOICE 2",
			"stage":"res://Levels/Levels/Grassland_1_2OP.tscn"
		},
	],
	"chapter3": [
		{
			"image":"res://Menu/StageSelect/mug_current.png", 
			"caption":"CHAPTER 3\nCHOICE 1", 
			"stage":"res://Levels/Levels/Grassland_1_2OP.tscn"
		},
		{
			"image":"res://Menu/StageSelect/mug_paper.png",
			"caption":"CHAPTER 3\nCHOICE 2",
			"stage":"res://Levels/Levels/Grassland_1_2OP.tscn"
		},
	],
	"chapter4": [
		{
			"image":"res://Menu/StageSelect/mug_current.png", 
			"caption":"CHAPTER 4\nCHOICE 1", 
			"stage":"res://Levels/Levels/Grassland_1_2OP.tscn"
		},
		{
			"image":"res://Menu/StageSelect/mug_paper.png",
			"caption":"CHAPTER 4\nCHOICE 2",
			"stage":"res://Levels/Levels/Grassland_1_2OP.tscn"
		},
	],
}

onready var fade_screen = $FadeScreen

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


# Called when the node enters the scene tree for the first time.
func _ready():
	print($Choices.get_child_count())
	set_choice(0)
	load_choices("chapter1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("game_left"):
		self.choice_index -= 1
	if Input.is_action_just_pressed("game_right"):
		self.choice_index += 1


func load_choices(index):
	$Choices/Choice1/Frame/Image.texture = load(CHOICES[index][0].image)
	$Choices/Choice1/Caption.text = CHOICES[index][0].caption
	$Choices/Choice2/Frame/Image.texture = load(CHOICES[index][1].image)
	$Choices/Choice2/Caption.text = CHOICES[index][1].caption

