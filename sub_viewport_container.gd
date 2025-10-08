extends Control
@onready var hpBar=$status/TextureProgressBar
@onready var hpText=$status/healthText
@onready var cursor=$status/commands/cursor
const mhealth=43
var health=43
var selected=null
var uiState="ready"
func _ready():
	hpBar.max_value=mhealth
	hpBar.value=health
	cursor.position.y=148
func _process(delta):
	hpText.text=str(health)
	#cursor.position.x
	match selected:
		"fight":
			cursor.position.x=$status/commands/fight.position.x
