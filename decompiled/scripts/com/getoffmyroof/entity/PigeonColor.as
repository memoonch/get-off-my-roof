package com.getoffmyroof.entity
{
   import flash.geom.ColorTransform;
   
   public class PigeonColor
   {
      
      public var contrast:int;
      
      public var brightness:int;
      
      public var colorTransform:ColorTransform;
      
      public var id:String;
      
      public function PigeonColor(param1:String = "", param2:ColorTransform = null, param3:int = 0, param4:int = 0)
      {
         super();
         this.id = param1;
         this.colorTransform = param2;
         this.brightness = param3;
         this.contrast = param4;
      }
   }
}

