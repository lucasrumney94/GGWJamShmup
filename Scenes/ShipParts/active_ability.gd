extends Node2D


func _ready():
	#TODO subscribe to input events on player
	#THIS IS AN ACTIVE ABILITY, SO FIRE OFF FROM ACTIVE INPUT
	
	#IF NO VIABLE EVENTS TO SUBSCRIBE TO, SET TURN OFF TIMER.ONE_SHOT
	$CooldownTimer.timeout.connect(on_cooldown_timeout)


func attack():
	$AnimationPlayer.play("attack")


func on_cooldown_timeout():
	if $CooldownTimer.one_shot:
		return
	
	attack()
