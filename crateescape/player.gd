extends Area2D

@export var speed := 200 
var screen_size
var last_direction = "down"  # Keep track of the last direction

func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play("down_idle")  # Start idle facing down

func _process(delta):
	var velocity = Vector2.ZERO  # Reset velocity every frame

	# Handle player input for movement
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		last_direction = "up"
	if Input.is_action_pressed("down"):
		velocity.y += 1
		last_direction = "down"
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		last_direction = "left"
	if Input.is_action_pressed("right"):
		velocity.x += 1
		last_direction = "right"

	# If the player is moving, normalize and play the walk animation
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

		# Play walk animation based on the direction
		if velocity.y < 0:
			$AnimatedSprite2D.play("up_walk")
		elif velocity.y > 0:
			$AnimatedSprite2D.play("down_walk")
		elif velocity.x < 0:
			$AnimatedSprite2D.play("left_walk")
		elif velocity.x > 0:
			$AnimatedSprite2D.play("right_walk")
	else:
		# If no input, stop the movement and play idle animation based on last direction
		$AnimatedSprite2D.play("idle_down")

	# Update player position only if there’s movement (velocity)
	if velocity != Vector2.ZERO:
		position += velocity * delta

	# Keep the player inside the screen boundaries
	position = position.clamp(Vector2.ZERO, screen_size)
