extends Area3D

func _process(delta):
	translate_object_local(Vector3(0,0,-20*delta))
	var shipLocation = get_node("/root/world_root/playerShip")
	if(shipLocation == null):
		shipLocation = get_node("/root/world_root2/playerShip")
	if(400 < $bulletMesh.global_position.z - shipLocation.global_position.z):
		die()
	
func _on_body_entered(hit_enemy):
	if hit_enemy.is_in_group("enemy"):
		hit_enemy.got_shot(self)
	if hit_enemy.is_in_group("obstacle"):
		hit_enemy.got_shot(self)

func die():
	queue_free()
