package com.whatthefawk.ai.steering.behaviors
{
   import com.whatthefawk.ai.steering.SteeringBehaviorSettings;
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.math.Vector2D;
   
   public class Seek extends ASteeringBehavior
   {
      
      public var stopDist:Number;
      
      public var target:Vector2D;
      
      public function Seek(param1:Vector2D, param2:Number = 0)
      {
         super(SteeringBehaviorSettings.seekWeight,SteeringBehaviorSettings.seekPriority);
         this.target = param1;
         this.stopDist = param2;
      }
      
      public static function force(param1:MovingEntity, param2:Vector2D, param3:Number = 0) : Vector2D
      {
         if(param1.currentPos.distanceSqTo(param2) < param3 * param3 && param3 > 0)
         {
            return new Vector2D();
         }
         var _loc4_:Vector2D = param2.subtractedBy(param1.currentPos).normalize().times(param1.maxSpeed);
         return _loc4_.minus(param1.velocity);
      }
      
      override public function force() : Vector2D
      {
         if(entity.currentPos.distanceSqTo(this.target) < this.stopDist * this.stopDist && this.stopDist > 0)
         {
            return new Vector2D();
         }
         var _loc1_:Vector2D = this.target.subtractedBy(entity.currentPos).normalize().times(entity.maxSpeed);
         return _loc1_.minus(entity.velocity);
      }
   }
}

