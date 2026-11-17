package com.whatthefawk.ai.steering.behaviors
{
   import com.whatthefawk.ai.steering.SteeringBehaviorSettings;
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.math.Vector2D;
   import flash.display.Sprite;
   
   public class Wander extends ASteeringBehavior
   {
      
      public var wanderDistance:Vector2D;
      
      public var wanderAngle:Number;
      
      public var showDebugMarker:Boolean = false;
      
      public var wanderCirclePos:Vector2D;
      
      public var wanderJitter:Number;
      
      public var wanderTarget:Vector2D;
      
      public var wanderRadius:Number;
      
      public function Wander(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super(SteeringBehaviorSettings.wanderWeight,SteeringBehaviorSettings.wanderPriority);
         this.wanderAngle = 0;
         this.wanderRadius = param1 ? param1 : SteeringBehaviorSettings.wanderRadius;
         this.wanderJitter = param3 ? param3 : SteeringBehaviorSettings.wanderJitter;
         this.wanderTarget = new Vector2D();
         var _loc4_:Number = param2 ? param2 : SteeringBehaviorSettings.wanderDistance;
         this.wanderDistance = new Vector2D(_loc4_,_loc4_);
         this.wanderCirclePos = new Vector2D();
      }
      
      public static function force(param1:MovingEntity, param2:Number = 0, param3:Number = 0, param4:Number = 0) : Vector2D
      {
         return new Vector2D();
      }
      
      public function removeDebugMarker(param1:* = null) : void
      {
         if(!param1)
         {
            param1 = entity.parent;
         }
         var _loc2_:* = param1.getChildByName("wanderDebugMarker");
         if(_loc2_)
         {
            param1.removeChild(_loc2_);
         }
      }
      
      override public function force() : Vector2D
      {
         this.wanderCirclePos.x = Math.cos(this.wanderAngle) * this.wanderRadius;
         this.wanderCirclePos.y = Math.sin(this.wanderAngle) * this.wanderRadius;
         if(Math.random() < 0.5)
         {
            this.wanderAngle += this.wanderJitter;
         }
         else
         {
            this.wanderAngle -= this.wanderJitter;
         }
         if(entity.heading.x < 0)
         {
            this.wanderDistance.x *= -1;
         }
         if(entity.heading.y < 0)
         {
            this.wanderDistance.y *= -1;
         }
         this.wanderTarget.x = entity.currentPos.x + this.wanderDistance.x + this.wanderCirclePos.x;
         this.wanderTarget.y = entity.currentPos.y + this.wanderDistance.y + this.wanderCirclePos.y;
         if(this.showDebugMarker)
         {
            this.updateDebugMarker(this.wanderTarget);
         }
         return Seek.force(entity,this.wanderTarget);
      }
      
      public function updateDebugMarker(param1:*, param2:* = null) : void
      {
         var _loc4_:Sprite = null;
         if(!param2)
         {
            param2 = entity.parent;
         }
         var _loc3_:* = param2.getChildByName("wanderDebugMarker");
         if(!_loc3_)
         {
            _loc4_ = new Sprite();
            _loc4_.graphics.lineStyle(1,0);
            _loc4_.graphics.drawCircle(0,0,2);
            _loc4_.x = param1.x;
            _loc4_.y = param1.y;
            _loc4_.name = "wanderDebugMarker";
            param2.addChild(_loc4_);
         }
         else
         {
            _loc3_.x = param1.x;
            _loc3_.y = param1.y;
         }
      }
   }
}

