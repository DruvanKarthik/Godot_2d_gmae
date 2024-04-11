extends Node
@export  var mob_scene:PackedScene
var score  = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
func new_gmae():
	score = 0
	$HUD.update_score(score)
	get_tree().call_group("mobs","queue_free")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Music.play()
	$HUD.show_message("Get ready..")
	await($StartTimer)
	$ScoreTimer.start()
	$MobTimer.start()


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
func _on_mob_timer_timeout():
	var mob_spawn_location = $MobPath/MobSpwanLocation
	mob_spawn_location.progress_ratio = randf()
	var mob = mob_scene.instantiate()
	add_child(mob)
	mob.position = mob_spawn_location.position
	var direction = mob_spawn_location.rotation + PI / 2
	direction +=randf_range(-PI/4,+PI/4)
	mob.rotation = direction
	var velocity = Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity = velocity.rotated(direction)


func _on_score_timer_timeout():
	score+=1
	$HUD.update_score(score)
