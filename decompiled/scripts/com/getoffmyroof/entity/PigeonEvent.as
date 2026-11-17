package com.getoffmyroof.entity
{
   import flash.events.Event;
   
   public class PigeonEvent extends Event
   {
      
      public static const ATTACK:String = "attack";
      
      public static const DIE:String = "die";
      
      public static const FLY:String = "fly";
      
      public static const HIT:String = "hit";
      
      public static const JUMP:String = "jump";
      
      public static const LAND:String = "land";
      
      public static const LANDING:String = "landing";
      
      public static const WET:String = "wet";
      
      public static const DRY:String = "dry";
      
      public var data:Object;
      
      public function PigeonEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

