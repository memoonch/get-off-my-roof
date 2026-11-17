package com.whatthefawk.ai.steering.behaviors
{
   import com.whatthefawk.ai.steering.SteeringBehaviorSettings;
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.math.Vector2D;
   
   public class Flee extends ASteeringBehavior
   {
      
      public var target:Vector2D;
      
      public var panicDist:Number;
      
      public function Flee(param1:Vector2D, param2:Number = 0)
      {
         super(SteeringBehaviorSettings.fleeWeight,SteeringBehaviorSettings.fleePriority);
         this.target = param1;
         this.panicDist = param2;
      }
      
      public static function force(param1:MovingEntity, param2:Vector2D, param3:Number = 0) : Vector2D
      {
         if(param1.currentPos.distanceSqTo(param2) > param3 * param3 && param3 > 0)
         {
            return new Vector2D();
         }
         var _loc4_:Vector2D = param1.currentPos.subtractedBy(param2).normalize().times(param1.maxSpeed);
         return _loc4_.minus(param1.velocity);
      }
      
      override public function force() : Vector2D
      {
         if(entity.currentPos.distanceSqTo(this.target) > this.panicDist * this.panicDist && this.panicDist > 0)
         {
            return new Vector2D();
         }
         var _loc1_:Vector2D = entity.currentPos.subtractedBy(this.target).normalize().times(entity.maxSpeed);
         return _loc1_.minus(entity.velocity);
      }
   }
}

