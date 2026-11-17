package com.whatthefawk.entity
{
   import flash.events.Event;
   
   public class CollisionEvent extends Event
   {
      
      public static const HIT_WALL:String = "hit_wall";
      
      public static const HIT_ENTITY:String = "hit_entity";
      
      public static const HIT_TILE_MAP_TILE:String = "hit_tile_map_tile";
      
      public var data:Object;
      
      public function CollisionEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

