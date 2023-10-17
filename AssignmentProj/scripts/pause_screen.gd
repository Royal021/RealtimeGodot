extends Control

func _process(delta):
	if(get_tree().paused == true):
		self.show()
			
func _on_quit_button_pressed():
	get_tree().quit()


func _on_resume_button_pressed():
	self.hide()
	get_tree().paused = false


func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/world_root.tscn")
