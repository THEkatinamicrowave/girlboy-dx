#pragma header

uniform vec3 glowColor;
uniform vec2 maskPos;
uniform float mixValue;

void main() {
    // shift texture coordinates up by maskPos
    vec2 shiftedCoord = openfl_TextureCoordv - vec2(maskPos.x / openfl_TextureSize.x, maskPos.y / openfl_TextureSize.y);

    // sample the base color and mask color
    vec4 baseColor = texture2D(bitmap, openfl_TextureCoordv);
    vec4 maskColor = texture2D(bitmap, shiftedCoord);

    // color scale conversion (grayscale and then color)
    float grayscale = dot(baseColor.rgb, vec3(0.299, 0.587, 0.114)) * 0.5;
    vec4 colorScaledColor = vec4(glowColor * grayscale, baseColor.a);

    // mask logic
    float invertedAlpha = (1.0 - maskColor.a) * baseColor.a;
    vec4 shaderEffect = mix(baseColor, colorScaledColor, 0.75) + vec4(glowColor * invertedAlpha, 0.0);

    // mixxxxxxxxxxxxxxxxxxxxxxxvalue
    gl_FragColor = mix(baseColor, shaderEffect, mixValue);
}