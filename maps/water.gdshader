shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_enable, filter_nearest;

group_uniforms water;
uniform sampler2D waterNoise : repeat_enable, filter_nearest;
uniform sampler2D waterDistortionNoise : repeat_enable, filter_nearest;
uniform vec4 waterColor : source_color = vec4(0.117, 0.27, 0.58, 1);
uniform float colorCorection : hint_range(0.0, 1.0, 0.01) = 0.35;

group_uniforms water_waves;
uniform float distortionForce : hint_range(0.00, .1, 0.001) = .01;
uniform float WDBrightness : hint_range(0, 3, 0.05) = 1.5;
uniform float WDFreq : hint_range(0.2, .9, 0.05) = 0.6;
uniform float WDSize : hint_range(0.6, 1.2, 0.05) = .9;
uniform float WDSpeed : hint_range(1, 20, 0.05) = 4;
uniform vec2 tiling = vec2(10);
uniform vec2 offSetSpeed = vec2(.1);

group_uniforms BG_distortion;
uniform float backGroundDirX : hint_range(-0.1, 0.1) = 0.01;
uniform float backGroundDirY : hint_range(-0.1, 0.1) = 0.01;

void fragment() {
	vec4 color = vec4(waterColor.rgb , 1);

	// Gerakan noise tidak konstan, pakai sin/cos untuk variasi arah
	vec2 dynamicOffset = vec2(
		sin(TIME * 0.7 + UV.y * 5.0),
		cos(TIME * 1.1 + UV.x * 5.0)
	) * 0.3;

	vec2 noiseUV = UV * tiling + dynamicOffset;
	float noiseValue = texture(waterDistortionNoise, noiseUV).r;

	vec2 waterUV = UV * tiling;
	waterUV.x += sin(TIME * 1.0 + UV.y * 3.0) * 0.02;
	waterUV.y += cos(TIME * 1.3 + UV.x * 3.0) * 0.02;
	waterUV = waterUV + noiseValue * distortionForce * WDSpeed;

	vec4 noiseColor = texture(waterNoise, waterUV);
	float intensity = smoothstep(WDFreq, WDSize, noiseColor.r);
	color.rgb += intensity * vec3(WDBrightness);

	vec2 backGroundUV = SCREEN_UV;
	backGroundUV.x += noiseValue * backGroundDirX;
	backGroundUV.y += noiseValue * backGroundDirY;

	color = mix(texture(SCREEN_TEXTURE, backGroundUV), color, 0.2);
	COLOR = mix(color, waterColor, colorCorection);
}
