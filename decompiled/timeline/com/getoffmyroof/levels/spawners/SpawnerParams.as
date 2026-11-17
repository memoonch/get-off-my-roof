package com.getoffmyroof.levels.spawners
{
   import com.whatthefawk.utils.Params;
   
   public class SpawnerParams extends Params
   {
      
      public var spawnLimit:int = 100;
      
      public var lifeTime:int = 1;
      
      public var numToSpawn:int = 1;
      
      public var spawnRate:int = 1;
      
      public var entityType:String = "Entity";
      
      public function SpawnerParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

