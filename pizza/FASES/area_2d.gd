extends Area2D


@export var prox_fase = ""


func _on_body_entered(_body: Node2D) -> void:

	call_deferred("load_next_scene")

	

func load_next_scene():

	get_tree().change_scene_to_file("res://FASES/" + "fase_1" + ".tscn")
