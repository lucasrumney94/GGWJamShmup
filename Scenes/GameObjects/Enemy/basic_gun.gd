extends CharacterBody2D

@export var projectile: PackedScene
@export var fireTimerSpread: float = .03
@export var bulletFireSpeed: float = 30.

func _ready():
	$ShootTimer.timeout.connect(on_shoot_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_shoot_timeout():
	Shoot()

func Shoot():
	# Instantiate projectile
	var proj = projectile.instantiate()

	# Set initial location to location of enemy ship
	proj.global_position = global_position

	# Child to scene root
	find_parent("Node2D").add_child(proj)

	# Set projectile velocity
	#             inherit velo, speed, unit direction
	proj.velocity = get_parent().velocity + (bulletFireSpeed * Vector2.DOWN)
	print("(parent) enemy VELO:", get_parent().velocity, " proj VELO:", proj.velocity)

	# Add a tiny variance in each enemies fire timer (+/- a set percent)
	# var current_wait_time = $ShootTimer.wait_time;
	# $ShootTimer.wait_time = rng.randf_range(current_wait_time*(1.-fireTimerSpread), current_wait_time*(1.+fireTimerSpread))
	# print("new shot wait time for enemyA set to:", $ShootTimer.wait_time)
