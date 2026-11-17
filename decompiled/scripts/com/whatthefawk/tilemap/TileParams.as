package com.whatthefawk.tilemap
{
   import com.whatthefawk.utils.Params;
   import flash.display.BitmapData;
   
   public class TileParams extends Params
   {
      
      public var col:int;
      
      public var label:String;
      
      public var width:int;
      
      public var isDebug:Boolean = false;
      
      public var debugColor:uint = 11184810;
      
      public var row:int;
      
      public var id:int;
      
      public var height:int;
      
      public var isWalkable:Boolean = true;
      
      public var isVisible:Boolean = true;
      
      public var bitmapData:BitmapData;
      
      public var type:String = "default_tile";
      
      public function TileParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

