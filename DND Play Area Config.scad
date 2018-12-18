/** Size of each square floor tile */
SQUARE_SIZE = 25.4;
/** Thickness of tiles*/
TILE_THICKNESS = 8;
/** Width and thickness of the dip between tiles */
DIP_DIMENSIONS = TILE_THICKNESS*0.25;
/** Scale of the connection shape to use for the indents into blocks (so that other pieces fit in them) */
CONNECTION_HOLE_SCALE = 1.05;
/** Diameter of the connection holes/pegs */
CONNECTION_PEG_DIAMETER = SQUARE_SIZE*0.75;
/** Height of the connection peg */
CONNECTION_PEG_HEIGHT = TILE_THICKNESS/2;
/** Height of connection columns (for multi-level buildings this is the standard height of one floor) */
CONNECTION_COLUMN_HEIGHT = SQUARE_SIZE*3;
/** Whether the dip should come outside the square size or if it should be included */
DIP_OUTSIDE_SQUARE = false; // Some things are currently not configured for the dip being outside the square

/**
 * @brief This shape is used to connect various pieces together
 */
module connection_shape(_center=false) {
    cylinder($fn=6,d=CONNECTION_PEG_DIAMETER,h=CONNECTION_PEG_HEIGHT,center=_center);
}

/**
 * @brief Arranges this shape to be cutout of a tile
 */
module cutout_connection_shape(_bothSides=false,_center=false) {
    translate_amount = DIP_OUTSIDE_SQUARE ? (SQUARE_SIZE+DIP_DIMENSIONS)/2 : SQUARE_SIZE/2;
    translate([translate_amount,translate_amount,_bothSides ? 0 : TILE_THICKNESS/2])
        scale([1,1,_bothSides ? 2 : 1])
            connection_shape(_center);
}

/**
 * @brief Converts numbers into tile size for use as coordinates
 */
function tile_coordinates(_x,_y,_z) = [_x*SQUARE_SIZE,_y*SQUARE_SIZE,_z*SQUARE_SIZE];

/**
 * @brief Translates an object using the tile coordinate system
 * @param _point Point to translate to
 */
module tile_translate(_point) {
    for(i=[0:$children-1])
        translate(tile_coordinates(_point[0],_point[1],_point[2]))
            children(i);
}