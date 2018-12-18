/**
 * @brief Defines a structure for placing a figure on with raised
 * pieces to place curse markers on.
 */

include <../DND Play Area Config.scad>;
use <../DND Play Area Tiles.scad>;

/**
 * The main base of the alter. Should be big enough to fit most 
 * medium sized creatures on.
 */
module alter_base() {
    tile_rectangle(4,4);
    connection_column();
    translate(tile_coordinates(0,3,0))
        connection_column();
    translate(tile_coordinates(3,3,0))
        connection_column();
    translate(tile_coordinates(3,0,0))
        connection_column();
    translate([0,0,TILE_THICKNESS])
        translate(tile_coordinates(1,1,0))
            tile_rectangle(2,2);
}

/**
 * @brief Creates a stack of tiles to simulate stairs
 * @param _height How many tiles should be in the stack
 */
module tile_stair(_height=2) {
    for(i=[0:_height-1]) {
        translate([0,0,TILE_THICKNESS*i]) {   
            basic_tile();
        }
    }
}

module alter_attachmemt() {
    flipped_connection_tile();
    translate(tile_coordinates(0,1,0))
        tile_stair();
    translate(tile_coordinates(1,0,0))
        tile_stair();
    translate(tile_coordinates(1,1,0))
        translate([0,0,TILE_THICKNESS])
            tile_stair();
}

alter_base();
translate(tile_coordinates(-3,-3,0))
    alter_attachmemt();