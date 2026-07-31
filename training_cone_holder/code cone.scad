// ==========================================
// PARAMETRIC TARGET POST MODEL
// ==========================================

$fn = 100; // Smooth circles

// --- Dimensions (in mm) ---
base_diameter  = 100;   // ~3.15 inches base
base_thickness = 3;    // Base disk height
total_height   = 220;  // Overall height from bottom to top

stem_width     = 35;   // Width of main vertical body
stem_thickness = 4;    // Thickness of main body wall
inset_depth    = 1.2;  // Inset recess detail depth
border_width   = 3;    // Outer border frame around inset

// --- Updated Top Ring Dimensions (Fits THROUGH 1.75" Cone Hole) ---
handle_outer_r = 21;   // ~1.65" Outer Diameter to fit through 1.75" hole with clearance
handle_inner_r = 17;   // Inner finger-grab opening radius

// --- Support Gussets ---
rib_height     = 12;   
rib_length_side = 10;  
rib_length_front = 15; 
rib_thickness  = 2;    

// ==========================================
// GEOMETRY GENERATION
// ==========================================

module main_post() {
    union() {
        // 1. Circular Base
        cylinder(h = base_thickness, d = base_diameter);

        // 2. Main Vertical Stem & Handle Assembly
        difference() {
            union() {
                // Vertical Rectangular Column
                translate([-stem_width/2, -stem_thickness/2, base_thickness])
                    cube([stem_width, stem_thickness, total_height - base_thickness - handle_outer_r]);

                // Top Ring Outer
                translate([0, 0, total_height - handle_outer_r])
                    rotate([90, 0, 0])
                    cylinder(h = stem_thickness, r = handle_outer_r, center = true);
            }

            // Top Ring Inner Hole
            translate([0, 0, total_height - handle_outer_r])
                rotate([90, 0, 0])
                cylinder(h = stem_thickness + 2, r = handle_inner_r, center = true);

            // Front & Back Inset Recesses
            for (side = [-1, 1]) {
                translate([
                    -(stem_width/2 - border_width), 
                    side * (stem_thickness/2 - inset_depth/2 + 0.01), 
                    base_thickness + rib_height + 2
                ])
                cube([
                    stem_width - (border_width * 2), 
                    inset_depth, 
                    total_height - base_thickness - (handle_outer_r * 2) - rib_height - 2
                ]);
            }
        }

        // 3. Small Support Gussets
        // Side Ribs (X-axis)
        for (m = [0, 1]) {
            mirror([m, 0, 0])
            translate([stem_width/2, -rib_thickness/2, base_thickness])
            rotate([90, 0, 90])
            linear_extrude(height = rib_length_side)
                polygon(points = [[0,0], [rib_height, 0], [0, rib_length_side]]);
        }

        // Front / Back Center Ribs (Y-axis)
        for (m = [0, 1]) {
            mirror([0, m, 0])
            translate([-rib_thickness/2, stem_thickness/2, base_thickness])
            rotate([90, 0, 0])
            rotate([0, 90, 0])
            linear_extrude(height = rib_thickness)
                polygon(points = [[0,0], [rib_length_front, 0], [0, rib_height]]);
        }
    }
}

// Render Model
main_post();