package com.getoffmyroof.entity
{
   import flash.events.Event;
   
   public class PlayerEvent extends Event
   {
      
      public static const ATTACK:String = "attack";
      
      public static const DIE:String = "die";
      
      public static const HIT:String = "hit";
      
      public static const IDLE:String = "idle";
      
      public static const JUMP:String = "jump";
      
      public static const LAND:String = "land";
      
      public static const USE_ITEM:String = "use_item";
      
      public static const USE_WETNAP:String = "use_wetnap";
      
      public static const WALK:String = "walk";
      
      public var data:Object;
      
      public function PlayerEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

