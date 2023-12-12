//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec4 in_Colour;                    // (r,g,b,a)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float xoff;
uniform float yoff;

void main()
{
	vec2 uv=in_TextureCoord;
 
	uv.x=uv.x+xoff;
	uv.y=uv.y+yoff;
 
	vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
 
	v_vColour = in_Colour;
	v_vTexcoord = uv;
}