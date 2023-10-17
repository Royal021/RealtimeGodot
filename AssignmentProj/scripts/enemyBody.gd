extends CharacterBody3D

@export var EnemyBullet: PackedScene

@onready var highEnemyShipTex = preload("res://assets/EnemyTex/Green.png")
@onready var midEnemyShipTex = preload("res://assets/EnemyTex/Yellow.png")
@onready var lowEnemyShipTex = preload("res://assets/EnemyTex/Red.png")

  
var bulletTime = 2.0
const SPEED = 5.0
var enemyHP = 1.0
var prevHP = enemyHP
var midHP = 0.6
var lowHP = 0.2
func _process(delta):
	
	
	if(self.enemyHP<=0.0):
		$deathSound.play()
		Globals.point_score+=100
		queue_free()
	if(self.enemyHP!=self.prevHP):	
		if(self.enemyHP>midHP && prevHP < midHP):  #hp goes up and texture changes
			self.change_material_hp(self.enemyHP)
		if(self.enemyHP<midHP && prevHP > midHP):  #hp goes down and texture changes to middle texture
			self.change_material_hp(self.enemyHP)
		if(self.enemyHP<lowHP && prevHP> lowHP):  #hp goes down and texture changes to low texture
			self.change_material_hp(self.enemyHP)
	
	
	
	bulletTime-=delta
	
	if(bulletTime<=0):
		var new_bullet = EnemyBullet.instantiate()
		get_node("../Enemy_bullet_container").add_child(new_bullet)
		new_bullet.global_position = $EnemyBulletContainer.global_position
		#new_bullet.global_rotation = $enemyBody.global_rotation 
		bulletTime = 3.0
	
	
	prevHP = enemyHP
	

			
#func _physics_process(delta):
#	# Add the gravity.
#	if not is_on_floor():
#		velocity.y -= gravity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
#	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
#	if direction:
#		velocity.x = direction.x * SPEED
#		velocity.z = direction.z * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#		velocity.z = move_toward(velocity.z, 0, SPEED)
#
#	move_and_slide()



func got_shot(shot):
	enemyHP-=.2
	shot.queue_free()


func change_material_hp(hp):
	if(hp>0.7):
		$enemyBody.get_mesh().get("surface_0/material").set_texture(StandardMaterial3D.TEXTURE_ALBEDO,highEnemyShipTex)
	if(hp<0.7 && hp>0.3):
		$enemyBody.get_mesh().get("surface_0/material").set_texture(StandardMaterial3D.TEXTURE_ALBEDO,midEnemyShipTex)
	if(hp<0.25):
		$enemyBody.get_mesh().get("surface_0/material").set_texture(StandardMaterial3D.TEXTURE_ALBEDO, lowEnemyShipTex )
		
		


func enemy_die():
	queue_free()
