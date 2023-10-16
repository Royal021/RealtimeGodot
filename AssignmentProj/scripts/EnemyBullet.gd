extends Area3D

func _process(delta):
	translate_object_local(Vector3(0,0,-20*delta))

	
func _on_body_entered(hit_enemy):
	if hit_enemy.is_in_group("player"):
		hit_enemy.got_shot(self)

func die():
	queue_free()
