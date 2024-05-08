extends Node2D

var platforms = []
var stepCount = 0

var r = RandomNumberGenerator.new()

var setup = true


@onready var jumpSound = $JumpSound

func _ready():
	platforms.append(Platform.new(r.randi_range(-1,1)))
	for n in range(0, ((Global.height + Global.platformDistance) / Global.platformDistance)-1):
		move()
	print(platforms.size())
	stepCount = 0

	var offsetX = (float(Global.width/2) - Global.platformLength) - (platforms[1].pos.x)

	for platform in platforms:
		platform.moveX(offsetX)

	setup = false
	
	
func _process(delta):
	if Input.is_action_just_pressed("left"):
		movePlayer(-1)
	if Input.is_action_just_pressed("right"):
		movePlayer(1)
	if Input.is_action_just_pressed("up"):
		movePlayer(0)
	for platform in platforms:
		platform.move(delta)
	queue_redraw()
	

func movePlayer(direction):
	if ((direction == 0 && platforms[2].side == 0) || (direction == 1 && platforms[2].side == 1) || (direction == -1 && platforms[2].side == -1)):
		move()
		jumpSound.play()
		if (direction != 0):
			for platform in platforms:
				platform.moveX(-direction * Global.platformLength)
	else:
		die()
		

	return

func move():
	for platform in platforms:
		platform.moveY(Global.platformDistance)
	platforms.append(Platform.new(r.randi_range(-1,1)))
	shift(platforms.size()-2, platforms.size()-1)
	if (!setup):
		platforms.remove_at(0)
	stepCount += 1
	
	
	
func die():
	platforms.clear()
	setup = true
	platforms.append(Platform.new(r.randi_range(-1,1)))
	for n in range(0, ((Global.height + Global.platformDistance) / Global.platformDistance)-1):
		move()
	var offsetX = (float(Global.width/2) - Global.platformLength) - (platforms[1].pos.x)

	for platform in platforms:
		platform.moveX(offsetX)
	setup = false
	print(platforms.size())
	
	
	
func shift(prev, post):
	var postPlatform = platforms[post]
	postPlatform.setX(platforms[prev].pos.x)
	postPlatform.moveX(Global.platformLength * postPlatform.side)

func _draw():
	for i in range(platforms.size()):
		if i == 1:
			draw_rect(Rect2(platforms[i].projectedPos.x + Global.platformLength/2, platforms[i].projectedPos.y, Global.platformLength, 10), Color(1,0,0))
		else:
			draw_rect(Rect2(platforms[i].projectedPos.x + Global.platformLength/2, platforms[i].projectedPos.y, Global.platformLength, 10), Color(0,0,0))
