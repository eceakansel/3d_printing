# Training Cone Holder

A parametric OpenSCAD model for a post that holds a training/agility cone upright. It has a wide flat base for stability, a vertical stem, and a top ring handle sized to pass through a 1.75" hole in the top of a training cone, so the cone stops on the ring instead of sliding down the post.

## Files

- `code cone.scad` — OpenSCAD source. All dimensions (base size, stem width, handle ring radius, rib supports, etc.) are parameterized at the top of the file for easy customization.
- `training_cone_holder.stl` — Exported mesh, ready to slice and print.

## Key parameters

- `base_diameter` / `base_thickness` — footprint and thickness of the base disk.
- `total_height` — overall height of the post.
- `stem_width` / `stem_thickness` — dimensions of the main vertical body.
- `handle_outer_r` / `handle_inner_r` — top ring sizing; outer radius is set to clear a 1.75" cone hole, inner radius forms the finger-grab opening.
- `rib_height`, `rib_length_side`, `rib_length_front`, `rib_thickness` — support gussets that reinforce the stem-to-base and stem-to-ring joints.

## Printing notes

The base and stem are designed to print without supports; the gussets reinforce the joint between the vertical stem and the base plate.
