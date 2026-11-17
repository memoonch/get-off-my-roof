package com.whatthefawk.entity
{
   import flash.events.Event;
   
   public class EntityEvent extends Event
   {
      
      public static const CHANGE_SCALE:String = "change_scale";
      
      public static const CHANGE_LAYER:String = "change_layer";
      
      public static const DISPOSE:String = "entity_dispose";
      
      public static const ADD_ENTITY:String = "add_entity";
      
      public static const REMOVE_ENTITY:String = "remove_entity";
      
      public static const RESIZE:String = "entity_resize";
      
      public var data:Object;
      
      public function EntityEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

