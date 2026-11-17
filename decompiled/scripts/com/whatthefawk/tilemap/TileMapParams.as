package com.whatthefawk.tilemap
{
   import com.whatthefawk.entity.MovingEntityParams;
   
   public class TileMapParams extends MovingEntityParams
   {
      
      public var screenWidth:int;
      
      public var screenHeight:int;
      
      public var tileHeight:int;
      
      public var map:Array;
      
      public var tileWidth:int;
      
      public function TileMapParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

