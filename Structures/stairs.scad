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
    for(i=[0:height-1]) {
        translate(tile_coordinates(i,0,0)) {
            thickness = i == 0 ? 2 : 3;
            translate([0,0,TILE_THICKNESS*2*i-(thickness-2)*TILE_THICKNESS]) {
                basic_tile(_thickness=thickness);
            }
        }
    }
    translate(tile_coordinates(height,0,0))
        connection_column(_connection_column_height=3,_top_connector=false);
}

render()
straight_stairs(5);