extends TileMapLayer

@export var floor: TileMapLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var filled_tiles := get_used_cells()
	for filled_tile: Vector2i in filled_tiles:
		var floor_cell_under_wall = floor.get_cell_tile_data(filled_tile)
		if floor_cell_under_wall:
			floor.set_cell(filled_tile, -1)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
