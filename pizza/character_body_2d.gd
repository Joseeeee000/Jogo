extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var player = get_tree().get_first_node_in_group("player")

const SPEED = 50
const GRAVITY = 900

var morto = false


func _physics_process(delta):

	if morto:
		return

	# Gravidade
	velocity.y += GRAVITY * delta

	# Seguir player
	if player != null:

		if player.global_position.x > global_position.x:
			velocity.x = SPEED
			anim.flip_h = false

		else:
			velocity.x = -SPEED
			anim.flip_h = true

	# Movimento
	move_and_slide()

	# Animação
	anim.play("anda")


func _on_colisaofim_body_entered(body):

	if body.is_in_group("player"):

		# Player está caindo na cabeça
		if body.velocity.y > 0:

			morto = true

			# Faz o player quicar
			body.velocity.y = -250

			queue_free()


func _on_morte_player_body_entered(body):

	if body.is_in_group("player"):

		# Se estiver caindo, não mata
		if body.velocity.y > 0:
			return

		body.game_over()




func _on_fim_body_entered(body):

	if body.is_in_group("player"):

		# Player está caindo na cabeça
		if body.velocity.y > 0:

			morto = true

			# Faz o player quicar
			body.velocity.y = -250

			queue_free()
