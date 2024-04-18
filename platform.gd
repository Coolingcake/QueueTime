extends Node2D
class_name Platform
var pos: Vector2
var projectedPos: Vector2
var side

func _init(s):
	side = s
	initialize()
	
func initialize():
	if (side == -1):
		pos = Vector2((float(Global.width)/2) - Global.platformLength * 2, 0)
	elif (side == 0):
		pos = Vector2((float(Global.width)/2) - (float(Global.platformLength)/2), 0)
	elif (side == 1):
		pos = Vector2(float(Global.width)/2, 0)
	projectedPos = Vector2(pos.x, pos.y)
	
func moveY(num):
	pos.y += num

func moveX(num):
	pos.x += num

func setX(num):
	pos.x = num
  
func move(delta):
	projectedPos.y = lerp(projectedPos.y, pos.y, 0.1)
	projectedPos.x = lerp(projectedPos.x, pos.x, 0.1)
