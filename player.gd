extends Area2D
signal hit
@export var speed = 400.0 
# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var screen_size = get_viewport_rect().size
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x+=1
	if Input.is_action_pressed("move_left"):
		direction.x-=1
	if Input.is_action_pressed("move_down"):
		direction.y+=1
	if Input.is_action_pressed("move_up"):
		direction.y-=1
	if direction.length() > 0:
		direction = direction.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += direction * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if direction.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = direction.x < 0
	elif direction.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = direction.y > 0
func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false
	
func _on_body_entered(body):
	hide()
	$CollisionShape2D.set_deferred("disabled",true)
	emit_signal("hit")
	
