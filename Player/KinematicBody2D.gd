extends KinematicBody2D


export var speed = Vector2(300,300)
var velocity = Vector2()
var mouse_location
var health = 11
var power = 31
var invincible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	var direction = get_direction()
	velocity = direction * speed
	velocity = move_and_slide(velocity)
	if Input.is_action_just_pressed("teleport"):
		teleport()
	

func get_direction():
	return Vector2(Input.get_action_strength("right")-Input.get_action_strength("left"),Input.get_action_strength("down")-Input.get_action_strength("up"))

func teleport():
	if power >= 8:
		mouse_location = get_global_mouse_position()
		set_position(mouse_location)
		power -= 8


func hurt(damage):
	if !invincible:
		health -= damage
		health = clamp(health, 0, 11)
		invincible = true
		$Invicibility.start()

func _on_Invicibility_timeout():
	invincible = false


func _on_RechargeTimer_timeout():
	power +=1
	power = clamp(power, 0, 31)
