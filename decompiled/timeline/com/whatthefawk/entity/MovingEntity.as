package com.whatthefawk.entity
{
   import com.whatthefawk.collision.bounds.ABoundsBehavior;
   import com.whatthefawk.math.Average;
   import com.whatthefawk.math.Matrix2D;
   import com.whatthefawk.math.Vector2D;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class MovingEntity extends Entity
   {
      
      private static const POINT:Point = new Point();
      
      private static const VECTOR:Vector2D = new Vector2D();
      
      private static const MATRIX:Matrix2D = new Matrix2D();
      
      public static const BOUNDS_NONE:String = "none";
      
      public static const BOUNDS_STOP:String = "stop";
      
      public static const BOUNDS_WRAP:String = "wrap";
      
      public static const BOUNDS_BOUNCE:String = "bounce";
      
      public static const BOUNDS_REMOVE:String = "remove";
      
      public var acceleration:Vector2D;
      
      public var maxTurnRate:Number;
      
      public var smoothHeading:Boolean;
      
      public var bounce:Vector2D;
      
      public var heading:Vector2D;
      
      public var isResting:Boolean;
      
      public var mass:Number;
      
      protected var _forces:Array;
      
      public var friction:Vector2D;
      
      public var neighborhoodDistance:Number;
      
      public var isCollidableWithBounds:Boolean;
      
      public var boundsBehavior:String;
      
      public var boundsBehaviors:Array;
      
      private const BOUNCE_STOP_SPEED:Number = 30;
      
      public var maxSpeed:Number;
      
      protected var _constantForces:Dictionary;
      
      public var side:Vector2D;
      
      public var velocity:Vector2D;
      
      protected var _oldVelocity:Vector2D;
      
      public var maxForce:Number;
      
      public var faceHeading:Boolean;
      
      protected var _force:Vector2D;
      
      public var isCollidableWithWall:Boolean;
      
      public var headingSmoother:Average;
      
      public function MovingEntity(param1:MovingEntityParams)
      {
         super(param1);
         this.mass = param1.mass;
         this.bounce = param1.bounce;
         this.friction = param1.friction;
         this.maxForce = param1.maxForce;
         this.maxSpeed = param1.maxSpeed;
         this.maxTurnRate = param1.maxTurnRate;
         this.faceHeading = param1.faceHeading;
         this.smoothHeading = param1.smoothHeading;
         this.boundsBehavior = param1.boundsBehavior;
         this.boundsBehaviors = param1.boundsBehaviors;
         this.neighborhoodDistance = param1.neighborhoodDistance;
         this.isResting = false;
         this.isCollidableWithWall = param1.isCollidableWithWall;
         this.isCollidableWithBounds = param1.isCollidableWithBounds;
         this.velocity = new Vector2D();
         this.acceleration = new Vector2D();
         this.heading = new Vector2D(1,0);
         this.side = this.heading.perp();
         this.headingSmoother = new Average();
         this._force = new Vector2D();
         this._forces = [];
         this._constantForces = new Dictionary();
         this._oldVelocity = new Vector2D();
      }
      
      public function removeConstantForce(param1:String) : void
      {
         this._constantForces[param1] = null;
         delete this._constantForces[param1];
      }
      
      public function addConstantForce(param1:Vector2D, param2:String) : void
      {
         if(!param1)
         {
            return;
         }
         this._constantForces[param2] = param1;
      }
      
      public function onBoundsRemove(param1:Event = null) : void
      {
      }
      
      protected function updatePosition() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Number = this.velocity.x * _stepSize;
         var _loc2_:Number = this.velocity.y * _stepSize;
         currentPos.x += _loc1_;
         currentPos.y += _loc2_;
         if(this.isCollidableWithBounds)
         {
            _loc3_ = int(this.boundsBehaviors.length);
            while(--_loc3_ > -1)
            {
               ABoundsBehavior(this.boundsBehaviors[_loc3_]).checkBounds(this,_parent.bounds);
            }
         }
         newPos.x = currentPos.x;
         newPos.y = currentPos.y;
         this.isResting = oldPos.x == newPos.x && oldPos.y == newPos.y;
      }
      
      public function getNeighbors(param1:Number = 0, param2:Class = null) : Array
      {
         var _loc4_:Entity = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc3_:Array = [];
         if(!param1)
         {
            param1 = this.neighborhoodDistance;
         }
         for each(_loc4_ in _parent.getChildren())
         {
            if(_loc4_ != this)
            {
               if(!param2 || Boolean(param2) && Boolean(_loc4_ is param2))
               {
                  _loc5_ = _loc4_.currentPos.distanceSqTo(this.currentPos);
                  _loc6_ = param1 + _loc4_.radius;
                  if(_loc5_ < _loc6_ * _loc6_)
                  {
                     if(_loc4_.currentPos.isInFOV(this.currentPos,this.heading,180))
                     {
                        _loc3_.push(_loc4_);
                     }
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function clearAllForces() : void
      {
         this._forces = [];
         this._constantForces = new Dictionary();
      }
      
      public function applyForce(param1:Vector2D) : void
      {
         if(!param1)
         {
            return;
         }
         this._forces.push(param1);
      }
      
      override public function dispose() : void
      {
         this.velocity = null;
         this.acceleration = null;
         this.bounce = null;
         this.friction = null;
         this.side = null;
         this.heading = null;
         this.headingSmoother = null;
         this.boundsBehaviors = null;
         this._force = null;
         this._forces = null;
         this._constantForces = null;
         this._oldVelocity = null;
         super.dispose();
      }
      
      public function stop(param1:Number = 0.5) : void
      {
         if(param1 == 0)
         {
            this.velocity.zero();
            return;
         }
         this.velocity.times(param1);
      }
      
      public function hasConstantForce(param1:String) : Boolean
      {
         return this._constantForces[param1] ? true : false;
      }
      
      public function get constantForces() : Dictionary
      {
         return this._constantForces;
      }
      
      protected function calculateFinalVelocity() : void
      {
         var _loc1_:Matrix2D = null;
         if(this.maxTurnRate > 0)
         {
            if(this._oldVelocity.angleTo(this.velocity) > this.maxTurnRate * Vector2D.DEG_TO_RAD * _stepSize)
            {
               _loc1_ = MovingEntity.MATRIX;
               _loc1_.rotate(this.maxTurnRate * Vector2D.DEG_TO_RAD * _stepSize * this.heading.sign(this.velocity));
               _loc1_.transformVector(this._oldVelocity);
               this.velocity.set(this._oldVelocity);
            }
         }
      }
      
      public function rotateToEntity(param1:Entity) : void
      {
         this.rotateToPosition(param1.currentPos);
      }
      
      public function setHeading(param1:Vector2D) : void
      {
         if(param1.lengthSq == 0)
         {
            this.heading.set(1,0);
         }
         else
         {
            this.heading = param1;
         }
         this.side = this.heading.perp();
      }
      
      public function get speed() : Number
      {
         return this.velocity.length;
      }
      
      override public function update(param1:int) : void
      {
         lifeTime.update(param1);
         setInitialValues(param1);
         this.calculateForces();
         this.calculateFinalVelocity();
         this.updatePosition();
         this.updateHeading();
         updateChildren(param1);
      }
      
      protected function calculateForces() : void
      {
         var _loc1_:Vector2D = null;
         var _loc3_:Vector2D = null;
         this._oldVelocity.x = this.velocity.x;
         this._oldVelocity.y = this.velocity.y;
         this._force.x = this._force.y = 0;
         var _loc2_:int = int(this._forces.length);
         while(--_loc2_ > -1)
         {
            _loc1_ = this._forces[_loc2_];
            this._force.x += _loc1_.x;
            this._force.y += _loc1_.y;
         }
         this._forces = [];
         for each(_loc3_ in this._constantForces)
         {
            this._force.x += _loc3_.x;
            this._force.y += _loc3_.y;
         }
         this.acceleration.x = this._force.x / this.mass;
         this.acceleration.y = this._force.y / this.mass;
         this.velocity.x += this.acceleration.x;
         this.velocity.y += this.acceleration.y;
         this.velocity.x *= this.friction.x;
         this.velocity.y *= this.friction.y;
         if(this.maxSpeed > 0)
         {
            this.velocity.truncate(this.maxSpeed);
         }
      }
      
      public function getConstantForce(param1:String) : Vector2D
      {
         return this._constantForces[param1];
      }
      
      public function get forces() : Array
      {
         return this._forces;
      }
      
      protected function updateHeading() : void
      {
         if(this.velocity.x * this.velocity.x + this.velocity.y * this.velocity.y > 0.001)
         {
            this.heading = this.velocity.normalized();
            this.side.x = -this.heading.y;
            this.side.y = this.heading.x;
            if(this.faceHeading)
            {
               if(this.smoothHeading)
               {
                  rotation = this.headingSmoother.addValue(this.heading).toRadians();
               }
               else
               {
                  rotation = this.heading.toRadians();
               }
            }
         }
         else
         {
            this.velocity.zero();
         }
      }
      
      public function rotateToPosition(param1:Vector2D) : void
      {
         rotation = Math.atan2(param1.y - currentPos.y,param1.x - currentPos.x);
      }
   }
}

