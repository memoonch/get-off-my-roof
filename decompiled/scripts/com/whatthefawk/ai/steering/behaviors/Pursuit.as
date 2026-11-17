package com.whatthefawk.ai.steering.behaviors
{
   import com.whatthefawk.ai.steering.SteeringBehaviorSettings;
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.math.Vector2D;
   import flash.display.Sprite;
   
   public class Pursuit extends ASteeringBehavior
   {
      
      public var showDebugMarker:Boolean = false;
      
      public var evader:MovingEntity;
      
      public var stopDist:Number;
      
      public function Pursuit(param1:MovingEntity, param2:Number = 0)
      {
         super(SteeringBehaviorSettings.pursuitWeight,SteeringBehaviorSettings.pursuitPriority);
         this.evader = param1;
         this.stopDist = param2;
      }
      
      public static function force(param1:MovingEntity, param2:MovingEntity, param3:Number = 0) : Vector2D
      {
         var _loc4_:Vector2D = param2.currentPos.subtractedBy(param1.currentPos);
         var _loc5_:Number = param1.heading.dot(param2.heading);
         if(_loc4_.dot(param1.heading) > 0 && _loc5_ < -0.95)
         {
            return Seek.force(param1,param2.currentPos,param3);
         }
         var _loc6_:Number = _loc4_.length / (param1.maxSpeed + param2.speed);
         var _loc7_:Vector2D = param2.currentPos.addedTo(param2.velocity.multipliedBy(_loc6_));
         return Seek.force(param1,_loc7_,param3);
      }
      
      public function updateDebugMarker(param1:*, param2:* = null) : void
      {
         var _loc4_:Sprite = null;
         if(!param2)
         {
            param2 = entity.parent;
         }
         var _loc3_:* = param2.getChildByName("pursuitDebugMarker");
         if(!_loc3_)
         {
            _loc4_ = new Sprite();
            _loc4_.graphics.lineStyle(1,0);
            _loc4_.graphics.drawCircle(0,0,2);
            _loc4_.x = param1.x;
            _loc4_.y = param1.y;
            _loc4_.name = "pursuitDebugMarker";
            param2.addChild(_loc4_);
         }
         else
         {
            _loc3_.x = param1.x;
            _loc3_.y = param1.y;
         }
      }
      
      public function removeDebugMarker(param1:* = null) : void
      {
         if(!param1)
         {
            param1 = entity.parent;
         }
         var _loc2_:* = param1.getChildByName("pursuitDebugMarker");
         if(_loc2_)
         {
            param1.removeChild(_loc2_);
         }
      }
      
      override public function force() : Vector2D
      {
         var _loc1_:Vector2D = this.evader.currentPos.subtractedBy(entity.currentPos);
         var _loc2_:Number = entity.heading.dot(this.evader.heading);
         if(_loc1_.dot(entity.heading) > 0 && _loc2_ < -0.95)
         {
            if(this.showDebugMarker)
            {
               this.removeDebugMarker();
            }
            return Seek.force(entity,this.evader.currentPos,this.stopDist);
         }
         var _loc3_:Number = _loc1_.length / (entity.maxSpeed + this.evader.speed);
         var _loc4_:Vector2D = this.evader.currentPos.addedTo(this.evader.velocity.multipliedBy(_loc3_));
         if(this.showDebugMarker)
         {
            this.updateDebugMarker(_loc4_);
         }
         return Seek.force(entity,_loc4_,this.stopDist);
      }
      
      private function turnAroundTime() : Number
      {
         return 0;
      }
   }
}

