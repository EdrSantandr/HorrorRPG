shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;
uniform sampler2D noise_texture: filter_nearest, repeat_enable;
uniform vec4 added_color: source_color;
uniform vec2 speed = vec2(0.5,0.2);
uniform float wave_strength = 0.1;
uniform float alpha: hint_range(0.0, 1.0) = 0.5;
uniform float distortion = 0.01;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	/*
	vec4 pixel_color = texture(TEXTURE, UV);
	COLOR.rgb = mix(added_color.rgb,pixel_color.rgb,alpha);
	COLOR.a = alpha;
	*/
	//Start Shader
	vec4 pixel_color = texture(TEXTURE, UV);
	vec2 uv = UV + speed * TIME;
	vec2 noise = 2.0 * texture(noise_texture,uv).rg - vec2(1.0);
	COLOR = texture(TEXTURE, UV + noise * wave_strength);
	COLOR *= texture(screen_texture, SCREEN_UV + noise * distortion);
	COLOR.a = alpha;
	//end Shader
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
