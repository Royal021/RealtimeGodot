shader_type spatial;
// I yoinked this from here
//https://www.youtube.com/watch?v=6-eIEFPcvrU
void vertex(){
	VERTEX.y += sin(TIME * 5.0)*0.2;
}

void fragment() {
	vec3 color;
	color.r =1.0;
	color.b = 0.0;
	color.g = 0.0;
	ALBEDO = color;
	ROUGHNESS = 0.1;
	METALLIC = 1.0;
	ALPHA=0.5;
	EMISSION = color;
}
