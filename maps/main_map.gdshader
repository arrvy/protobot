shader_type canvas_item;

uniform vec2 player_pos = vec2(0.0, 0.0); // dikirim dari GDScript
uniform float fade_radius = 160.0;
uniform float fade_softness = 20.0;

void fragment() {
    vec2 world_pos = SCREEN_UV * vec2(1024.0, 600.0); // <--- coba tweak nilai ini
    float dist = distance(world_pos, player_pos + vec2(500, 320.0)); // <--- dan offset ini

    float alpha = clamp((dist - fade_radius) / fade_softness, 0.0, 1.0);
    vec4 tex_color = texture(TEXTURE, UV);
    COLOR = vec4(tex_color.rgb, tex_color.a * alpha);
}



