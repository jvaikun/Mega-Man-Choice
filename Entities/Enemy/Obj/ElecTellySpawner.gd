extends EnemyCore

onready var iterb := get_node_or_null("/root/Level/Iterable") as Node
onready var timer = $SpawnEnemy
var tellyObj := preload("res://Entities/Enemy/Obj/ElecTelly.tscn")
var curTelObj
var telPath: NodePath
var canTimer: bool = true

func _process(delta):
	if (telPath.is_empty() or !has_node(telPath)) and (canTimer == true) and (tellyObj != null):
		timer.start()
		canTimer = false
		
func _on_SpawnEnemy_timeout():
	curTelObj = tellyObj.instance()
	if(iterb != null):
		iterb.add_child(curTelObj) 
	else:
		self.add_child(curTelObj)
	curTelObj.global_position = self.global_position
	curTelObj.isSpawned = true
	telPath = curTelObj.get_path()
	canTimer = true
