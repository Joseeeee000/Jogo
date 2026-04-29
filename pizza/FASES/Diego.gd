extends CharacterBody2D

@onready var a: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 500.0
const JUMP_VELOCITY = -500.0

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")

	# Movimento
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	
	if is_on_floor():
		if direction > 0:
			a.flip_h = false
			a.play("anda")
		elif direction < 0:
			a.flip_h = true
			a.play("anda")
		else:
			a.play("parado")
	else:
		a.play("pula")

	move_and_slide()
