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
	velocity = (initialMovementDirection * movementSpeed)
	move_and_collide(velocity)
