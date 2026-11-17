package com.whatthefawk.entity
{
   import com.whatthefawk.collision.SpatialManager;
   
   public class SpatialCollisionProcess implements ICollisionProcess
   {
      
      protected var _entityB:Entity;
      
      protected var _entity:Entity;
      
      protected var _wall:Wall;
      
      protected var _walls:Vector.<Entity>;
      
      protected var _spatialManager:SpatialManager;
      
      protected var _collisionResponse:ICollisionResponse;
      
      protected var _validEntities:Vector.<Entity>;
      
      protected var _entityA:Entity;
      
      public function SpatialCollisionProcess(param1:int, param2:int, param3:int, param4:ICollisionResponse)
      {
         super();
         this._collisionResponse = param4;
         this._spatialManager = new SpatialManager(param1,param2,param3);
      }
      
      public function processCollisions(param1:Array) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this._walls = new Vector.<Entity>();
         this._validEntities = new Vector.<Entity>();
         this._spatialManager.resetCells();
         var _loc2_:* = 0;
         for each(this._entity in param1)
         {
            if(this._entity is Wall)
            {
               this._walls[this._walls.length] = this._entity;
            }
            else if(this._entity.isCollidable)
            {
               this._entity.collisionChecked = false;
               this._spatialManager.registerEntity(this._entity);
               var _loc8_:Number;
               this._validEntities[_loc8_ = _loc2_++] = this._entity;
            }
         }
         for each(_loc3_ in this._spatialManager.cellMap)
         {
            _loc4_ = int(_loc3_.length);
            if(_loc4_ >= 2)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc4_)
               {
                  this._entityA = _loc3_[_loc2_];
                  _loc5_ = _loc2_ + 1;
                  while(_loc5_ < _loc4_)
                  {
                     this._entityB = _loc3_[_loc5_];
                     this._collisionResponse.handleCollision(this._entityA,this._entityB);
                     _loc5_++;
                  }
                  _loc2_++;
               }
            }
         }
         for each(this._wall in this._walls)
         {
            for each(this._entity in this._validEntities)
            {
               this._collisionResponse.handleCollision(this._wall,this._entity);
            }
         }
      }
   }
}

