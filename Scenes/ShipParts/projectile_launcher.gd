extends Node2D

@export var projectile: PackedScene
@export var bullet_speed: float = 100

var physics_body: PhysicsBody2D

func _ready():
	Callable(init).call_deferred()


func init():
	physics_body = get_physics_parent(owner.get_parent())


func get_physics_parent(child: Node):
	if child is PhysicsBody2D:
		return child
	var par = child.get_parent()
	if par == null:
		printerr(child.name + " HAS NO PARENT")
		return null
	print(par.name)
	if par is PhysicsBody2D:
		return par
	else: 
		return get_physics_parent(par)


func Shoot():
	#instantiate projectile
	#set projectile velocity
	var p = projectile.instantiate()
	
	var parent = get_tree().get_first_node_in_group("projectile_layer")
	if parent == null:
		parent = get_parent()
		
	p.global_position = global_position
	#var velocity = bullet_speed * self.to_global(transform.y).normalized()
	var velocity = bullet_speed * Vector2.UP.rotated(global_rotation)
	
	#physics_body = get_physics_parent(get_parent())
	if physics_body != null:
		if velocity.normalized().dot(physics_body.velocity.normalized()) > 0.0:
			velocity += physics_body.velocity
		if physics_body.collision_layer & 2 == 2: #IS PLAYER
			p.use_friendly_collision()
		#print(str(velocity))
		
	parent.add_child(p)
	
	p.velocity = velocity


func _on_gun_do_attack() -> void:
	Shoot()
