extends CharacterBody2D


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var motion = collision.get_remainder().bounce(collision.get_normal())
		velocity = velocity.bounce(collision.get_normal())
		move_and_collide(motion)
	#pass
