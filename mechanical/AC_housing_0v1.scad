// shroud to cover AC wiring
$fa = 1;
$fs = 0.5;

// "length" is along X axis
// "width" is along Y axis
// "height" is along Z axis

width = 70;
length = 90;
height = 28;
wall_t = 2.5;
floor_t = 1.5;
mount_offset = 25;  // from X=0 to closest mounting holes
mount_pitch = 45;   // between mounting holes
mount_length = 12;  // length of mount tabs
mount_width = 12;   // width of mount tabs
mount_hole_d = 4.5; // for M4 bolt
socket_length = 25; // length of IEC socket into housing

translate([0,socket_length,floor_t])
cube([16,45,12]);

translate([0,length+2*wall_t,height-1])
rotate([90,0,0])
cylinder(d=4, h=4*wall_t);



difference() {
    union() {
       // outer shell of enclosure
       translate([0,length/2,height/2])
       cube(size=[width,length,height],center=true);
        
       // mounting tabs 
       translate([0,mount_offset,height-2])
       cube(size=[width+(mount_width*2),mount_length,4],center=true);
        
       // more mounting tabs 
       translate([0,mount_offset+mount_pitch,height-2])
       cube(size=[width+(mount_width*2),mount_length,4],center=true);
    }
    // remove inner volume of enclosure
       translate([0,length/2,height/2+floor_t*2])
       cube(size=[width-2*wall_t,length-2*wall_t,height+floor_t],center=true);   

    // remove IEC power entry mounting area
    translate([0,0,15])
    {
       // from datasheet of IEC entry units
       // cutout for Schurter P/N 6100-3
       cube(size=[28.5,10,21],center=true);

       // mounting holes
       translate([-20,5,0])
       rotate([90,0,0])
       cylinder(d=3.5, h=10);
       translate([20,5,0])
       rotate([90,0,0])
       cylinder(d=3.5, h=10);
    }
    
    // remove mounting tab holes
    translate([-(width+mount_width)/2,mount_offset,0])
    cylinder(d=mount_hole_d, h=height*2);
    
    translate([(width+mount_width)/2,mount_offset,0])
    cylinder(d=mount_hole_d, h=height*2);

    translate([-(width+mount_width)/2,mount_offset+mount_pitch,0])
    cylinder(d=mount_hole_d, h=height*2);
    
    translate([(width+mount_width)/2,mount_offset+mount_pitch,0])
    cylinder(d=mount_hole_d, h=height*2);
    
}


