package com.whatthefawk.ai.steering.behaviors
{
   import com.whatthefawk.ai.steering.SteeringBehaviorSettings;
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.math.Vector2D;
   
   public class Arrive extends ASteeringBehavior
   {
      
      public var target:Vector2D;
      
      public var decelSpeed:int;
      
      public function Arrive(param1:Vector2D, param2:int = 3)
      {
         super(SteeringBehaviorSettings.arriveWeight,SteeringBehaviorSettings.arrivePriority);
         this.target = param1;
         this.decelSpeed = param2;
      }
      
      public static function force(param1:MovingEntity, param2:Vector2D, param3:int = 40) : Vector2D
      {
         var _loc6_:* = undefined;
         var _loc4_:Vector2D = param2.subtractedBy(param1.currentPos);
         var _loc5_:Number = _loc4_.length;
         if(_loc5_ > 0.01)
         {
            _loc6_ = _loc5_ / (param3 * SteeringBehaviorSettings.speedTweaker);
            _loc6_ = Math.min(_loc6_,param1.maxSpeed);
            _loc4_.times(_loc6_ / _loc5_);
            return _loc4_.minus(param1.velocity);
         }
         return new Vector2D();
      }
      
      override public function force() : Vector2D
      {
         var _loc3_:* = undefined;
         var _loc1_:Vector2D = this.target.subtractedBy(entity.currentPos);
         var _loc2_:Number = _loc1_.length;
         if(_loc2_ > 0.01)
         {
            _loc3_ = _loc2_ / (this.decelSpeed * SteeringBehaviorSettings.speedTweaker);
            _loc3_ = Math.min(_loc3_,entity.maxSpeed);
            _loc1_.times(_loc3_ / _loc2_);
            _loc1_.minus(entity.velocity);
            return _loc1_;
         }
         return new Vector2D();
      }
   }
}

