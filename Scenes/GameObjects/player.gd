extends CharacterBody2D

signal attack_pressed
signal attack_released
signal active_pressed
signal active_released

@onready var graphics: Node2D = $Graphics
@onready var input_component: InputComponent = $InputComponent

@export var armament_point_scene: PackedScene

@export var acceleration: float = 5.0
@export var maneuver_speed: float = 5.0
@export var maneuver_direction : int = 1
@export var vertical_speed: float = 2.5

@export var max_speed: float = 40.0
@export var speed_mult: float = 1.0


var armaments: Array[Node2D] = []

var alive: bool = true
var is_attacking: bool = false
var active_input_active: bool = false


func _ready():
	Callable(init).call_deferred()
	%HitBox.hit.connect(on_hit)


func init():
	armaments.clear()
	#TODO get armaments from current build and add them
	#add_armament(armament_point_scene)
	#add_armament(armament_point_scene)
	#add_armament(armament_point_scene)


func _physics_process(delta):
	if !alive:
		return
	
	#var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var input_dir = input_component.get_move_vector()
	var input_attack = input_component.get_attacking()
	if is_attacking != input_attack:
		is_attacking = input_attack
		if is_attacking:
			attack_pressed.emit()
		else: attack_released.emit()
	var input_active = input_component.get_active()
	if active_input_active != input_active:
		active_input_active = input_active
		if active_input_active:
			active_pressed.emit()
		else: active_released.emit()
	
	#ANIMATE SHIP
	graphics.scale.x = lerpf(1, 0.66, abs(input_dir.x))
	graphics.skew = lerpf(0, deg_to_rad(12.5), abs(input_dir.x)) * sign(input_dir.x)
	
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
		armaments[i].global_position = global_position + (Vector2.UP).rotated((TAU / float(armaments.size()) * i)) * 32


func die():
	alive = false
	#TODO lose control
	#EXPLODE
	#SCENE SCROLLING STOPS
	print("THE PLAYER SHOULD NOW DIE")
	GameEvents.emit_game_over()


func get_attacking() -> bool:
	return is_attacking


func get_active_input() -> bool:
	return active_input_active


func on_hit(strength: float):
	die()
