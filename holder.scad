print = 0;

fn = 128;

module rcube(x,y,z,r){
    hull(){
        translate([r,r,0]) cylinder(h=z,r1=r,r2=r,$fn=fn);
        translate([x-r,r,0]) cylinder(h=z,r1=r,r2=r,$fn=fn);
        translate([r,y-r,0]) cylinder(h=z,r1=r,r2=r,$fn=fn);
        translate([x-r,y-r,0]) cylinder(h=z,r1=r,r2=r,$fn=fn);
    };
};

span = 126;
roller = 107;
hole = 50;
thickness = 7;
upper_height = 35 + thickness;
wall_height = 50;
lower_height = 10 + thickness;
hold_w = 17;
gap = 0.25;
e = 0.00000001;
r = 5;

module holder()
rotate([print*90,0,0])
translate([-thickness,0,-lower_height+50*print]) {
    hull(){
        translate([thickness*2+hold_w,0,lower_height+upper_height]) cube([e,thickness,e]);
        translate([span-hold_w,0,lower_height+upper_height]) cube([e,thickness,e]);
        translate([(span+thickness*2)/2,0,lower_height+upper_height+wall_height]) rotate([-90,0,0]) cylinder(h=thickness,r1=r,r2=r,$fn=fn);
    }
    difference(){
        rotate([90,0,0]){
            translate([0,0,-thickness]){
                rcube(span+thickness*2, upper_height+lower_height, thickness, r);
            }
        }
        translate([thickness-gap,0,0]){
            cube([span+gap*2, thickness, lower_height]);
        }
        translate([thickness+thickness,0,lower_height+upper_height]){
            hull(){
                cube([e,thickness, e]);
                translate([0,0,-hold_w]) cube([e,thickness, e]);
                translate([hold_w/2,0,-hold_w-hold_w/2*tan(30)]) cube([e,thickness, e]);
                translate([hold_w,0,-hold_w]) cube([e,thickness, e]);
                translate([hold_w,0,0]) cube([e,thickness, e]);
            }
        }
        translate([span-hold_w,0,lower_height+upper_height]){
            hull(){
                cube([e,thickness, e]);
                translate([0,0,-hold_w]) cube([e,thickness, e]);
                translate([hold_w/2,0,-hold_w-hold_w/2*tan(30)]) cube([e,thickness, e]);
                translate([hold_w,0,-hold_w]) cube([e,thickness, e]);
                translate([hold_w,0,0]) cube([e,thickness, e]);
            }
        }
    }
}

module plate(){
    translate([-thickness,-thickness,0])
    difference(){
        rcube(span+thickness*2, roller+thickness*4, thickness, r);
        translate([0, thickness-gap, 0]) cube([thickness+gap,thickness+gap*2,thickness]);
        translate([0, roller+thickness*2-gap, 0]) cube([thickness+gap,thickness+gap*2,thickness]);
        translate([span+thickness, thickness-gap, 0]) cube([thickness+gap,thickness+gap*2,thickness]);
        translate([span+thickness, roller+thickness*2-gap, 0]) cube([thickness+gap,thickness+gap*2,thickness]);
        translate([(span+thickness*2)/2,(roller+thickness*4)/2,0]) cylinder(h=thickness,r1=hole,r2=hole,$fn=fn);
    }
}

holder();
plate();