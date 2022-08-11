/// @description Initialize 3d-stuff

// Z axis
z = 0;

// Create entity class
entity_class = new Entity();
entity_class.setParentId(id);
entity_class.clearVertexBuffers();
entity_class.setModelData(SPRITE);
entity_class.setPosition(DEFAULT_CUBE_SIZE/2, DEFAULT_CUBE_SIZE/2);

// Entity settings
look_at = o_player;
plane_rot = 0;