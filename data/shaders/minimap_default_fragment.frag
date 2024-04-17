uniform float u_Time;
uniform float u_TimeElapsed;
uniform vec2 map_centerCoord;
uniform vec2 map_walkOffset;
uniform vec2 map_globalCoord;
uniform float map_zoom;
uniform sampler2D u_Tex0;
varying vec2 v_TexCoord;
void main()
{
    vec2 size = vec2(55.0,55.0);
    vec2 varPos = v_TexCoord;   
    vec4 col = texture2D(u_Tex0, v_TexCoord);
    vec2 dst =  map_globalCoord - map_centerCoord + varPos;
    dst /= size;
    if(sqrt(dot(dst, dst)) > 0.5){
    col.r =0.0;
    col.g =0.0;
    col.b =0.0;
    col.a =0.0;
    }
    else {
    col.a =0.75;
    }
    gl_FragColor = col;
}