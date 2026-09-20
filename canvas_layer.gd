extends CanvasLayer

@onready var label: Label = $Stopwatch

var time_elapsed: float = 0.0
var run: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	run = true
	time_elapsed = 0.0
	update_display()

func stop_watch() -> void:
	run = false

	var min: int = int(time_elapsed / 60)
	var sec: int = int(time_elapsed) % 60
	var mil: int = int((time_elapsed - int(time_elapsed)) * 100)
	
	label.text = "%02d:%02d:%02d" %[min, sec, mil]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if run:
		time_elapsed += delta
		update_display()
		
func update_display() -> void:
	var min: int = int(time_elapsed / 60)
	var sec: int = int(time_elapsed) % 60
	var mil: int = int((time_elapsed - int(time_elapsed)) * 100)
	
	label.text = "%02d:%02d:%02d" %[min, sec, mil]
