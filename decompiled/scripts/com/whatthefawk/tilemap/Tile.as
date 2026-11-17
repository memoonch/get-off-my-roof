package com.whatthefawk.tilemap
{
   import flash.display.BitmapData;
   
   public class Tile
   {
      
      public static const TILE_LABEL_PREFIX:String = "tile";
      
      private var m_row:int;
      
      public var isDebug:Boolean;
      
      private var m_bitmapData:BitmapData;
      
      private var m_type:String;
      
      private var m_label:String;
      
      private var m_x:int;
      
      private var m_y:int;
      
      private var m_debugColor:uint;
      
      private var m_id:int;
      
      private var m_col:int;
      
      public var isVisible:Boolean;
      
      private var m_width:int;
      
      private var m_height:int;
      
      public var isWalkable:Boolean;
      
      public function Tile(param1:TileParams)
      {
         super();
         this.m_id = param1.id;
         this.m_row = param1.row;
         this.m_col = param1.col;
         this.m_width = param1.width;
         this.m_height = param1.height;
         this.m_x = this.m_col * this.m_width;
         this.m_y = this.m_row * this.m_height;
         this.m_type = param1.type;
         this.m_label = TILE_LABEL_PREFIX + "_" + this.m_col + "_" + this.m_row;
         this.m_debugColor = param1.debugColor;
         this.m_bitmapData = param1.bitmapData;
         this.isDebug = param1.isDebug;
         this.isVisible = param1.isVisible;
         this.isWalkable = param1.isWalkable;
      }
      
      public function get y() : int
      {
         return this.m_y;
      }
      
      public function get row() : int
      {
         return this.m_row;
      }
      
      public function get col() : int
      {
         return this.m_col;
      }
      
      public function get bitmapData() : BitmapData
      {
         return this.m_bitmapData;
      }
      
      public function get debugColor() : uint
      {
         return this.m_debugColor;
      }
      
      public function get id() : int
      {
         return this.m_id;
      }
      
      public function get x() : int
      {
         return this.m_x;
      }
      
      public function get label() : String
      {
         return this.m_label;
      }
   }
}

