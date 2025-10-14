extends Control

@onready var hpBar=$status/healthBar
@onready var hpText=$status/healthText
@onready var focusBar=$status/focusBar
@onready var focusText=$status/focusText

var battleJSON = JSON.parse_string(FileAccess.get_file_as_string("res://assets/scripts/battleOpener.json"))

const mhealth=43
var health=43
var uiState="startWindow"
var selectedEnemy=0

func _ready():
	$"../pcam".set_look_at_damping(true)
	$"../pcam".set_look_at_damping_value(.1)
	restoreMenuState()
	hpBar.max_value=mhealth
	hpBar.value=health
	$window.position=$windowPos.position
	$window.windowInit(384.0, 88.0)
func _process(_delta):
	hpText.text=str(health)
	#cursor.position.x
	match uiState:
		"startWindow":
			$"../pcam".look_at_mode=0
			$"../pcam".set_look_at_target($"../enemies")
			$window.textWindow(battleJSON.maremareEncounter.text,"actionPick")
		"actionPick":
			#print("hi minty")
			if Input.is_action_just_pressed("ui_up"):
				#var commandAreaTween=create_tween()
				$status/commands/selectSFX.play()
				$%commandAnims.play("fightNoFade")
				await $%commandAnims.animation_finished
				$%commandAnims.play_backwards("appear")
				uiState="fight"
			elif Input.is_action_just_pressed("ui_right"):
				$status/commands/selectSFX.play()
				$%commandAnims.play("stratNoFade")
				uiState="strat"
			elif Input.is_action_just_pressed("ui_down"):
				$status/commands/selectSFX.play()
				$%commandAnims.play("fleeNoFade")
				uiState="flee"
			elif Input.is_action_just_pressed("ui_left"):
				$status/commands/selectSFX.play()
				$%commandAnims.play("itemNoFade")
				uiState="item"
		"fight":
			var enemyList=$"../enemies".get_children()
			$"../pcam".look_at_mode=2
			$window.textWindow(str(enemyList[selectedEnemy]),"nowhere",true)
			print(selectedEnemy)
			$"../pcam".set_look_at_target(enemyList[selectedEnemy])
			if Input.is_action_just_pressed("ui_left"):
				if selectedEnemy != 0:
					selectedEnemy-=1
				elif selectedEnemy==0:
					selectedEnemy=len(enemyList)-1
			if Input.is_action_just_pressed("ui_right"):
				if selectedEnemy != len(enemyList)-1:
					print("get fucked")
					selectedEnemy+=1
				else:
					selectedEnemy=0
			if Input.is_action_just_pressed("ui_cancel"):
				$%commandAnims.play("appear")
				#$"../pcam".look_at_mode=0
				$"../pcam".set_look_at_target($"../lookie")
				restoreMenuState()
				$window.flushText()
				$window.textWindow(battleJSON.maremareEncounter.text,"nowhere",true)
				uiState="actionPick"

func restoreMenuState(): #ccould've made it more efficient but oh well lol
	$status/commands/fight.set_modulate(Color(1.0, 1.0, 1.0, 1.0))
	$status/commands/skill.set_modulate(Color(1.0, 1.0, 1.0, 1.0))
	$status/commands/item.set_modulate(Color(1.0, 1.0, 1.0, 1.0))
	$status/commands/run.set_modulate(Color(1.0, 1.0, 1.0, 1.0))
	
	$status/commands/fight.set_scale(Vector2(2,2))
	$status/commands/skill.set_scale(Vector2(2,2))
	$status/commands/item.set_scale(Vector2(2,2))
	$status/commands/run.set_scale(Vector2(2,2))

#func enemySelect():
	#
