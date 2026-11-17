package com.getoffmyroof.levels.droppers
{
   import com.whatthefawk.utils.Params;
   
   public class DropperParams extends Params
   {
      
      public var dropChance:int = 20;
      
      public var lifeTime:int = -1;
      
      public var timeBeforeDrop:int = -1;
      
      public var id:String = "Unnammed Dropper";
      
      public var dropRate:int = 200;
      
      public function DropperParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

