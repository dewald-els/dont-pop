extends Node


@onready var sfx_stream_01: AudioStreamPlayer2D = %StreamPlayer_001
@onready var sfx_stream_02: AudioStreamPlayer2D = %StreamPlayer_002

func play_sfx(stream: AudioStream, bus: String) -> void:
	if not sfx_stream_01.playing:
		sfx_stream_01.bus = bus
		sfx_stream_01.stream = stream
		sfx_stream_01.play()
	elif not sfx_stream_02.playing:
		sfx_stream_02.bus = bus
		sfx_stream_02.stream = stream
		sfx_stream_02.play()
	else:
		print("Both streams are playing...")
