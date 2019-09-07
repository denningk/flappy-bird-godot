# script: bird

extends RigidBody2D

onready var state = FlyingState.new(self)

var speed = 50

enum {STATE_FLYING, STATE_FLAPPING, STATE_HIT, STATE_GROUNDED}

signal state_changed

func _ready():
	connect("body_entered", self, "_on_body_enter")
	
func _integrate_forces(_delta):
	state.update(_delta)

func _input(event):
	state.input(event)

func _on_body_enter(other_body):
	if state.has_method("on_body_enter"):
		state.on_body_enter(other_body)

func set_state(new_state):
	state.exit()
	
	if new_state == STATE_FLYING:
		state = FlyingState.new(self)
	elif new_state == STATE_FLAPPING:
		state = FlappingState.new(self)
	elif new_state == STATE_HIT:
		state = HitState.new(self)
	elif new_state == STATE_GROUNDED:
		state = GroundedState.new(self)
		
	emit_signal("state_changed", self)

func get_state():
	if state is FlyingState:
		return STATE_FLYING
	elif state is FlappingState:
		return STATE_FLAPPING
	elif state is HitState:
		return STATE_HIT
	elif state is GroundedState:
		return STATE_GROUNDED
		
# class FlyingState ------------------------

class FlyingState:
	var bird
	var prev_gravity_scale
	
	func _init(bird):
		self.bird = bird
		bird.get_node("Anim").play("flying")
		bird.linear_velocity = Vector2(bird.speed, bird.linear_velocity.y)
		
		prev_gravity_scale = bird.gravity_scale
		bird.gravity_scale = 0
	
	func update(_delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		bird.gravity_scale = prev_gravity_scale
		bird.get_node("Anim").stop()
		bird.get_node("Anim_sprite").position = Vector2(0,0)

# class FlappingState ------------------------

class FlappingState:
	var bird
	
	func _init(bird):
		self.bird = bird
		
		bird.linear_velocity = Vector2(bird.speed, bird.linear_velocity.y)
		flap()
		
	func update(_delta):
		if bird.rotation_degrees < -30:
			bird.rotation = deg2rad(-30)
			bird.angular_velocity = 0
		
		if bird.linear_velocity.y > 0:
			bird.angular_velocity = 1.5
	
	func input(event):
		if event.is_action_pressed("flap"):
			flap()
	
	func on_body_enter(other_body):
		if other_body.is_in_group(Game.GROUP_PIPES):
			bird.set_state(bird.STATE_HIT)
		elif other_body.is_in_group(Game.GROUP_GROUNDS):
			bird.set_state(bird.STATE_GROUNDED)
	
	func flap():
		bird.linear_velocity = Vector2(bird.linear_velocity.x, -150)
		bird.angular_velocity = -3
		bird.get_node("Anim").play("flap")
	
	func exit():
		pass
	
# class HitState ------------------------

class HitState:
	var bird
	
	func _init(bird):
		self.bird = bird
		bird.linear_velocity = Vector2(0,0)
		bird.angular_velocity = 2
		
		var other_body = bird.get_colliding_bodies()[0]
		bird.add_collision_exception_with(other_body)
		
	func update(_delta):
		pass
	
	func input(event):
		pass
	
	func on_body_enter(other_body):
		if other_body.is_in_group(Game.GROUP_GROUNDS):
			bird.set_state(bird.STATE_GROUNDED)
	
	func exit():
		pass

# class GroundedState ------------------------

class GroundedState:
	var bird
	
	func _init(bird):
		self.bird = bird
		bird.linear_velocity = Vector2(0,0)
		bird.angular_velocity = 0
	
	func update(_delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		pass