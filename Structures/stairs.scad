/**
 * @brief Contains definitions of various types of stairs
 */

include <../DND Play Area Config.scad>;
use <../DND Play Area Tiles.scad>;

/**
 * @brief Makes a straight staircase
 * @param height Height in play area squares the stairs should reach
 */
module straight_stairs(height) {
    for(i=[0:height-2]) {
        translate(tile_coordinates(i,0,0)) {
            if (i > 0)
                translate([0,0,SQUARE_SIZE*i-VERTICAL_TILE_CONNECTION_HEIGHT]) 
                    basic_tile(_thickness=SQUARE_SIZE+VERTICAL_TILE_CONNECTION_HEIGHT);
            else
                translate([0,0,SQUARE_SIZE*i]) 
                    basic_tile(_thickness=SQUARE_SIZE);
        }
    }
    translate(tile_coordinates(height-1,0,0))
        connection_column(_top_connector=false,_connection_column_height=height);
}

render()
straight_stairs(5);
