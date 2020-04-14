#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
  
// http://stackoverflow.com/questions/15095909/from-rgb-to-hsv-in-opengl-glsl
vec3 hsv2rgb(vec3 c){
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main(void) {
	vec2 uv = gl_FragCoord.xy / u_resolution.xy;
	vec3 hsv = vec3(uv.x*sin(u_time), 1.0, 1.0-uv.y*sin(u_time));
	vec3 rgb = hsv2rgb(hsv);
	gl_FragColor = vec4(rgb, 1.0);
}