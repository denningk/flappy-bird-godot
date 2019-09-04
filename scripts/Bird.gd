# script: bird

extends RigidBody2D

func _ready():
	linear_velocity = Vector2(50, linear_velocity.y)

func _integrate_forces(_delta):
	if rotation_degrees < -30:
		rotation = deg2rad(-30)
		angular_velocity = 0
		
	if linear_velocity.y > 0:
		angular_velocity = 1.5

func flap():
	linear_velocity = Vector2(linear_velocity.x, -150)
	angular_velocity = -3

func _input(event):
	if event.is_action_pressed("flap"):
		flap()