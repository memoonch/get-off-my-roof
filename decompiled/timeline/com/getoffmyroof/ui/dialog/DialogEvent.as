package com.getoffmyroof.ui.dialog
{
   import flash.events.Event;
   
   public class DialogEvent extends Event
   {
      
      public static const CLICKED:String = "clicked";
      
      public var data:Object;
      
      public function DialogEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

