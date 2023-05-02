sqr = sqrt(2);

module mount_hole() {
    cube([1,4,2], center=true);
}

// mount_hole();

module keycap() {
  rotate([0,0,45]) cylinder(10,18/2*sqr,14/2*sqr,$fn=4);
}

// keycap();

module switch() {
  translate([0,0,2]) cube([14,14,4], center=true);
  translate([0,0,4.5]) cube([16,16,1], center=true);
  translate([0,0,7.5]) cube([14,14,5], center=true);
}

// switch();

module key() {
    switch();
    color("red") translate([7.5,0,2]) mount_hole();
    color("red") translate([-7.5,0,2]) mount_hole();
    color("red", 0.5) translate([0,0,-4]) cube([14,14,8], center=true); // wire hole
    color("cyan", 0.5) translate([0,0,13]) cube([19,19,18], center=true); // keywell hole
    translate([0,0,10]) keycap();
}

// key();

dx = 5;
dz = 5.95;
angle = 29;

module duo() {
    translate([-18-dx, 0, dz]) rotate([0, angle, 0]) key();
    key();
    translate([-12.128,0,0.55]) rotate([0,angle/2,0]) color("cyan", 0.5) translate([0,0,13]) cube([3.35,19,18], center=true); // keywell hole
}

// duo();

module trio() {
    translate([12.128,0,0.55]) rotate([0,-angle/2,0]) color("cyan", 0.5) translate([0,0,13]) cube([3.35,19,18], center=true); // keywell hole
    translate([-18-dx, 0, dz]) rotate([0, angle, 0]) key();
    key();
    translate([18+dx, 0, dz]) rotate([0, -angle, 0]) key();
    translate([-12.128,0,0.55]) rotate([0,angle/2,0]) color("cyan", 0.5) translate([0,0,13]) cube([3.35,19,18], center=true); // keywell hole
}

// trio();

module quatro() {
    translate([-11.88, 0, 0]) rotate([0, angle/2, 0]) duo();
    translate([11.88, 0, 0]) rotate([0, -angle/2, 0]) rotate([0,0,180]) duo();
    color("cyan", 0.5) translate([0,0,13-2.5]) cube([3.35,19,18], center=true); // keywell hole
}

// quatro();

module cluster() {
    translate([0,0.4,-0.2]) rotate([2,0,0]) {
        translate([0,-18-1.5,0.6]) rotate([-4,0,0]) trio();
        trio();
    }
    translate([3,0,-4.5]) translate([0, 18+0.5, 0]) rotate([0,2.5,0]) quatro();
    translate([0,-0.2,0.8]) rotate([-2,0,0]) {
        translate([10,0,-4]) translate([0, 2*(18+0.5), 0]) rotate([0,-5,0]) quatro();
        translate([0,-0.4,1.6]) rotate([-2,0,0]) {
            translate([18,0,-2]) translate([0, 3*(18+0.5), 0]) rotate([0,-11,0]) trio();
            translate([18,1,-2+0.6]) translate([0, 4*(18+0.5), 0]) rotate([4,-11,0]) duo();
        }
    }
}

rotate([0,0,-90]) cluster();