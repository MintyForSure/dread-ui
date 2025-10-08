extends Control
#im so sorry but i didnt feel like writing efficient code lol
@onready var hpBar=$status/TextureProgressBar
@onready var hpText=$status/healthText
@onready var cursor=$status/commands/cursor
#var selectSFX=preload("res://select.tscn")

#var selected=["fight","skill","item","run"]
const mhealth=43
var health=43
var selected=null
var uiState="actionPick"
func _ready():
	hpBar.max_value=mhealth
	hpBar.value=health
#	cursor.position.y=160
	selected="fight"
	$status/commands/fight.set_modulate(Color(1.0, 1.0, 1.0, 0.5))
	$status/commands/skill.set_modulate(Color(1.0, 1.0, 1.0, 0.5))
	$status/commands/item.set_modulate(Color(1.0, 1.0, 1.0, 0.5))
	$status/commands/run.set_modulate(Color(1.0, 1.0, 1.0, 0.5))
func _process(_delta):
	hpText.text=str(health)
	#cursor.position.x
	if uiState=="actionPick":
		match selected:
			"fight":
				$status/commands/fight.set_modulate(Color(1.0, 1.0, 1.0, 1.0))
				if Input.is_action_just_pressed("ui_right"):
					$status/commands/fight.set_modulate(Color(1.0, 1.0, 1.0, .5))
					selected="skill"
				elif Input.is_action_just_pressed("ui_left"):
					$status/commands/fight.set_modulate(Color(1.0, 1.0, 1.0, .5))
					selected="run"
			"skill":
				$status/commands/skill.set_modulate(Color(1.0, 1.0, 1.0, 1.0))
				if Input.is_action_just_pressed("ui_right"):
					$status/commands/skill.set_modulate(Color(1.0, 1.0, 1.0, .5))
					selected="item"
				elif Input.is_action_just_pressed("ui_left"):
					print("02")
					$status/commands/skill.set_modulate(Color(1.0, 1.0, 1.0, .5))
					selected="fight"
			"item":
				$status/commands/item.set_modulate(Color(1,1,1,1))
				if Input.is_action_just_pressed("ui_right"):
					$status/commands/item.set_modulate(Color(1.0, 1.0, 1.0, .5))
					selected="run"
				elif Input.is_action_just_pressed("ui_left"):
					$status/commands/item.set_modulate(Color(1.0, 1.0, 1.0, .5))
					selected="skill"
			"run":
				$status/commands/run.set_modulate(Color(1,1,1,1))
				if Input.is_action_just_pressed("ui_right"):
					$status/commands/run.set_modulate(Color(1.0, 1.0, 1.0, .5))
					selected="fight"
				elif Input.is_action_just_pressed("ui_left"):
					$status/commands/run.set_modulate(Color(1.0, 1.0, 1.0, .5))
					selected="item"
