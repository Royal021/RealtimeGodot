extends CharacterBody3D

signal change_score(new_score)
@export var speed = 10
@export var bullet: PackedScene


var time_survived = 0.0  #constantly add delt time to this
						#when we apss a new whole number notify the UI that we ashould add a point
var time_score = 0

var health_percent = 1.0  # 1.0 = 100%hp, 0 = 0%hp
@onready var mainHud = get_node("/root/world_root/mainHud")


func _ready():
	connect("change_score", mainHud.do_change_score)
	if !$mainMusic.playing:
		$mainMusic.play()
		###$mainMusic.stop()
		
	

func _process(delta):
	do_movement(delta)
	
	mainHud.do_change_health(health_percent)
	
	time_survived+=delta
	if int(time_survived) > time_score:
		time_score = int(time_survived)
		#this code :calls" the signal notifying the scrit that is listening to it
		emit_signal("change_score", time_score)
		print("points!")
	
	if Input.is_action_just_pressed("fire"):
		var new_bullet = bullet.instantiate()
		get_node("../bullet_container").add_child(new_bullet)
		new_bullet.global_position = $shipBulletContainer.global_position
		new_bullet.global_rotation = global_rotation
		
	
	
	
func do_movement(dtime):
	var input_vec = Input.get_vector( "move_right", "move_left",  "move_down", "move_up")
	var move_vec = Vector3(input_vec.x, input_vec.y,1).normalized()  * speed #* dtime
	if($CockpitCollision.global_position.x <=-100 ||$CockpitCollision.global_position.x >=100):
		print($CockpitCollision.global_position.x)
		move_vec.x = -2*move_vec.x
	if($CockpitCollision.global_position.y <=5 ||$CockpitCollision.global_position.x >=100):
		move_vec.y =-2*move_vec.y
		print($CockpitCollision.global_position.y)
	velocity = move_vec
	move_and_slide()
	
	

#func got_pickup(the_pickup):
#	print("You got a pickup")
#	$AnimationPlayer.play("wingUp")
#	the_pickup.queue_free()
