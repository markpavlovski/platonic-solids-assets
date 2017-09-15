float3  p[4] =  {
float3(-1,0,-0.7071068),
float3(1,0,-0.7071068),
float3(0,-1,0.7071068),
float3(0,1,0.7071068)};

fragColor = _EdgeColor*(
edge(0,1)+
edge(0,3)+
edge(0,2)+
edge(1,3)+
edge(1,2)+
edge(2,3)+
edge(2,3));
