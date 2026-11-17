package com.whatthefawk.ai.steering
{
   import com.whatthefawk.ai.steering.behaviors.*;
   import com.whatthefawk.entity.Boid;
   import com.whatthefawk.math.Vector2D;
   
   public class SteeringBehavior
   {
      
      public static const CALCULATE_SUM:int = 0;
      
      public static const CALCULATE_SPEED:int = 1;
      
      public static const CALCULATE_ACCURACY:int = 2;
      
      public var neighbors:Array;
      
      public var isSorted:Boolean;
      
      public var numGroupBehaviors:int;
      
      public var calcMethod:Number;
      
      public var behaviors:Array;
      
      public var entity:Boid;
      
      public var force:Vector2D;
      
      public function SteeringBehavior(param1:Boid, param2:Number = 2)
      {
         super();
         this.entity = param1;
         this.force = new Vector2D();
         this.behaviors = [];
         this.neighbors = [];
         this.isSorted = true;
         this.numGroupBehaviors = 0;
         this.calcMethod = param2;
      }
      
      public function getBehavior(param1:Class) : ASteeringBehavior
      {
         var _loc2_:ASteeringBehavior = null;
         for each(_loc2_ in this.behaviors)
         {
            if(_loc2_ is param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function addForce(param1:Vector2D) : Boolean
      {
         var _loc2_:Number = this.force.length;
         var _loc3_:Number = this.entity.maxForce - _loc2_;
         if(_loc3_ <= 0)
         {
            return false;
         }
         var _loc4_:Number = param1.length;
         if(_loc4_ < _loc3_)
         {
            this.force.x += param1.x;
            this.force.y += param1.y;
            return true;
         }
         param1.normalize();
         param1.x *= _loc3_;
         param1.y *= _loc3_;
         this.force.x += param1.x;
         this.force.y += param1.y;
         return false;
      }
      
      public function addBehavior(param1:ASteeringBehavior) : void
      {
         param1.entity = this.entity;
         this.behaviors.push(param1);
         if(this.behaviors.length > 1)
         {
            this.isSorted = false;
         }
         if(param1 is IGroupSteeringBehavior)
         {
            ++this.numGroupBehaviors;
         }
      }
      
      public function clearBehaviors() : void
      {
         this.behaviors = [];
         this.isSorted = true;
         this.numGroupBehaviors = 0;
      }
      
      public function dispose() : void
      {
         this.entity = null;
         this.force = null;
         this.behaviors = null;
         this.neighbors = null;
      }
      
      private function weightedTruncatedSum() : void
      {
         var _loc2_:ASteeringBehavior = null;
         var _loc1_:int = int(this.behaviors.length);
         while(--_loc1_ > -1)
         {
            _loc2_ = this.behaviors[_loc1_];
            this.force.plus(_loc2_.force().times(_loc2_.weight));
         }
         this.force.truncate(this.entity.maxForce);
      }
      
      private function prioritizedWTRS() : void
      {
         var _loc2_:ASteeringBehavior = null;
         var _loc1_:int = int(this.behaviors.length);
         while(--_loc1_ > -1)
         {
            _loc2_ = this.behaviors[_loc1_];
            if(!this.addForce(_loc2_.force().times(_loc2_.weight)))
            {
               return;
            }
         }
      }
      
      public function calculateForces() : Vector2D
      {
         this.force.zero();
         if(!this.isSorted)
         {
            this.sortBehaviors();
         }
         if(this.numGroupBehaviors > 0)
         {
            this.neighbors = this.entity.getNeighbors(0,Boid);
         }
         switch(this.calcMethod)
         {
            case CALCULATE_SUM:
               this.weightedTruncatedSum();
               break;
            case CALCULATE_SPEED:
               this.prioritizedDithering();
               break;
            case CALCULATE_ACCURACY:
               this.prioritizedWTRS();
               break;
            default:
               throw new Error("SteeringBehavior::calc()  Error: Invalid calculation method.");
         }
         return this.force;
      }
      
      public function sortBehaviors() : void
      {
         this.behaviors.sort(this.compareBehaviors);
         this.isSorted = true;
      }
      
      public function removeBehavior(param1:Class) : void
      {
         var _loc2_:ASteeringBehavior = null;
         var _loc3_:int = int(this.behaviors.length);
         while(--_loc3_ > -1)
         {
            if(this.behaviors[_loc3_] is param1)
            {
               _loc2_ = this.behaviors[_loc3_];
               break;
            }
         }
         this.behaviors.splice(_loc3_,1);
         if(_loc2_ is IGroupSteeringBehavior)
         {
            --this.numGroupBehaviors;
         }
      }
      
      private function prioritizedDithering() : void
      {
         var _loc2_:ASteeringBehavior = null;
         var _loc1_:int = int(this.behaviors.length);
         while(--_loc1_ > -1)
         {
            _loc2_ = this.behaviors[_loc1_];
            if(Math.random() < _loc2_.probability)
            {
               this.force.plus(_loc2_.force().times(_loc2_.weight));
            }
            if(!this.force.isZero())
            {
               this.force.truncate(this.entity.maxForce);
               return;
            }
         }
      }
      
      public function updateBehavior(... rest) : void
      {
      }
      
      private function compareBehaviors(param1:ASteeringBehavior, param2:ASteeringBehavior) : int
      {
         if(param1.priority < param2.priority)
         {
            return 1;
         }
         if(param1.priority == param2.priority)
         {
            return 0;
         }
         return -1;
      }
   }
}

