extends Area3D

func _process(delta):
	translate_object_local(Vector3(0,0,-20*delta))
	var shipLocation = get_node("/root/world_root/playerShip")
	if(100 < $bulletMesh.global_position.z - shipLocation.global_position.z):
		die()
	

func die():
	queue_free()
