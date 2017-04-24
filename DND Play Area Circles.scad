use <DND Play Area Tiles.scad>;
include <DND Play Area Config.scad>;

/**
 * @brief This creates a circle out of basic tiles with a diameter of 5
 * @note 
 */
module tile_circle_5() {
    translate(tile_coordinates(1,0,0))
        tile_rectangle(3,5);
    translate(tile_coordinates(0,1,0))
        tile_rectangle(5,3);
}

/**
 * @brief This creates a circle out of basic tiles with a diameter of 7
 */
module tile_circle_7() {
    translate(tile_coordinates(2,0,0))
        tile_rectangle(3,7);
    translate(tile_coordinates(0,2,0))
        tile_rectangle(7,3);
    translate(tile_coordinates(1,1,0))
        basic_tile();
    translate(tile_coordinates(1,5,0))
        basic_tile();
    translate(tile_coordinates(5,1,0))
        basic_tile();
    translate(tile_coordinates(5,5,0))
        basic_tile();
}

/**
 * @brief This creates a circle out of basic tiles with a diameter of 9
 */
module tile_circle_9() {
    translate(tile_coordinates(2,0,0))
        tile_rectangle(5,9);
    translate(tile_coordinates(0,2,0))
        tile_rectangle(9,5);
    translate(tile_coordinates(1,1,0))
        basic_tile();
    translate(tile_coordinates(1,7,0))
        basic_tile();
    translate(tile_coordinates(7,1,0))
        basic_tile();
    translate(tile_coordinates(7,7,0))
        basic_tile();
}

/**
 * @brief This creates a circle of any (probably) size with 8-point symmetry
 */
module eight_sym_circle(_xCenter, _yCenter, _radius) {
    
        r2 = _radius * _radius;
        translate(tile_coordinates(_xCenter, _yCenter + _radius,0))
            basic_tile();
        translate(tile_coordinates(_xCenter, _yCenter - _radius,0))
            basic_tile();
        translate(tile_coordinates(_xCenter + _radius, _yCenter,0))
            basic_tile();
        translate(tile_coordinates(_xCenter - _radius, _yCenter,0))
            basic_tile();

        y = radius;
        x = 1;
        y = round(sqrt(r2 - 1) + 0.5);
        for (x=[1:y]) {
            translate(tile_coordinates(_xCenter + x, _yCenter + y,0))
                basic_tile();
            translate(tile_coordinates(_xCenter + x, _yCenter - y,0))
                basic_tile();
            translate(tile_coordinates(_xCenter - x, _yCenter + y,0))
                basic_tile();
            translate(tile_coordinates(_xCenter - x, _yCenter - y,0))
                basic_tile();
            translate(tile_coordinates(_xCenter + y, _yCenter + x,0))
                basic_tile();
            translate(tile_coordinates(_xCenter + y, _yCenter - x,0))
                basic_tile();
            translate(tile_coordinates(_xCenter - y, _yCenter + x,0))
                basic_tile();
            translate(tile_coordinates(_xCenter - y, _yCenter - x,0))
                basic_tile();
            y = round(sqrt(r2 - x*x) + 0.5);
        }
        if (x == y) {
            translate(tile_coordinates(_xCenter + x, _yCenter + y,0));
            translate(tile_coordinates(_xCenter + x, _yCenter - y,0));
            translate(tile_coordinates(_xCenter - x, _yCenter + y,0));
            translate(tile_coordinates(_xCenter - x, _yCenter - y,0));
        }

    
}

/**
 * @brief This creates a circle of any (probably) size with 8-point symmetry
 * This uese the algorithm from the bottom of the page here http://groups.csail.mit.edu/graphics/classes/6.837/F98/Lecture6/circle.html for generation of the outer circle (see module eight_sym_circle for this algorithms implimentation without filling it)
 */
module filled_eight_sym_circle(_xCenter, _yCenter, _radius) {
    
    translate(tile_coordinates(_xCenter, _yCenter + _radius,0))
        basic_tile();
    translate(tile_coordinates(_xCenter, _yCenter - _radius,0))
        basic_tile();
    translate(tile_coordinates(_xCenter + _radius, _yCenter,0))
        basic_tile();
    tile_rectangle_between_points([_xCenter,_yCenter - _radius,0],[_xCenter ,_yCenter + _radius,0]);
    
    r2 = _radius * _radius;
    y = radius;
    x = 1;
    y = round(sqrt(r2 - 1) + 0.5);
    for (x=[1:y]) {
        translate(tile_coordinates(_xCenter + x, _yCenter + y,0))
            basic_tile();
        tile_rectangle_between_points([_xCenter + x,_yCenter - y,0],[_xCenter + x,_yCenter + y,0]);
        translate(tile_coordinates(_xCenter - x, _yCenter + y,0))
            basic_tile();
        translate(tile_coordinates(_xCenter - x, _yCenter - y,0))
            basic_tile();
        tile_rectangle_between_points([_xCenter - x,_yCenter - y,0],[_xCenter - x,_yCenter + y,0]);
        translate(tile_coordinates(_xCenter + y, _yCenter + x,0))
            basic_tile();
        translate(tile_coordinates(_xCenter + y, _yCenter - x,0))
            basic_tile();
        translate(tile_coordinates(_xCenter - y, _yCenter + x,0))
            basic_tile();
        translate(tile_coordinates(_xCenter - y, _yCenter - x,0))
            basic_tile();
        y = round(sqrt(r2 - x*x) + 0.5);
    }
    if (x == y) {
        translate(tile_coordinates(_xCenter + x, _yCenter + y,0));
        translate(tile_coordinates(_xCenter + x, _yCenter - y,0));
        translate(tile_coordinates(_xCenter - x, _yCenter + y,0));
        translate(tile_coordinates(_xCenter - x, _yCenter - y,0));
    }
    
}

/**
 * @brief Creates a half circle
 * @param _radius Radius of the half circle
 */
module half_circle(_xCenter, _yCenter, _radius) {
    
    translate(tile_coordinates(_xCenter, _yCenter + _radius,0))
        basic_tile();
    translate(tile_coordinates(_xCenter, _yCenter,0))
        basic_tile();
    translate(tile_coordinates(_xCenter + _radius, _yCenter,0))
        basic_tile();
    tile_rectangle_between_points([_xCenter,_yCenter,0],[_xCenter ,_yCenter + _radius,0]);
    
    r2 = _radius * _radius;
    y = radius;
    x = 1;
    y = round(sqrt(r2 - 1) + 0.5);
    for (x=[1:y]) {
        translate(tile_coordinates(_xCenter + x, _yCenter + y,0))
            basic_tile();
        tile_rectangle_between_points([_xCenter + x,_yCenter,0],[_xCenter + x,_yCenter + y,0]);
        translate(tile_coordinates(_xCenter - x, _yCenter + y,0))
            basic_tile();
        translate(tile_coordinates(_xCenter - x, _yCenter,0))
            basic_tile();
        tile_rectangle_between_points([_xCenter - x,_yCenter,0],[_xCenter - x,_yCenter + y,0]);
        translate(tile_coordinates(_xCenter + y, _yCenter + x,0))
            basic_tile();
        translate(tile_coordinates(_xCenter + y, _yCenter,0))
            basic_tile();
        translate(tile_coordinates(_xCenter - y, _yCenter + x,0))
            basic_tile();
        translate(tile_coordinates(_xCenter - y, _yCenter,0))
            basic_tile();
        y = round(sqrt(r2 - x*x) + 0.5);
    }
    if (x == y) {
        translate(tile_coordinates(_xCenter + x, _yCenter + y,0));
        translate(tile_coordinates(_xCenter + x, _yCenter,0));
        translate(tile_coordinates(_xCenter - x, _yCenter + y,0));
        translate(tile_coordinates(_xCenter - x, _yCenter,0));
    }
}

/**
 * @brief This takes a long time and doesn't generate the best circle - use fileld 8 point symmetry
 * @param _radius Radius of the circle to draw and fill
 */
module draw_filled_circle(_radius) {
    for (y=[-_radius:_radius+1])
        for (x=[-_radius:_radius+1])
            if ((x * x) + (y * y) <= (_radius * _radius))
                translate(tile_coordinates(x,y,0))
                    basic_tile();
}

//render() {
    half_circle(0,0,2);
//}