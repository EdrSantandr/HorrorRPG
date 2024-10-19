shader_type canvas_item;

uniform float erosion_max_offset : hint_range(0.0, 1.0) = 0.1;
uniform vec4 albedo : source_color;
uniform bool is_full_image = false;
uniform sampler2D texture_albedo:
	source_color, 
	filter_linear_mipmap,
	repeat_disable;

uniform sampler2D erosion:
	source_color, 
	filter_linear_mipmap,
	repeat_disable;

void fragment() {
	vec2 base_uv = UV;
	
	vec4 albedo_tex = texture(texture_albedo, base_uv);
	albedo_tex *= COLOR;
	COLOR.rgb = albedo.rgb * albedo_tex.rgb;
	COLOR.a *= albedo.a * albedo_tex.a;
	vec4 erosion_tex = texture(erosion, base_uv);
	float erosion_min = 0.0;
	if (is_full_image == false)
	{
		 erosion_min= (sin(TIME * 9.0) + 1.0) * 0.5;
	}
	float erosion_max = erosion_min + erosion_max_offset;
	float erosion_val = smoothstep(erosion_min, erosion_max, erosion_tex.r);
	COLOR.a *= erosion_val;
}
