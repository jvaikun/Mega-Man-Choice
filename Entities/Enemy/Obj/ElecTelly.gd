extends EnemyCore

onready var anim = $SpriteMain/Sprite/AnimPlayer
onready var timer = $ChargeTimer
onready var viewContain := get_node("/root/Level/ViewContainer") as LevelViewContainer
var timerStart: bool = false
var isSpawned: bool = false

export(int) var imageHeight = 32
export(float) var xRange = 20
export(float) var speed = 140
export(PackedScene) var bullet

func _ready():
	pass

func _process(delta):
	if isSpawned == true:
		self.eat_player_projectile = false
		anim.play("TellySpawn")
	else:
		anim.play("TellySpin")
		if player != null:
			var distanceX = player.global_position.x - self.global_position.x
			var distanceY = player.global_position.y - self.global_position.y
			var angle = atan2(distanceY, distanceX) 
			var degAnged = Vector2(cos(angle), sin(angle))
			self.global_position += (degAnged * speed * delta)
			var clampedDistX = clamp(distanceX, -xRange, xRange)
		
			if (abs(clampedDistX) != xRange) and !timerStart:
				var view := get_node_or_null(viewContain.current_view) as Control
				var rangeInt: int = round(view.rect_size.y / imageHeight)
				#if viewContain != null:
				for h in range(rangeInt):
					var valueToCol = (imageHeight * h) + (imageHeight / 2)
					var lightng = bullet.instance() 
					get_parent().add_child(lightng)
					lightng.global_position.y = view.rect_global_position.y + valueToCol
					lightng.playerObj = self.get_path()
				#else:
				#	var lightng = bullet.instance()
				#	get_parent().add_child(lightng)
				#	lightng.global_position = self.global_position
				timer.start()
				timerStart = true
		else:
			var otherMove = Vector2(speed * delta, 0) 
			self.global_translate(otherMove)

func _on_ChargeTimer_timeout():
	die()

func spawn_Dissapate():
	self.eat_player_projectile = true
	isSpawned = false 
