/**
 * @brief This file contains various types of tiles and other modules for non-assembled/arranged pieces
 * TODO Add textures to tiles
 * TODO Tile square module
 * TODO Tile circle module
 * TODO Basic tile replacement module
 * TODO Wall modules
 */

include <DND Play Area Config.scad>;

/**
 * @brief Basic tile to use for floors
 * @param _center Whether or not to center the tile
 */
module basic_tile(_center=false, _thickness=TILE_THICKNESS) {
    if (DIP_OUTSIDE_SQUARE) {
        difference() {
            // Main tile piece
            cube([SQUARE_SIZE+DIP_DIMENSIONS,SQUARE_SIZE+DIP_DIMENSIONS,_thickness],_center);
            // Tile dip
            translate([0,0,(TILE_THICKNESS*_thickness)-DIP_DIMENSIONS])
                difference() {
                    cube([SQUARE_SIZE+DIP_DIMENSIONS,SQUARE_SIZE+DIP_DIMENSIONS,DIP_DIMENSIONS],_center);
                    translate([DIP_DIMENSIONS/2,DIP_DIMENSIONS/2,0])
                        cube([SQUARE_SIZE,SQUARE_SIZE,DIP_DIMENSIONS],_center);
                }
        }
    } else {
        difference() {
            // Main tile piece
            cube([SQUARE_SIZE,SQUARE_SIZE,_thickness],_center);
            // Tile dip
            translate([0,0,_thickness-DIP_DIMENSIONS])
                difference() {
                    cube([SQUARE_SIZE,SQUARE_SIZE,DIP_DIMENSIONS],_center);
                    translate([DIP_DIMENSIONS/2,DIP_DIMENSIONS/2,0])
                        cube([SQUARE_SIZE-DIP_DIMENSIONS,SQUARE_SIZE-DIP_DIMENSIONS,DIP_DIMENSIONS],_center);
                }
        }
    }
}

/**
 * @brief This tile can be placed on play areas to link them to other pieces.
 * @param _center Whether or not to center the tile
 * @param _bothsides Whether the connection hole should be on both sides or just the top one
 */
module connection_tile(_center=false,_bothsides=false) {
    translate_amount = DIP_OUTSIDE_SQUARE ? (SQUARE_SIZE+DIP_DIMENSIONS)/2 : SQUARE_SIZE/2;
    difference() {
        basic_tile(_center);
        translate([translate_amount,translate_amount,_bothsides ? 0 : TILE_THICKNESS/2])
            scale([1,1,_bothsides ? 2 : 1])
                connection_shape(_center);
    }
}

/**
 * TODO this should just be an option on the regular connection tile, but for now it'll be here
 */
module flipped_connection_tile() {
    rotate([180,0,0])
        translate([0,-SQUARE_SIZE,-TILE_THICKNESS])
            connection_tile();
}

/**
 * @brief Column for connecting pieces vertically
 * @param _connection_column_height Height of the column in play area squares
 * @param _top_connector If the connection piece on the top should be included
 * @param _bottom_connector If the connection piece on the bottom should be included
 */
module connection_column(_connection_column_height=CONNECTION_COLUMN_HEIGHT,_top_connector=true,_bottom_connector=true,_center=false) {
    column_offset = _bottom_connector ? CONNECTION_PEG_HEIGHT : 0;
    connection_column_height=SQUARE_SIZE*_connection_column_height - column_offset;
    if (_bottom_connector)
        connection_shape();
    if (_top_connector) {
        translate([0,0,column_offset])
            cube([SQUARE_SIZE,SQUARE_SIZE,connection_column_height],_center);
        translate([0,0,column_offset+connection_column_height])
            connection_shape();
    } else {
        no_top_column_height = connection_column_height-SQUARE_SIZE-CONNECTION_PEG_HEIGHT;
        translate([0,0,CONNECTION_PEG_HEIGHT]) {
            cube([SQUARE_SIZE,SQUARE_SIZE,no_top_column_height],_center);
            translate([0,0,no_top_column_height])
                basic_tile(_thickness=SQUARE_SIZE,_center=_center);
        }
    }
}

/**
 * @brief Creates a line of basic tiles of a specified length
 */
module tile_line(_length) {
    for(i=[0:_length-1])
        translate([i*SQUARE_SIZE,0,0])
            basic_tile();
}

/**
 * @brief Creates a rectangle of basic tiles
 */
module tile_rectangle(_length,_width) {
    for(i=[0:_width-1])
        translate([0,i*SQUARE_SIZE,0])
            tile_line(_length);
}

/**
 * @brief Creates a rectangle to fit between two points
 * @param _cordsOne Array(3) of points (x,y,z), used as rectangles home (should be to the right of _cordsTwo
 * @param _cordsTwo Array(3) of points (x,y,z)
 */
module tile_rectangle_between_points(_cordsOne, _cordsTwo) {
    translate(tile_coordinates(_cordsOne[0],_cordsOne[1],_cordsOne[2])) {
        
        rectX = (_cordsOne[0] == _cordsTwo[0]) ? 1 :  abs(_cordsOne[0]-_cordsTwo[0]);
        
        rectY = (_cordsOne[1] == _cordsTwo[1]) ? 1 : abs(_cordsOne[1]-_cordsTwo[1]);
        
        tile_rectangle(rectX,rectY);
    }
}
