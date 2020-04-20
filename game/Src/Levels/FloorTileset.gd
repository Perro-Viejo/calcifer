class_name FloorTileset
extends TileSet

export(Array, int, "Red", "Green", "Blue") var enums = [2, 1, 0]

func get_floor_sfx(id: int) -> String:
	if id > -1:
		match tile_get_name(id):
			'river-grass':
				return 'FS_Mud'
	return 'FS'
