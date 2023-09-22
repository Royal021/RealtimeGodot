extends CharacterBody3D


@export var speed = 5

func _ready():
	pass

func _process(delta):
	do_movement(delta)
	
	
	
func do_movement(dtime):
	var input_vec = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var move_vec = Vector3(input_vec.x, input_vec.y,0).normalized()  * speed #* dtime
	velocity = move_vec
	move_and_slide()
	
