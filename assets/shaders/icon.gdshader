shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 input_color = texture(TEXTURE, UV);
	
	COLOR = input_color;
}
/* GRAY COLOR
uniform float brigtness_value : hint_range(0.0, 10.0) = 3.0;

void fragment() {	
	vec4 input_color = texture(TEXTURE, UV);
	float brightness = (input_color.r +input_color.g + input_color.b)/brigtness_value;
	vec4 gray_color = vec4(brightness,brightness,brightness, input_color.a);
	COLOR = gray_color;
}

*/


/* DISTORTION
uniform float distorted_value : hint_range(-5.0,5.0) = 0;
void fragment() {
	vec2 distorted_uv = UV;
	distorted_uv.x += distorted_uv.y * distorted_value;
	vec4 input_color = texture(TEXTURE, distorted_uv);
	COLOR = input_color;
}
*/

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
