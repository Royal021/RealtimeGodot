extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(hit_object):
	if hit_object.is_in_group("player"):
		hit_object.got_rammed(self)



func _die():
	queue_free()
	
