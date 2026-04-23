extends Control


# Called when the node enters the scene tree for the first time.
func _on_button_pressed():
	get_tree().change_scene_to_file("res://FASES/fase.tscn")
	
func _on_button2_pressed():
	get_tree().quit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
