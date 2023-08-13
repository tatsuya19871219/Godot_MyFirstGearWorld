# This is the formatting script for PackedVector2Array data (in mesh or shape) in GodotEngine
# The expected input is the vertex list of polygon generated from  
# [Path to Polygon Converter](https://betravis.github.io/shape-tools/path-to-polygon/) for a given SVG file.
# 
# USAGE:
# $ ./format_as_godot_polygon.sh "polygon(50.000 0.000, 64.695 29.775, 97.553 34.549, 73.776 57.725, 79.389 90.451, 50.000 75.000, 20.611 90.451, 26.224 57.725, 2.447 34.549, 35.305 29.775)"
# polygon = PackedVector2Array(50.00, 0.000, 64.695, 29.775, 97.553, 34.549, 73.776, 57.725, 79.38, 90.451, 50.00, 75.000, 20.611, 90.451, 26.224, 57.725, 2.447, 34.549, 35.305, 29.775)

echo $1 | sed s/[0..9]\ /,\ /g | sed s/,//g | sed s/\ /,\ /g | sed s/polygon/polygon\ =\ PackedVector2Array/
