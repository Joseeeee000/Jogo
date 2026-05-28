extends CharacterBody2D

@onready var a: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 500.0
const JUMP_VELOCITY = -500.0

var morreu = false


func _ready():

	# Continua funcionando mesmo pausado
	process_mode = Node.PROCESS_MODE_ALWAYS


func _process(delta):

	# Pause / despause com tecla K
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused


func _physics_process(delta: float) -> void:

	# Se o jogo estiver pausado, para tudo do player
	if get_tree().paused:
		return

	# Se morreu, para personagem
	if morreu:
		return

	# Gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Movimento horizontal
	var direction := Input.get_axis("left", "right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Pulo
	if Input.is_action_just_pressed("accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Agachar
	var agachado = Input.is_key_pressed(KEY_S)

	# Virar personagem
	if direction > 0:
		a.flip_h = false
	elif direction < 0:
		a.flip_h = true

	# Animações
	if is_on_floor():

		if agachado:
			a.play("agachado")
			velocity.x = 0

		elif direction != 0:
			a.play("andando")

		else:
			a.play("parado")

	else:
		a.play("pula")

	# Movimento
	move_and_slide()


func game_over():

	# Evita repetir morte
	if morreu:
		return

	morreu = true

	# Para movimento
	velocity = Vector2.ZERO

	# Toca animação morreu
	a.play("morreu")

	# Espera 1 segundo
	await get_tree().create_timer(1.0).timeout

	# Reinicia a fase
	get_tree().reload_current_scene()
