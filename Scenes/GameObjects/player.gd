extends CharacterBody2D

@export var armament_point_scene: PackedScene

@export var acceleration: float = 5.0
@export var maneuver_speed: float = 5.0
@export var maneuver_direction : int = 1
@export var vertical_speed: float = 2.5

@export var max_speed: float = 40.0
@export var speed_mult: float = 1.0


var armaments: Array[Node2D] = []


func _ready():
	Callable(init).call_deferred()


func init():
	armaments.clear()
	add_armament(armament_point_scene)
	add_armament(armament_point_scene)
	add_armament(armament_point_scene)


func _physics_process(delta):
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	input_dir.x = input_dir.x * maneuver_speed * maneuver_direction
	input_dir.y = input_dir.y * vertical_speed
	var mult = 1.0
	accelerate_in_direction(input_dir, mult, delta)
	
	move_and_slide()


func accelerate_in_direction(direction: Vector2, mult: float, delta):
	var desired_velocity = direction * max_speed * speed_mult * mult
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * delta))


func add_armament(armament):
	var instance: Node2D = null
	if armament is PackedScene:
		instance = armament.instantiate() as Node2D
	else: instance = armament
	
	$Graphics.add_child(instance)
	armaments.append(instance)
	
	Callable(readjust_armaments).call_deferred()


func readjust_armaments():
	#READJUST ARMAMENT POSITIONS
	for i in armaments.size():
		if armaments[i] == null:
			return
		armaments[i].global_position = global_position + (Vector2.UP * 32).rotated(TAU / armaments.size()) * 32
