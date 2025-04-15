#pragma header

uniform vec3 customColor;
uniform float mixValue;

vec4 applyEffects(vec4 color) {
    vec3 col = mix(color.rgb, customColor, mixValue);
    col = mix(col, vec3(0.0), 1.0 - color.a);
    return vec4(col, color.a);
}

void main() {
    vec4 col = texture2D(bitmap, openfl_TextureCoordv);
    gl_FragColor = applyEffects(col);
}