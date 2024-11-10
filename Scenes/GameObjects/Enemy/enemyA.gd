extends CharacterBody2D

@export var projectile: PackedScene
@export var fireTimerSpread: float = .03
@export var bulletFireSpeed: float = 30.

@export var movementSpeed: float = 1.0
@export var initialMovementDirection: Vector2 = Vector2.DOWN

var rng = RandomNumberGenerator.new();

func _ready():
	$ShootTimer.timeout.connect(on_shoot_timeout)
	
func _process(delta: float) -> void:
	Move(delta)
	

func Shoot():
	# Instantiate projectile
	var proj = projectile.instantiate()
	
	# Child to scene root
	get_tree().current_scene.add_child(proj)

	# Set location to location of ship
	proj.global_position = global_position
	
	# Set projectile velocity
	#             inherit velo, speed, unit direction
	proj.velocity = velocity + bulletFireSpeed * Vector2.DOWN
	print("enemyvelo", velocity, "projVELO:", proj.velocity)
	
	# Add a tiny variance in each enemies fire timer (+/- a set percent)
	var current_wait_time = $ShootTimer.wait_time;
	$ShootTimer.wait_time = rng.randf_range(current_wait_time*(1.-fireTimerSpread), current_wait_time*(1.+fireTimerSpread))
	print("new shot wait time for enemyA set to:", $ShootTimer.wait_time)

func Move(delta: float):
	velocity = (initialMovementDirection * movementSpeed)
	move_and_collide(velocity)


func on_shoot_timeout():
	Shoot()
