package com.whatthefawk.entity
{
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.tilemap.Tile;
   import com.whatthefawk.tilemap.TileMap;
   
   public class CollisionResponse implements ICollisionResponse
   {
      
      public static const BALL:String = "ball";
      
      public static const WALL:String = "wall";
      
      public static const TILE_MAP:String = "tile_map";
      
      protected var _ball:MovingEntity;
      
      protected var _wallBallCollisionMethodID:String = "makingthingsmove";
      
      protected var _tileMap:TileMap;
      
      protected var _wall:Wall;
      
      protected var _collisionType:String;
      
      protected var _messageDispatcher:IMessageDispatcher;
      
      public function CollisionResponse(param1:IMessageDispatcher)
      {
         super();
         this._messageDispatcher = param1;
      }
      
      private function handleWallBallCollision(param1:Wall, param2:MovingEntity) : void
      {
         if(!this.isValidWallBallCollision(param1,param2))
         {
            return;
         }
         if(this.wallBallCollisionTest(param1,param2,this._wallBallCollisionMethodID))
         {
            this._messageDispatcher.dispatchMessage(-1,param1.id,param2.id,CollisionEvent.HIT_WALL,{"wall":param1});
         }
      }
      
      private function wallBallCollisionTest(param1:Wall, param2:MovingEntity, param3:String = "makingthingsmove") : Boolean
      {
         switch(param3)
         {
            case "makingthingsmove":
               return this.mtmWallBallCollisionTest(param1,param2);
            case "tonypa":
               return this.tonyPaWallBallCollisionTest(param1,param2);
            default:
               return false;
         }
      }
      
      private function tonyPaWallBallCollisionTest(param1:Wall, param2:MovingEntity) : Boolean
      {
         var _loc4_:Vector2D = null;
         var _loc7_:Vector2D = null;
         var _loc8_:int = 0;
         var _loc9_:Vector2D = null;
         var _loc10_:Vector2D = null;
         var _loc3_:Vector2D = new Vector2D();
         _loc4_ = new Vector2D();
         _loc4_.x = param2.newPos.x - param1.fromPoint.x;
         _loc4_.y = param2.newPos.y - param1.fromPoint.y;
         var _loc5_:int = _loc4_.dot(param1.fromPoint);
         if(_loc5_ <= 0)
         {
            _loc7_ = new Vector2D();
            _loc7_.x = param2.newPos.x - param1.toPoint.x;
            _loc7_.y = param2.newPos.y - param1.toPoint.y;
            _loc8_ = _loc7_.dot(param1.toPoint);
            if(!(_loc8_ < 0 && _loc5_ < -100000))
            {
               _loc9_ = _loc4_.projectionOn(param1.normal);
               _loc10_ = _loc9_.normalized();
               _loc3_ = _loc9_;
            }
         }
         if(_loc3_.length == 0)
         {
            return false;
         }
         var _loc6_:* = param2.radius - _loc3_.length;
         if(_loc6_ > 0)
         {
            _loc3_.normalize();
            param2.newPos.x += _loc3_.x * _loc6_;
            param2.newPos.y += _loc3_.y * _loc6_;
            param2.currentPos.set(param2.newPos);
            param2.velocity.reflect(param1.normal);
            param2.velocity.times(param2.bounce);
            return true;
         }
         return false;
      }
      
      private function isValidBallBallCollision(param1:MovingEntity, param2:MovingEntity) : Boolean
      {
         return true;
      }
      
      public function handleCollision(param1:*, param2:*) : void
      {
         this._collisionType = null;
         if(param1 is Wall && param2 is Wall)
         {
            return;
         }
         if(param1 is TileMap && param2 is TileMap)
         {
            return;
         }
         if(param1 is TileMap && param2 is Wall)
         {
            return;
         }
         if(param1 is Wall && param2 is TileMap)
         {
            return;
         }
         if(param1 is TileMap || param2 is TileMap)
         {
            this._collisionType = CollisionResponse.TILE_MAP;
         }
         else if(param1 is Wall || param2 is Wall)
         {
            this._collisionType = CollisionResponse.WALL;
            if(!param1.isOverlappingBounds(param2))
            {
               return;
            }
         }
         else
         {
            this._collisionType = CollisionResponse.BALL;
            if(!param1.isHitAreaOverlapping(param2))
            {
               return;
            }
         }
         if(this._collisionType == CollisionResponse.TILE_MAP)
         {
            this._tileMap = param1 is TileMap ? param1 : param2;
            this._ball = !(param1 is TileMap) ? param1 : param2;
            this.handleTileMapBallCollision(this._tileMap,this._ball);
         }
         else if(this._collisionType == CollisionResponse.WALL)
         {
            this._wall = param1 is Wall ? param1 : param2;
            this._ball = !(param1 is Wall) ? param1 : param2;
            this.handleWallBallCollision(this._wall,this._ball);
         }
         else if(this._collisionType == CollisionResponse.BALL)
         {
            this.handleBallBallCollision(param1,param2);
         }
      }
      
      private function handleTileMapBallCollision(param1:TileMap, param2:MovingEntity) : void
      {
         var _loc6_:Vector2D = null;
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:int = 0;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         if(!this.isValidTileMapBallCollision(param1,param2))
         {
            return;
         }
         var _loc3_:Tile = this._tileMap.getTileAtPos(this._ball.currentPos.x,this._ball.currentPos.y);
         var _loc4_:Boolean = !this._tileMap.checkEdges(param2.currentPos.x,param2.oldPos.y,param2.radius);
         var _loc5_:Boolean = !this._tileMap.checkEdges(param2.oldPos.x,param2.currentPos.y,param2.radius);
         if(_loc4_ && _loc5_)
         {
            _loc6_ = param2.velocity.multipliedBy(param2.stepSize);
            _loc7_ = this._tileMap.getEdgeTiles(param2.currentPos.x + _loc6_.x,param2.currentPos.y + _loc6_.y,param2.radius);
            if(_loc7_.unwalkableEdgeCount == 1)
            {
               _loc8_ = 4;
               param2.oldPos.minus(_loc6_.dividedBy(_loc8_));
            }
            param2.newPos.set(param2.oldPos);
            param2.currentPos.set(param2.oldPos);
            param2.velocity.zero();
         }
         else if(_loc4_)
         {
            _loc9_ = this._tileMap.tileWidth / 2;
            _loc10_ = this._ball.heading.x < 0 ? 1 : -1;
            _loc11_ = _loc9_ - (_loc9_ - this._ball.radius) * _loc10_;
            _loc12_ = _loc3_.col * this._tileMap.tileWidth + _loc11_;
            param2.newPos.x = _loc12_;
            param2.currentPos.x = _loc12_;
            param2.velocity.x = 0;
         }
         else if(_loc5_)
         {
            _loc13_ = this._tileMap.tileHeight / 2;
            _loc14_ = this._ball.heading.y < 0 ? 1 : -1;
            _loc15_ = _loc13_ - (_loc13_ - this._ball.radius) * _loc14_;
            _loc16_ = _loc3_.row * this._tileMap.tileHeight + _loc15_;
            param2.newPos.y = _loc16_;
            param2.currentPos.y = _loc16_;
            param2.velocity.y = 0;
         }
         if(_loc4_ || _loc5_)
         {
            this._messageDispatcher.dispatchMessage(-1,this._tileMap.id,param2.id,CollisionEvent.HIT_TILE_MAP_TILE);
         }
      }
      
      private function mtmWallBallCollisionTest(param1:Wall, param2:MovingEntity) : Boolean
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc3_:Number = param1.angle.toRadians();
         var _loc4_:Number = Math.cos(_loc3_);
         _loc5_ = Math.sin(_loc3_);
         _loc6_ = param2.newPos.x - param1.midPoint.x;
         _loc7_ = param2.newPos.y - param1.midPoint.y;
         var _loc8_:Number = _loc4_ * _loc7_ - _loc5_ * _loc6_;
         _loc9_ = _loc4_ * param2.velocity.y - _loc5_ * param2.velocity.x;
         if(_loc8_ > -param2.radius && _loc8_ < _loc9_)
         {
            _loc10_ = _loc4_ * _loc6_ + _loc5_ * _loc7_;
            _loc11_ = _loc4_ * param2.velocity.x + _loc5_ * param2.velocity.y;
            _loc8_ = -param2.radius;
            _loc9_ *= -param2.bounce.y;
            _loc6_ = _loc4_ * _loc10_ - _loc5_ * _loc8_;
            _loc7_ = _loc4_ * _loc8_ + _loc5_ * _loc10_;
            param2.velocity.x = _loc4_ * _loc11_ - _loc5_ * _loc9_;
            param2.velocity.y = _loc4_ * _loc9_ + _loc5_ * _loc11_;
            param2.newPos.x = param1.midPoint.x + _loc6_;
            param2.newPos.y = param1.midPoint.y + _loc7_;
            param2.currentPos.x = param2.newPos.x;
            param2.currentPos.y = param2.newPos.y;
            return true;
         }
         return false;
      }
      
      private function isValidTileMapBallCollision(param1:TileMap, param2:MovingEntity) : Boolean
      {
         return true;
      }
      
      private function isValidWallBallCollision(param1:Wall, param2:MovingEntity) : Boolean
      {
         if(!param2.isCollidableWithWall)
         {
            return false;
         }
         return true;
      }
      
      private function handleBallBallCollision(param1:*, param2:*) : void
      {
         if(!this.isValidBallBallCollision(param1,param2))
         {
            return;
         }
         this._messageDispatcher.dispatchMessage(-1,param1.id,param2.id,CollisionEvent.HIT_ENTITY,{"entity":param1});
         this._messageDispatcher.dispatchMessage(-1,param2.id,param1.id,CollisionEvent.HIT_ENTITY,{"entity":param2});
      }
   }
}

