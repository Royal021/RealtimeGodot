extends CharacterBody3D

signal change_score(new_score)

@export var speed = 10
@export var bullet: PackedScene
@export var pause_screen: PackedScene


var time_survived = 0.0  #constantly add delt time to this
						#when we apss a new whole number notify the UI that we ashould add a point
var time_score = 0


var health_percent = 1.0  # 1.0 = 100%hp, 0 = 0%hp
var previous_hp = health_percent
var iFrameTime = 0.0
var midHP = 0.5
var lowHP = 0.3

@onready var mainHud = get_node("../mainHud")
@onready var highHealthyShipTex = preload("res://assets/ExportedAssets/Tiles129B.png")
@onready var midHealthyShipTex = preload("res://assets/ExportedAssets/Plastic012A.png")
@onready var lowHealthyShipTex = preload("res://assets/ExportedAssets/Foil001.png")
  

func _ready():
	
	if !$SoundsContainer/InGameStream.playing:
		$SoundsContainer/InGameStream.play()
		###$mainMusic.stop()
		
	

func _process(delta):
	do_movement(delta)
	
	
	
	if(iFrameTime<=0.0):
		pass
		#health_percent = health_percent -1*delta
	if(iFrameTime>0):
		iFrameTime-=delta
	#print(iFrameTime)
	if(health_percent!=previous_hp):	
		if(health_percent>midHP && previous_hp < midHP):  #hp goes up and texture changes
			change_material_hp(health_percent)
		if(health_percent<midHP && previous_hp > midHP):  #hp goes down and texture changes to middle texture
			change_material_hp(health_percent)
		if(health_percent<lowHP && previous_hp > lowHP):  #hp goes down and texture changes to low texture
			change_material_hp(health_percent)

	time_survived+=delta	
	

	
	if Input.is_action_just_pressed("fire"):
		var new_bullet = bullet.instantiate()
		get_node("../bullet_container").add_child(new_bullet)
		new_bullet.global_position = $shipBulletContainer.global_position
		new_bullet.global_rotation = global_rotation
		$SoundsContainer/ShotSound.play()
		
		
	if (health_percent<=0):
		$SoundsContainer/DeathSound.play()
		get_tree().change_scene_to_file("res://scenes/lose_screen.tscn")
		
	previous_hp = health_percent
	
	
	if int(time_survived) > time_score:
		time_score = int(time_survived)
		Globals.total_score = time_score+Globals.point_score
		emit_signal("change_score", Globals.total_score)
	
	
func do_movement(dtime):
	var input_vec = Input.get_vector( "move_right", "move_left",  "move_down", "move_up")
	var sprint = Input.is_action_pressed("sprint")
	
	if(Input.is_action_pressed("pause")):
		get_tree().paused = true
		
		
	
	
	var move_vec = Vector3(input_vec.x, input_vec.y,1).normalized()  * speed
	if(sprint):
		move_vec *=2
	else:
		move_vec *= Vector3(2,2,0.5)
	if($CockpitCollision.global_position.x <=-100 ||$CockpitCollision.global_position.x >=100):
		print($CockpitCollision.global_position.x)
		move_vec.x = -5*move_vec.x
	if($CockpitCollision.global_position.y <=5 ||$CockpitCollision.global_position.y >=200):
		move_vec.y =-5*move_vec.y
		#print($CockpitCollision.global_position.y)
	velocity = move_vec
	Globals.healthPoints = health_percent
	
	move_and_slide()
	
func change_material_hp(hp):
	if(hp>=0.5):
		$DamageParticle1.hide()
		$DamageParticle2.hide()
	if(hp<0.5):
		$DamageParticle1.show()
	if(hp<0.3):
		$DamageParticle2.show()
		
func got_pickup(pickup):
	Globals.point_score+=50
	$AnimationPlayer.play("wingUp")
	$SoundsContainer/PointSound.play()
	pickup.queue_free()

func got_shot(shot):
	health_percent-=.1
	shot.queue_free()
	
func got_rammed(obj):
	health_percent-=.1
	obj.queue_free()
