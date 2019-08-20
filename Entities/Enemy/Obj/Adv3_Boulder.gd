extends EnemyCore

const DIRECTION_LEFT = -1
const DIRECTION_RIGHT = 1

export var bounce_set_vel_y = -90

onready var pf_bhv = $PlatformBehavior

var current_dir = 0

func _ready():
	if player != null:
		if player.global_position.x > global_position.x:
			pf_bhv.simulate_walk_right = true
			pf_bhv.simulate_walk_left = false
			current_dir = DIRECTION_RIGHT
		else:
			pf_bhv.simulate_walk_right = false
			pf_bhv.simulate_walk_left = true
			current_dir = DIRECTION_LEFT

func change_direction():
	match current_dir:
		DIRECTION_RIGHT:
			pf_bhv.simulate_walk_right = false
			pf_bhv.simulate_walk_left = true
			current_dir = DIRECTION_LEFT
		DIRECTION_LEFT:
			pf_bhv.simulate_walk_right = true
			pf_bhv.simulate_walk_left = false
			current_dir = DIRECTION_RIGHT

func _on_PlatformBehavior_landed():
	pf_bhv.velocity.y = bounce_set_vel_y


func _on_PlatformBehavior_by_wall():
	change_direction()
