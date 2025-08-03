# MusicManager.gd（设置为AutoLoad）
extends Node

var music_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.bus = "Music"

func play_music(stream: AudioStream):
	if music_player.stream == stream:
		return # 防止重复播放
	music_player.stop()
	music_player.stream = stream
	music_player.play()
