extends CharacterBody2D

@onready var canvas_layer = get_parent().get_node("CanvasLayer")
@onready var sprite = $AnimatedSprite2D

const SPEED = 400.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() or is_on_wall():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif is_on_wall():
			var normal = get_wall_normal()
			velocity.x = normal.x * SPEED
			velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if not is_on_wall():
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if global_position.y > 2000:
		respawn()
		
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true


func _on_entered(body: Node2D) -> void:
	velocity.y = -2000.0
	
func respawn():	
	canvas_layer.stop_watch()
	global_position = Vector2(-500, -1600)
	velocity = Vector2.ZERO
