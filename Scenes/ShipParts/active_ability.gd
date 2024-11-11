extends Node2D

@export var input_type: Constants.InputType
var input_active: bool = false

func _ready():
	Callable(init).call_deferred()
	#TODO subscribe to input events on player
	#THIS IS AN ACTIVE ABILITY, SO FIRE OFF FROM ACTIVE INPUT


func init():
	match input_type:
		Constants.InputType.ATTACK:
			if get_parent().owner.has_signal("attack_pressed"):
				get_parent().owner.attack_pressed.connect(activate.bind(true))
			if get_parent().owner.has_signal("attack_released"):
				get_parent().owner.attack_repeased.connect(activate.bind(false))
			if get_parent().owner.has_method("get_attacking"):
				input_active = get_parent().owner.get_attacking()
		Constants.InputType.ACTIVE:
			if get_parent().owner.has_signal("active_pressed"):
				get_parent().owner.active_pressed.connect(activate.bind(true))
			if get_parent().owner.has_signal("active_released"):
				get_parent().owner.active_released.connect(activate.bind(false))
			if get_parent().owner.has_method("get_active_input"):
				input_active = get_parent().owner.get_active_input()
	
	#IF NO VIABLE EVENTS TO SUBSCRIBE TO, SET TURN OFF TIMER.ONE_SHOT
	$CooldownTimer.timeout.connect(on_cooldown_timeout)


func attack():
	$AnimationPlayer.play("attack")


func on_cooldown_timeout():
	if $CooldownTimer.one_shot:
		if input_active:
			$CooldownTimer.start()
		else: return
	
	attack()


func activate(setting: bool):
	input_active = setting
	if input_active:
		if $CooldownTimer.is_stopped:
			$CooldownTimer.start()
			attack()
	
