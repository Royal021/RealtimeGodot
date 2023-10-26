extends CharacterBody3D

@export var EnemyBullet: PackedScene

@onready var highEnemyShipTex = preload("res://assets/EnemyTex/Green.png")
@onready var midEnemyShipTex = preload("res://assets/EnemyTex/Yellow.png")
@onready var lowEnemyShipTex = preload("res://assets/EnemyTex/Red.png")

  
var bulletTime = 2.0
const SPEED = 5.0
var enemyHP = 1.0
var prevHP = enemyHP
var midHP = 0.8
var lowHP = 0.4
func _process(delta):
	
	
	if(self.enemyHP<=0.0):
		$deathSound.play()
		Globals.point_score+=100
		queue_free()
	if(self.enemyHP!=self.prevHP):	
		pass
		
		
	if(self.enemyHP<midHP):
		$DamagePart1.show()
	if(self.enemyHP<lowHP):
		$DamagePart2.show()
	
	
	bulletTime-=delta
	
	if(bulletTime<=0):
		var new_bullet = EnemyBullet.instantiate()
		get_node("../Enemy_bullet_container").add_child(new_bullet)
		new_bullet.global_position = $EnemyBulletContainer.global_position
		#new_bullet.global_rotation = $enemyBody.global_rotation 
		bulletTime = 3.0
	
	
	prevHP = enemyHP
	


func _on_enemy_body_entered(hit_object):
	if hit_object.is_in_group("player"):
		
		hit_object.got_rammed(self)
	

func got_shot(shot):
	enemyHP-=.25
	shot.queue_free()



func enemy_die():
	queue_free()
