/*
  Enclosure For Reflow Hotplate
  
  Version 0.1
  T. LeMense
  January 21, 2021
*/


$fa = 1;
$fs = 0.4;

box_t = 3.0;    // box wall thickness
box_h = 40.0;   // box height
box_l = 70.0;   // box outside length
box_w = 60.0;   // box outside width
box_t1 = box_t/2;   // ledge for lid

lid_t = 2.5;
lid_l = box_l-2*box_t1-1;
lid_w = box_w-2*box_t1-1;
lid_x = (box_l-lid_l)/2;
lid_y = (box_w-lid_w)/2;
lid_hole = 2.5;
lid_x1 = box_t+lid_hole/2;
lid_y1 = box_t+lid_hole/2;
lid_x2 = box_l-box_t-lid_hole/2;
lid_y2 = box_w-box_t-lid_hole/2;

insert_l = 40.0;
insert_w = 20.0;
insert_x = (box_l-insert_l)/2;
insert_y = 30.0; // (box_w-insert_w)/2;
insert_t1 = 1.75; // border legde around insert
insert_pitch = 25;
insert_h_h = 13;
insert_h_y = insert_y+insert_w/2;
insert_h3_x = insert_x+insert_l/2;
insert_h3_id = 5;    //M4 bolt hole
insert_h1_x = insert_h3_x-insert_pitch/2;
insert_h1_id = 6;
insert_h1_od = 9;
insert_h2_x = insert_h1_x+insert_pitch;
insert_h2_id = 6;
insert_h2_od = 9;

box_h1_x = insert_h3_x;
box_h1_y = (box_w-insert_h_y);
box_h1_id = insert_h3_id;

echo("mounting bolt #1 y-coord",box_h1_y);
echo("mounting bolt #1 x-coord",box_h1_x);
echo("mounting bolt #2 y-coord",insert_h_y);
echo("mounting bolt #2 x-coord",insert_h3_x);

psu_l = 45.0; // distance between mtg holes
psu_w = 17.5;
psu_x1 = box_l/2 - psu_l/2;
psu_x2 = psu_x1 + psu_l;
psu_y1 = 7;
psu_y2 = psu_y1+psu_w;
psu_boss_l = 4.5;
psu_boss_hole = 2.2;  // for #2 screw

control_l = 34.75; // distance between mtg holes
control_w = 45.5;
control_x1 = 10; // box_l/3 - control_l/2;
control_x2 = control_x1 + control_l;
control_y1 = box_w/2 - control_w/2;
control_y2 = control_y1+control_w;
control_boss_l = 4.5;
control_boss_hole = 1.5;  // for M1.7 screw

// 2x 9mm tube; 25mm pitch; 2x 6mm ID; M4
bushing_w = 15;
bushing_h = 3.5;  // thickness of bushing plate
bushing_x = 0;
bushing_y = box_w+bushing_w;    //safely away from box
bushing_h_pitch = 25;
bushing_h2_id = 4.75;   //M4 bolt hole
bushing_h13_id = 6.0;   //busing ID (2 wires)
bushing_h13_od = 9.0;   //bushing OD (3/8" drill)
bushing_l = bushing_h_pitch+bushing_h13_od*1.5;
bushing_h1_x = bushing_x+bushing_h13_od*0.75;
bushing_h3_x = bushing_h1_x+bushing_h_pitch;
bushing_h2_x = bushing_h1_x+bushing_h_pitch/2;
bushing_h_y = bushing_y+bushing_w*0.5;
bushing_h_h = 13;  // to work with 1/2" plate


/**************************************
 square mouting boss module & function 
***************************************/
module SquareBoss(side,height,hole_dia){
    translate([-side/2,-side/2,0])
    difference() {
        cube([side,side,height]);
        
        translate([side/2,side/2,height/3])
        cylinder(r=hole_dia/2,h=height/1.5);
    }
}

function SquareBossHoleCenter(side,height,hole_dia) = [side/2,side/2,0];


/**************************************
         wire bushing module 
***************************************/
module WireBushing(out_dia,height,hole_dia){
    difference() {
        cylinder(r=out_dia/2,h=height);
        cylinder(r=hole_dia/2,h=height);
    }
}

/**************************************
   box portion of the enclosure 
***************************************/
// already located at origin
/*
{
difference() {
    cube([box_l,box_w,box_h]);

    union() {
    // remove inner volume
    translate([box_t, box_t,box_t])
    cube([box_l-2*box_t,box_w-2*box_t,box_h]);
    
    // remove step for lid
    translate([box_t1,box_t1,box_h-lid_t])
    cube([box_l-2*box_t1,box_w-2*box_t1,lid_t]);
        
    // remove floor insert area
    translate([insert_x,insert_y,0])
    cube([insert_l,insert_w,box_t]);
        
    // remove insert step
    translate([insert_x-insert_t1,insert_y-insert_t1,box_t-insert_t1])
    cube([insert_l+2*insert_t1,insert_w+2*insert_t1,insert_t1]);
        
    //M4 mouting bolt hole
    translate([box_h1_x,box_h1_y,0])
    cylinder(r=box_h1_id/2,h=5);
        
    //ventilation slots
    for (i = [-2 : 2]){
        translate([box_l/2+i*4,2,box_h/2])
        cube(size=[1,box_w*2,box_h/3], center=true);
    }        
  }
}
// add bosses for DC-DC power supply
translate([psu_x1,psu_y1,0])
SquareBoss(psu_boss_l,10,psu_boss_hole);  
translate([psu_x2,psu_y1,0])
SquareBoss(psu_boss_l,10,psu_boss_hole);  
translate([psu_x1,psu_y2,0])
SquareBoss(psu_boss_l,10,psu_boss_hole);  
translate([psu_x2,psu_y2,0])
SquareBoss(psu_boss_l,10,psu_boss_hole);  

// add bosses for lid attachment
boss_l = 5;
boss_hole2 = 2.2;  // for #2 screw
translate([lid_x1,lid_y1,0])
SquareBoss(boss_l,box_h-lid_t,boss_hole2);  
translate([lid_x2,lid_y1,0])
SquareBoss(boss_l,box_h-lid_t,boss_hole2);  
translate([lid_x1,lid_y2,0])
SquareBoss(boss_l,box_h-lid_t,boss_hole2);  
translate([lid_x2,lid_y2,0])
SquareBoss(boss_l,box_h-lid_t,boss_hole2);  
}
/**/

/**************************************
    lid portion of the enclosure 
***************************************/
//uncomment next line to move lid to origin
translate([-lid_x,-lid_y,-(box_h-lid_t)])
//*
{
difference() {
   translate([lid_x,lid_y,box_h-lid_t])
   cube([lid_l,lid_w,lid_t]);
    
    union() {
        translate([lid_x1,lid_y1,box_h-2*lid_t])
        cylinder(r=lid_hole/2,h=10);
        translate([lid_x2,lid_y1,box_h-2*lid_t])
        cylinder(r=lid_hole/2,h=10);
        translate([lid_x1,lid_y2,box_h-2*lid_t])
        cylinder(r=lid_hole/2,h=10);
        translate([lid_x2,lid_y2,box_h-2*lid_t])
        cylinder(r=lid_hole/2,h=10);
    // hole for wiring from controller        
    translate([control_x1+control_l/2,control_y1+2*control_w/3,box_h-3])
    cylinder(r=4.5,h=10);
    //hole for fan/heat toggle switch
    translate([control_x2+12,control_y1+2*control_w/3,box_h-2*lid_t])
    cylinder(r=3.5,h=10);
    // etch some text under the controller
    translate([control_x1+control_l/2,control_y1+control_w/4,box_h-0.5])
    linear_extrude(3)
    text( "0v2", size= 9, ,halign = "center", valign = "center" );        
    }
}

// add bosses for reflow controller
translate([control_x1,control_y1,box_h])
SquareBoss(control_boss_l,6,control_boss_hole);  
translate([control_x2,control_y1,box_h])
SquareBoss(control_boss_l,6,control_boss_hole);  
translate([control_x1,control_y2,box_h])
SquareBoss(control_boss_l,6,control_boss_hole);  
translate([control_x2,control_y2,box_h])
SquareBoss(control_boss_l,6,control_boss_hole);  
}
/**/

/**************************************
   insert portion of the enclosure 
***************************************/
//uncomment two lines to move insert to origin
//translate([insert_x+insert_l+1,-insert_y+1,box_t])
//rotate([0,180,0])
/*
{
   difference(){
   union(){
   // add floor insert area
    translate([insert_x+0.5,insert_y+0.5,0])
    cube([insert_l-1,insert_w-1,box_t]);
        
    // add insert step
    translate([insert_x-insert_t1+0.5,insert_y-insert_t1+0.5,box_t-insert_t1])
    cube([insert_l+2*insert_t1-1,insert_w+2*insert_t1-1,insert_t1]);
   }
  
   union(){
    // holes for wires to pass through
    translate([insert_h1_x,insert_h_y,0])
    cylinder(r=insert_h1_id/2,h=5);

    translate([insert_h2_x,insert_h_y,0])
    cylinder(r=insert_h2_id/2,h=5);

    //M4 mouting bolt hole
    translate([insert_h3_x,insert_h_y,0])
    cylinder(r=insert_h3_id/2,h=5);
   }
 }
    
    // add insert bushings
    translate([insert_h1_x,insert_h_y,0])
    rotate([0,180,0])
    WireBushing(insert_h1_od,insert_h_h,insert_h1_id);
    
    translate([insert_h2_x,insert_h_y,0])
    rotate([0,180,0])
    WireBushing(insert_h2_od,insert_h_h,insert_h2_id);

}
/**/


/**************************************
  bushings to use outside of enclosure 
***************************************/
//uncomment next lines to move bushing to origin
//translate([-bushing_x,-bushing_y,0])
/*
{
   difference(){
   union(){
    // add bushing base square portion
    translate([bushing_x+bushing_w/2,bushing_y,0])
    cube([bushing_l-bushing_w,bushing_w,bushing_h]);
       
    // add rounded base ends
    translate([bushing_x+bushing_w/2,bushing_y+bushing_w/2,0])
    cylinder(r=bushing_w/2,h=bushing_h);
       
    translate([bushing_x+bushing_l-bushing_w/2,bushing_y+bushing_w/2,0])
    cylinder(r=bushing_w/2,h=bushing_h);
   }
   union(){
    // remove holes for wires to pass through
    translate([bushing_h1_x,bushing_h_y,-1])
    cylinder(r=bushing_h13_id/2,h=bushing_h+1);

    translate([bushing_h3_x,bushing_h_y,-1])
    cylinder(r=bushing_h13_id/2,h=bushing_h+1);

    //remove M4 mouting bolt hole
    translate([bushing_h2_x,bushing_h_y,-1])
    cylinder(r=insert_h2_id/2,h=5);
   }
 }
    
    // add insert bushings
    translate([bushing_h1_x,bushing_h_y,bushing_h])
    WireBushing(bushing_h13_od,bushing_h_h,bushing_h13_id);
    
    translate([bushing_h3_x,bushing_h_y,bushing_h])
    WireBushing(bushing_h13_od,bushing_h_h,bushing_h13_id);
}
/**/


