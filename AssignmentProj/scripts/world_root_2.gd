extends Node3D

@export var collectable: PackedScene
@export var deathBall: PackedScene
@export var enemyBody: PackedScene
@export var terrain: PackedScene

var terrain1 = load("res://scenes/terrain.tscn")
var deathBall1 = load("res://scenes/deathBall.tscn")
var enemyBody1 = load("res://scenes/enemyBody.tscn")
var collectable1 = load("res://scenes/collectable.tscn")

var num_enemy = 5
var num_coll = 3
var num_obstacles = 6
var num_floors = 5
var floor_count = 0

func _ready():
	for n in num_floors:
		var new_floor = terrain1.instantiate()
		$FloorContainer.add_child(new_floor)
		new_floor.global_position = $FloorContainer.global_position + Vector3(0,0, 200*n)
		new_floor.global_rotation = global_rotation

	for e in num_enemy:
		var new_enemy = enemyBody1.instantiate()
		$EnemyContainer.add_child(new_enemy)
		new_enemy.global_position = $playerShip.global_position + Vector3(randi_range(-100,100),randi_range(10,50), 150+100*e)
		new_enemy.global_rotation = $EnemyContainer.global_rotation

	for c in num_coll:
		var new_coll = collectable1.instantiate()
		$CollectibleContainer.add_child(new_coll)
		new_coll.global_position = $CollectibleContainer.global_position + Vector3(randi_range(-100,100),randi_range(10,50), 150+80*c)
		new_coll.global_rotation = global_rotation

	for o in num_obstacles:
		var new_obs = deathBall1.instantiate()
		$ObsConstainer.add_child(new_obs)
		new_obs.global_position = $ObsConstainer.global_position + Vector3(randi_range(-100,100),randi_range(10,50), 100+50*o)
		new_obs.global_rotation = global_rotation

		
func _process(delta):
	while($FloorContainer.get_child_count()<num_floors):
		var new_floor = terrain1.instantiate()
		$FloorContainer.add_child(new_floor)
		new_floor.global_position = $FloorContainer.global_position + Vector3(0,0, 200*(num_floors+floor_count))
		new_floor.global_rotation = global_rotation
		floor_count+=1
	
	while($EnemyContainer.get_child_count()<num_enemy+1):
		var new_enemy = enemyBody1.instantiate()
		$EnemyContainer.add_child(new_enemy)
		new_enemy.global_position = $playerShip.global_position + Vector3(randi_range(-100,100),randi_range(10,50), 200)
		new_enemy.global_rotation = $EnemyContainer.global_rotation
		
	while($CollectibleContainer.get_child_count()<num_coll):
		var new_coll = collectable1.instantiate()
		$CollectibleContainer.add_child(new_coll)
		new_coll.global_position = $playerShip.global_position + Vector3(randi_range(-100,100),randi_range(10,50), 250)
		new_coll.global_rotation = global_rotation
		
	while($ObsConstainer.get_child_count()<num_obstacles):
		var new_obs = deathBall1.instantiate()
		$ObsConstainer.add_child(new_obs)
		new_obs.global_position = $playerShip.global_position + Vector3(randi_range(-100,100),randi_range(10,50), 250)
		new_obs.global_rotation = global_rotation
		
		
		
	if(Globals.total_score>1000):
		get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
