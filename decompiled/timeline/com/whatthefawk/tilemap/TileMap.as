package com.whatthefawk.tilemap
{
   import com.whatthefawk.entity.Entity;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class TileMap extends Entity
   {
      
      public static const TILE_BOTH:String = "both";
      
      public static const TILE_WALKABLE:String = "walkable";
      
      public static const TILE_UNWALKABLE:String = "unwalkable";
      
      public static const TILE_OUT_OF_BOUNDS_ID:int = -1;
      
      public var isVisible:Boolean = true;
      
      private var m_tileSet:Array;
      
      private var m_mapRows:int;
      
      private var m_tileHeight:int;
      
      private var m_screenRect:Rectangle;
      
      private var m_mapY:int;
      
      private var m_backgroundColor:uint = 13421772;
      
      private var m_mapX:int;
      
      private var m_useDebugTiles:Boolean = true;
      
      private var m_screenBitmapData:BitmapData;
      
      private var m_bufferStartTileY:int;
      
      private var m_mapCols:int;
      
      private var m_debugTileColors:Array = [7829367,10066329,11184810];
      
      private var m_bufferStartTileX:int;
      
      private var m_bufferTileRect:Rectangle;
      
      private var m_screenDestPoint:Point;
      
      private var m_bufferTileBitmapData:BitmapData;
      
      private var m_xml:XML;
      
      private var m_screenBitmap:Bitmap;
      
      private var m_bufferTileDestPoint:Point;
      
      private var m_walkableTiles:Array;
      
      private var m_mapHeight:int;
      
      private var m_screenHeight:int;
      
      private var m_unwalkableTiles:Array;
      
      private var m_mapWidth:int;
      
      private var m_tileIdMap:Array;
      
      private var m_bufferTilesX:int;
      
      private var m_tileWidth:int;
      
      private var m_screenWidth:int;
      
      private var m_bufferTilesY:int;
      
      private var m_bufferOffsetX:int;
      
      private var m_bufferOffsetY:int;
      
      private var m_bufferScreenBitmapData:BitmapData;
      
      private var m_tileMap:Array;
      
      public function TileMap(param1:TileMapParams)
      {
         super(param1);
         this.loadMap(param1);
      }
      
      public static function generateTileIdMap(param1:int, param2:int, param3:Array, param4:int = 0) : Array
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:Array = [];
         var _loc6_:int = param4;
         var _loc7_:int = 0;
         while(_loc7_ < param1)
         {
            _loc5_.push([]);
            _loc8_ = 0;
            while(_loc8_ < param2)
            {
               if(_loc7_ == 0 || _loc7_ == param1 - 1 || _loc8_ == 0 || _loc8_ == param2 - 1)
               {
                  _loc6_ = param4;
               }
               else
               {
                  _loc9_ = Math.random() * param3.length;
                  _loc6_ = int(param3[_loc9_]);
               }
               _loc5_[_loc7_][_loc8_] = _loc6_;
               _loc8_++;
            }
            _loc7_++;
         }
         return _loc5_;
      }
      
      public function getEdgeTiles(param1:Number, param2:Number, param3:int) : Object
      {
         var _loc4_:int = param2 - param3;
         var _loc5_:int = Math.ceil(param2 + param3 - 1);
         var _loc6_:int = param1 - param3;
         var _loc7_:int = Math.ceil(param1 + param3 - 1);
         var _loc8_:Tile = this.getTileAtPos(_loc6_,_loc4_);
         var _loc9_:Tile = this.getTileAtPos(_loc7_,_loc4_);
         var _loc10_:Tile = this.getTileAtPos(_loc6_,_loc5_);
         var _loc11_:Tile = this.getTileAtPos(_loc7_,_loc5_);
         var _loc12_:int = 0;
         if(_loc8_)
         {
            _loc12_ += _loc8_.isWalkable ? 0 : 1;
         }
         if(_loc9_)
         {
            _loc12_ += _loc9_.isWalkable ? 0 : 1;
         }
         if(_loc10_)
         {
            _loc12_ += _loc10_.isWalkable ? 0 : 1;
         }
         if(_loc11_)
         {
            _loc12_ += _loc11_.isWalkable ? 0 : 1;
         }
         return {
            "unwalkableEdgeCount":_loc12_,
            "topLeft":(_loc8_ ? _loc8_.isWalkable : false),
            "topRight":(_loc9_ ? _loc9_.isWalkable : false),
            "bottomLeft":(_loc10_ ? _loc10_.isWalkable : false),
            "bottomRight":(_loc11_ ? _loc11_.isWalkable : false)
         };
      }
      
      public function loadMap(param1:TileMapParams) : void
      {
         this.m_tileWidth = param1.tileWidth;
         this.m_tileHeight = param1.tileHeight;
         this.m_tileIdMap = param1.map;
         this.m_mapRows = this.m_tileIdMap.length;
         this.m_mapCols = this.m_tileIdMap[0].length;
         this.m_mapWidth = this.m_mapCols * this.m_tileWidth;
         this.m_mapHeight = this.m_mapRows * this.m_tileHeight;
         this.m_screenWidth = param1.screenWidth;
         this.m_screenHeight = param1.screenHeight;
         this.m_bufferTilesX = this.m_screenWidth / this.m_tileWidth + 1;
         this.m_bufferTilesY = this.m_screenHeight / this.m_tileHeight + 1;
         this.m_screenBitmapData = new BitmapData(this.m_screenWidth,this.m_screenHeight,false,this.m_backgroundColor);
         this.m_screenBitmap = new Bitmap(this.m_screenBitmapData);
         this.m_screenRect = new Rectangle(0,0,this.m_screenWidth,this.m_screenHeight);
         this.m_screenDestPoint = new Point();
         var _loc2_:int = this.m_screenWidth + this.m_tileWidth;
         var _loc3_:int = this.m_screenHeight + this.m_tileHeight;
         this.m_bufferScreenBitmapData = new BitmapData(_loc2_,_loc3_);
         this.m_bufferTileBitmapData = new BitmapData(this.m_tileWidth,this.m_tileHeight,false);
         this.m_bufferTileDestPoint = new Point();
         this.tileIdMapToTileMap(this.m_tileIdMap);
      }
      
      public function loadMapXML(param1:XML) : void
      {
      }
      
      public function getRandomTile(param1:String = "walkable") : Tile
      {
         return this.m_walkableTiles[int(Math.random() * this.m_walkableTiles.length)];
      }
      
      public function getAdjacentTiles(param1:*, param2:*) : Object
      {
         return {
            "top":this.getTileAt(param1 - 1,param2),
            "left":this.getTileAt(param1,param2 - 1),
            "right":this.getTileAt(param1,param2 + 1),
            "bottom":this.getTileAt(param1 + 1,param2),
            "topLeft":this.getTileAt(param1 - 1,param2 - 1),
            "topRight":this.getTileAt(param1 - 1,param2 + 1),
            "bottomLeft":this.getTileAt(param1 + 1,param2 - 1),
            "bottomRight":this.getTileAt(param1 + 1,param2 + 1)
         };
      }
      
      public function getTileIdAtPos(param1:int, param2:int) : int
      {
         if(param1 >= this.m_mapWidth || param1 < 0 || param2 >= this.m_mapHeight || param2 < 0)
         {
            return TileMap.TILE_OUT_OF_BOUNDS_ID;
         }
         var _loc3_:int = param1 / this.m_tileWidth;
         var _loc4_:int = param2 / this.m_tileHeight;
         return this.m_tileIdMap[_loc4_][_loc3_];
      }
      
      public function get screenHeight() : int
      {
         return this.m_screenHeight;
      }
      
      public function get tileHeight() : int
      {
         return this.m_tileHeight;
      }
      
      public function checkEdges(param1:Number, param2:Number, param3:int) : Boolean
      {
         var _loc4_:int = param2 - param3;
         var _loc5_:int = Math.ceil(param2 + param3 - 1);
         var _loc6_:int = param1 - param3;
         var _loc7_:int = Math.ceil(param1 + param3 - 1);
         var _loc8_:Tile = this.getTileAtPos(_loc6_,_loc4_);
         var _loc9_:Tile = this.getTileAtPos(_loc7_,_loc4_);
         var _loc10_:Tile = this.getTileAtPos(_loc6_,_loc5_);
         var _loc11_:Tile = this.getTileAtPos(_loc7_,_loc5_);
         if(!_loc8_ || !_loc9_ || !_loc10_ || !_loc11_)
         {
            return false;
         }
         return _loc8_.isWalkable && _loc9_.isWalkable && _loc10_.isWalkable && _loc11_.isWalkable;
      }
      
      public function get tileWidth() : int
      {
         return this.m_tileWidth;
      }
      
      public function get screenWidth() : int
      {
         return this.m_screenWidth;
      }
      
      public function drawAt(param1:int, param2:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Tile = null;
         this.m_screenBitmapData.lock();
         this.m_bufferScreenBitmapData.lock();
         this.m_screenBitmapData.fillRect(this.m_bufferScreenBitmapData.rect,this.m_backgroundColor);
         this.m_bufferScreenBitmapData.fillRect(this.m_bufferScreenBitmapData.rect,this.m_backgroundColor);
         this.m_bufferStartTileX = param1 / this.m_tileWidth;
         this.m_bufferStartTileY = param2 / this.m_tileHeight;
         this.m_bufferOffsetX = param1 - this.m_bufferStartTileX * this.m_tileWidth;
         this.m_bufferOffsetY = param2 - this.m_bufferStartTileY * this.m_tileHeight;
         var _loc3_:int = Math.min(this.m_mapRows,this.m_bufferStartTileY + this.m_bufferTilesY + 1);
         var _loc4_:int = Math.min(this.m_mapCols,this.m_bufferStartTileX + this.m_bufferTilesX + 1);
         var _loc5_:int = this.m_bufferStartTileY;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = this.m_bufferStartTileX;
            while(_loc6_ < _loc4_)
            {
               _loc7_ = this.m_tileMap[_loc5_][_loc6_];
               if(this.m_useDebugTiles)
               {
                  this.m_bufferTileBitmapData.floodFill(0,0,_loc7_.debugColor);
               }
               else
               {
                  this.m_bufferTileBitmapData = _loc7_.bitmapData;
               }
               this.m_bufferTileDestPoint.x = (_loc6_ - this.m_bufferStartTileX) * this.m_tileWidth;
               this.m_bufferTileDestPoint.y = (_loc5_ - this.m_bufferStartTileY) * this.m_tileHeight;
               this.m_bufferScreenBitmapData.copyPixels(this.m_bufferTileBitmapData,this.m_bufferTileBitmapData.rect,this.m_bufferTileDestPoint);
               _loc6_++;
            }
            _loc5_++;
         }
         this.m_screenRect.x = this.m_bufferOffsetX;
         this.m_screenRect.y = this.m_bufferOffsetY;
         this.m_screenBitmapData.copyPixels(this.m_bufferScreenBitmapData,this.m_screenRect,this.m_screenDestPoint);
         this.m_screenBitmapData.unlock();
         this.m_bufferScreenBitmapData.unlock();
      }
      
      override public function update(param1:int) : void
      {
      }
      
      public function get screenBitmap() : Bitmap
      {
         return this.m_screenBitmap;
      }
      
      public function getTileAtPos(param1:int, param2:int) : Tile
      {
         if(param1 >= this.m_mapWidth || param1 < 0 || param2 >= this.m_mapHeight || param2 < 0)
         {
            return null;
         }
         var _loc3_:int = param1 / this.m_tileWidth;
         var _loc4_:int = param2 / this.m_tileHeight;
         return this.m_tileMap[_loc4_][_loc3_];
      }
      
      private function tileIdMapToTileMap(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TileParams = null;
         var _loc6_:Tile = null;
         this.m_tileMap = [];
         this.m_walkableTiles = [];
         this.m_unwalkableTiles = [];
         var _loc2_:int = 0;
         while(_loc2_ < this.m_mapRows)
         {
            this.m_tileMap.push([]);
            _loc3_ = 0;
            while(_loc3_ < this.m_mapCols)
            {
               _loc4_ = int(this.m_tileIdMap[_loc2_][_loc3_]);
               _loc5_ = new TileParams({
                  "id":_loc4_,
                  "row":_loc2_,
                  "col":_loc3_,
                  "width":this.m_tileWidth,
                  "height":this.m_tileHeight,
                  "debugColor":this.m_debugTileColors[_loc4_],
                  "isDebug":true,
                  "isWalkable":(_loc4_ == 0 ? false : true)
               });
               _loc6_ = new Tile(_loc5_);
               if(_loc6_.isWalkable)
               {
                  this.m_walkableTiles.push(_loc6_);
               }
               else
               {
                  this.m_unwalkableTiles.push(_loc6_);
               }
               this.m_tileMap[_loc2_][_loc3_] = _loc6_;
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function getTileIdAt(param1:int, param2:int) : int
      {
         if(param1 >= this.m_mapRows || param1 < 0 || param2 >= this.m_mapCols || param2 < 0)
         {
            return TileMap.TILE_OUT_OF_BOUNDS_ID;
         }
         return this.m_tileIdMap[param1][param2];
      }
      
      public function getTileAt(param1:int, param2:int) : Tile
      {
         if(param1 >= this.m_mapRows || param1 < 0 || param2 >= this.m_mapCols || param2 < 0)
         {
            return null;
         }
         return this.m_tileMap[param1][param2];
      }
   }
}

