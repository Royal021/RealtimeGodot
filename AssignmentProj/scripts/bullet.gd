extends Area3D

func _process(delta):
	translate_object_local(Vector3(0,0,-20*delta))
	

func die():
	queue_free()
