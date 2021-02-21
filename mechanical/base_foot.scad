/*
    Hotplate Reflow Support Feet
    T. LeMense February 12, 2021
   
      
*/

fc_edge = 25;
fc_height = 35;
fc_flange = 5;
m4_head_dia = 7.5;
m4_body_dia = 4.5;
m4_head_h = 2.5;

$fa = 1;
$fs = 0.4;

difference() {
   {
      cube([fc_edge, fc_edge, fc_height]);
   }
   {
      translate([fc_edge/2,fc_edge/2,fc_height/2+fc_flange])
      cylinder(d=m4_head_dia*1.5,h=fc_height,center=true);
       
      translate([fc_edge*1/2,fc_edge/2,fc_flange-m4_head_h/2])
      cylinder(d1=m4_body_dia, d2=m4_head_dia,h=m4_head_h, center=true);
      translate([fc_edge*1/2,fc_edge/2,0])
      cylinder(d=m4_body_dia,h=fc_flange,center=true); 

   }
}

translate([fc_edge,0,0])
difference() {
   {
      cube([fc_edge, fc_edge, fc_height]);
   }
   {
      // sloped edge 
      translate([0,0,fc_height])
      rotate([0,50,0])
      cube([fc_edge*2, fc_edge, fc_height]);
       
      // remove cavity in between slope walls 
      translate([fc_flange,fc_flange,fc_flange]) 
      cube([fc_edge, fc_edge-2*fc_flange, fc_height]);
       
      // remove M4 flathead screw recess 
      translate([fc_edge*1/2,fc_edge/2,fc_flange-m4_head_h/2])
      cylinder(d1=m4_body_dia, d2=m4_head_dia,h=m4_head_h, center=true);
      translate([fc_edge*1/2,fc_edge/2,0])
      cylinder(d=m4_body_dia,h=fc_flange,center=true); 
       
   }  
}

translate([fc_edge,fc_edge,0])
rotate([0,0,90])
difference() {
   {
      cube([fc_edge, fc_edge, fc_height]);
   }
   {
      // sloped edge 
      translate([0,0,fc_height])
      rotate([0,50,0])
      cube([fc_edge*2, fc_edge, fc_height]);
       
      // remove cavity in between slope walls 
      translate([fc_flange,fc_flange,fc_flange]) 
      cube([fc_edge, fc_edge-2*fc_flange, fc_height]);
       
      translate([fc_edge*1/2,fc_edge/2,fc_flange-m4_head_h/2])
      cylinder(d1=m4_body_dia, d2=m4_head_dia,h=m4_head_h, center=true);
      translate([fc_edge*1/2,fc_edge/2,0])
      cylinder(d=m4_body_dia,h=fc_flange,center=true); 
   }  
}
