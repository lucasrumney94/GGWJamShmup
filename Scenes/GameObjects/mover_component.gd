extends Node

var character_body: CharacterBody2D

@export var movementSpeed: float = 1.0
@export var initialMovementDirection: Vector2 = Vector2.DOWN
@export var amplitude: float = 128

func _ready():
	character_body = get_parent()
	print(character_body.name)

func _physics_process(delta):
	character_body.velocity = (initialMovementDirection * movementSpeed) + amplitude * Vector2.RIGHT * sin(GameEvents.game_time)
	character_body.move_and_slide()
	#character_body.move_and_collide(character_body.velocity * delta)
