package com.whatthefawk.ai.steering.behaviors
{
   import com.whatthefawk.ai.steering.SteeringBehaviorSettings;
   import com.whatthefawk.ai.steering.path.Path;
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.math.Vector2D;
   
   public class FollowPath extends ASteeringBehavior
   {
      
      public var path:Path;
      
      public var pathCount:int = -1;
      
      public var edgeBuffer:Number;
      
      public function FollowPath(param1:Path, param2:Number = 20)
      {
         super(SteeringBehaviorSettings.followPathWeight,SteeringBehaviorSettings.followPathPriority);
         this.path = param1;
         this.edgeBuffer = param2;
      }
      
      public static function force(param1:MovingEntity, param2:Path, param3:Number = 20) : Vector2D
      {
         if(param2.currentWaypoint.distanceSqTo(param1.currentPos) < param3 * param3)
         {
            param2.setNextWaypoint();
         }
         if(param2.isFinished)
         {
            return Arrive.force(param1,param2.currentWaypoint);
         }
         return Seek.force(param1,param2.currentWaypoint);
      }
      
      override public function force() : Vector2D
      {
         if(this.path.currentWaypoint.distanceSqTo(entity.currentPos) < this.edgeBuffer * this.edgeBuffer)
         {
            if(this.path.isOnWaypoint(1))
            {
               ++this.pathCount;
            }
            this.path.setNextWaypoint();
         }
         if(this.path.isFinished)
         {
            return Arrive.force(entity,this.path.currentWaypoint);
         }
         return Seek.force(entity,this.path.currentWaypoint);
      }
   }
}

