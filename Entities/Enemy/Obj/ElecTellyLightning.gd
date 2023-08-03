extends EnemyCore

onready var anim = $SpriteMain/Sprite/AnimationPlayer
onready var areaCol = $DamageArea
var playerObj

func _ready():
	anim.play("Strike")
	
func _process(delta):
	if get_node(playerObj) != null:
		self.global_position.x = get_node(playerObj).global_position.x
	else:
		self.global_position.x += 0
	
func collision_change():
	areaCol.collision_layer = 16
	areaCol.collision_mask = 6

func begone():
	queue_free()
