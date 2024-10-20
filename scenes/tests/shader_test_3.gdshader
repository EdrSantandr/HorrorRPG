shader_type canvas_item;

uniform vec4 added_color: source_color;
uniform float alpha: hint_range(0.0, 1.0) = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);
	COLOR.rgb = mix(added_color.rgb,pixel_color.rgb,alpha);
	COLOR.a = alpha;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
