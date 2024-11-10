extends CharacterBody2D

@export var movementSpeed: float = 1.0
@export var initialMovementDirection: Vector2 = Vector2.DOWN

var rng = RandomNumberGenerator.new();
	
func _physics_process(delta: float) -> void:
	Move(delta)
	
func _process(delta: float) -> void:
	#Move(delta)
	pass

func Move(delta: float):
	velocity = (initialMovementDirection * movementSpeed) + 4.*Vector2.RIGHT*sin(Time.get_ticks_msec()/100)
	move_and_collide(velocity)
