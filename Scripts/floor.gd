extends TileMapLayer

func _ready() -> void:
	var filled_tiles = get_used_cells()
	for tile in filled_tiles:
		var neighbouring = get_surrounding_cells(tile)
		for neighbour: Vector2i in neighbouring:
			if get_cell_source_id(neighbour) == -1: # checks if neighbour cell exists
				var neighbourUnder: Vector2i = Vector2.ZERO # defining tile under neighbour tile
				neighbourUnder.x = neighbour.x
				neighbourUnder.y = neighbour.y + 2
				var neighbourUp: Vector2i = Vector2.ZERO # defining tile over neighbour tile
				neighbourUp.x = neighbour.x
				neighbourUp.y = neighbour.y - 2
				if get_cell_source_id(neighbourUnder) || get_cell_source_id(neighbourUp)== -1: # checks if over or under neighbour cell there is a tile
					set_cell(neighbour, 1, Vector2i.ZERO) # sets collision
			
