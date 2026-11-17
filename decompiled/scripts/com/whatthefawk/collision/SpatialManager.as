package com.whatthefawk.collision
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.math.Vector2D;
   import flash.utils.Dictionary;
   
   public class SpatialManager
   {
      
      protected var _cellSize:int;
      
      protected var _height:int;
      
      protected var _width:int;
      
      protected var _cols:int;
      
      protected var _rows:int;
      
      protected var _cellMap:Dictionary;
      
      public function SpatialManager(param1:int, param2:int, param3:int)
      {
         super();
         this._width = param1;
         this._height = param2;
         this._cellSize = param3;
         this._cols = param1 / param3;
         this._rows = param2 / param3;
         this._cellMap = new Dictionary();
         this.resetCells();
      }
      
      private function addCell(param1:int, param2:int, param3:Array) : void
      {
         var _loc4_:int = int(param1 / this._cellSize) + int(param2 / this._cellSize) * this._cols;
         if(param3.indexOf(_loc4_) == -1 && _loc4_ >= 0)
         {
            param3.push(_loc4_);
         }
      }
      
      public function resetCells() : void
      {
         var _loc1_:int = this._cols * this._rows;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._cellMap[_loc2_] = [];
            _loc2_++;
         }
      }
      
      public function registerEntity(param1:Entity) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc2_:Array = this.getEntityCellIDs(param1);
         for each(_loc4_ in _loc2_)
         {
            if(this._cellMap[_loc4_])
            {
               _loc3_ = this._cellMap[_loc4_];
               _loc3_[_loc3_.length] = param1;
            }
         }
      }
      
      public function getNeighboors(param1:Entity) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:Entity = null;
         var _loc2_:Array = [];
         var _loc3_:Array = this.getEntityCellIDs(param1);
         for each(_loc4_ in _loc3_)
         {
            for each(_loc5_ in this._cellMap[_loc4_])
            {
               _loc2_.push(_loc5_);
            }
         }
         return _loc2_;
      }
      
      public function get cellMap() : Dictionary
      {
         return this._cellMap;
      }
      
      public function getEntityCellIDs(param1:Entity) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:Vector2D = null;
         var _loc2_:Array = [];
         if(!param1.useHitAreaForCollisions)
         {
            _loc4_ = param1.currentPos;
            _loc3_ = param1.radius;
         }
         else
         {
            _loc4_ = param1.currentPos.addedTo(param1.hitAreaPosition);
            _loc3_ = param1.hitAreaRadius;
         }
         var _loc5_:int = _loc4_.x - _loc3_;
         var _loc6_:int = _loc4_.y - _loc3_;
         var _loc7_:int = _loc4_.x + _loc3_;
         var _loc8_:int = _loc4_.y + _loc3_;
         this.addCell(_loc5_,_loc6_,_loc2_);
         this.addCell(_loc5_,_loc8_,_loc2_);
         this.addCell(_loc7_,_loc8_,_loc2_);
         this.addCell(_loc7_,_loc6_,_loc2_);
         return _loc2_;
      }
   }
}

