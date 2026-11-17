package com.getoffmyroof.levels.spawners
{
   import flash.events.Event;
   
   public class SpawnGroupEvent extends Event
   {
      
      public static const ENTITY_SPAWN:String = "entity_spawn";
      
      public static const ENTITY_DEAD:String = "entity_dead";
      
      public static const GROUP_SPAWN:String = "group_spawn";
      
      public static const GROUP_DEAD:String = "group_dead";
      
      public static const COMPLETE:String = "complete";
      
      public var data:Object;
      
      public function SpawnGroupEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

