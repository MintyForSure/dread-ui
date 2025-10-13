extends Control
#im so sorry but i didnt feel like writing efficient code lol
@onready var hpBar=$status/healthBar
@onready var hpText=$status/healthText
@onready var focusBar=$status/focusBar
@onready var focusText=$status/focusText

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
	#selected="fight"
	#$status/commands/fight.set_modulate(Color(1.0, 1.0, 1.0, 0.5))
	#$status/commands/skill.set_modulate(Color(1.0, 1.0, 1.0, 0.5))
	#$status/commands/item.set_modulate(Color(1.0, 1.0, 1.0, 0.5))
	#$status/commands/run.set_modulate(Color(1.0, 1.0, 1.0, 0.5))
func _process(delta):
	hpText.text=str(health)
	#cursor.position.x
	match uiState:
		"actionPick":
			if Input.is_action_just_pressed("ui_up"):
				$status/commands/selectSFX.play()
				optFade("fight",delta)
				uiState="fight"
			elif Input.is_action_just_pressed("ui_right"):
				$status/commands/selectSFX.play()
				uiState="strat"
			elif Input.is_action_just_pressed("ui_down"):
				$status/commands/selectSFX.play()
				uiState="flee"
			elif Input.is_action_just_pressed("ui_left"):
				$status/commands/selectSFX.play()
				uiState="item"

func optFade(noFade,delta):
	match noFade:
		"fight":
			$status/commands/skill.set_modulate(Color(1.0, 1.0, 1.0, lerp(1.0,0.5,.9)))
			$status/commands/item.set_modulate(Color(1.0, 1.0, 1.0, lerp(1.0,0.5,0.9)))
			$status/commands/run.set_modulate(Color(1.0, 1.0, 1.0, lerp(1.0,0.5,0.9)))
