// Data Set for Fisher Delta printer - 28 May 2015  revision according designer data
Delta_name = "Fisher Delta by RepRapPro";
housing_base=0; // no housing
housing_opening = 200; // defines height of the opening in the housing

beam_int_radius = 123; // radius on rod axis plane - used as reference radius
hbase = 47; // height of the base structure 
htop  = 18;  // height of top structure
htotal= 426; // total height, including base and top structure

bed_level = 8; 
extrusion = 8; // Rod diameter
rod_space = 45; // set two rods instead of one extrusion

car_hor_offset= 19; 
hcar = 15; 
car_vert_dist = 7.5;
top_clearance = 8.5; // clearance between top of the carriage and top structure

eff_hor_offset= 23; 
eff_vert_dist = 4; 
arm_space= 45; // space between the arms

delta_angle = 60; 
arm_length = 160; // supersedes delta_angle  
mini_angle = 12.5; 
hotend_vert_dist = 17.5;
dia_ball= 6;
dia_arm = 5;
railthk =0; 
railwidth =0; 
rail_base=0;
frame_corner_radius=11; 
frame_face_radius= 0;
corner_offset=0;

belt_dist = 3;
spool_diam = 0;  

$bedDia=170; // force the bed diameter

struct_color = "green";
moving_color = "green";
bed_color = "silver";

$vpd=camPos?1500:$vpd;   // camera distance: work only if set outside a module
$vpr=camPos?[80,0,42]:$vpr;   // camera rotation
$vpt=camPos?[190,-67,290]:$vpt; //camera translation  */

//*
$bCar=true; // allow the program to use below module instead of standard carriage
// $ variable does not give warning when not defined
module buildCar(ht=16) { // modify to allow excentrate articulation (lowered) ??
  dcar = 15+8; // 19 is bearing diam
  tsl (0,0,-car_vert_dist) {
    hull () 
      dmirrorx()
        cylz (-dcar, ht,rod_space/2); // -x to decrease side size
    cubez (rod_space-extrusion,20,-dia_ball*1.5,0,10-car_hor_offset,dia_ball*1.5/2);
    cylx (-dia_ball*1.5,rod_space-extrusion,0,-car_hor_offset); 
  }
} //*/

$bSide = true; // setup the below side panel *in addition* to frame
module buildSides() {
  platethk = 3;
  platewd  = 190;
  platedist = 89; // internal face dist to centre
  diams  = 26;
  openht = htotal-hbase-bed_level-htop-diams;
  
  color ("black")
  //color([0.5,0.5,0.5,0.5]) 
  rot120 (-30)
    difference() {
      cubez (platethk, platewd, htotal,-platedist-platethk/2); 
      dmirrory()
        tsl (0,0,openht/2+hbase+bed_level+diams/2)
          hull() 
            dmirrorz() cylx (-diams,100,-platedist,100,openht/2);
      tsl (0,0,housing_opening/2+hbase+bed_level+diams/2-0.1)
        hull() 
          dmirrory() dmirrorz()
            cylx (-diams,100,-platedist,68-diams/2,housing_opening/2);
    }
}

//cylz (272,25,0,0,0,150); // checking enveloping cylinder