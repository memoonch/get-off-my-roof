package com.whatthefawk.ai.steering.behaviors
{
   import com.whatthefawk.ai.steering.SteeringBehaviorSettings;
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.math.Vector2D;
   import flash.display.Sprite;
   
   public class Evade extends ASteeringBehavior
   {
      
      public var showDebugMarker:Boolean = false;
      
      public var pursuer:MovingEntity;
      
      public var panicDist:Number;
      
      public function Evade(param1:MovingEntity, param2:Number = 0)
      {
         super(SteeringBehaviorSettings.pursuitWeight,SteeringBehaviorSettings.pursuitPriority);
         this.pursuer = param1;
         this.panicDist = param2;
      }
      
      public static function force(param1:MovingEntity, param2:MovingEntity, param3:Number = 0) : Vector2D
      {
         var _loc4_:Vector2D = param2.currentPos.subtractedBy(param1.currentPos);
         var _loc5_:Number = _loc4_.length / (param1.maxSpeed + param2.speed);
         var _loc6_:Vector2D = param2.currentPos.addedTo(param2.velocity.multipliedBy(_loc5_));
         return Flee.force(param1,_loc6_,param3);
      }
      
      public function updateDebugMarker(param1:*, param2:* = null) : void
      {
         var _loc4_:Sprite = null;
         if(!param2)
         {
            param2 = entity.parent;
         }
         var _loc3_:* = param2.getChildByName("evadeDebugMarker");
         if(!_loc3_)
         {
            _loc4_ = new Sprite();
            _loc4_.graphics.lineStyle(1,0);
            _loc4_.graphics.drawCircle(0,0,2);
            _loc4_.x = param1.x;
            _loc4_.y = param1.y;
            _loc4_.name = "evadeDebugMarker";
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
         var _loc2_:* = param1.getChildByName("evadeDebugMarker");
         if(_loc2_)
         {
            param1.removeChild(_loc2_);
         }
      }
      
      override public function force() : Vector2D
      {
         var _loc1_:Vector2D = this.pursuer.currentPos.subtractedBy(entity.currentPos);
         var _loc2_:Number = _loc1_.length / (entity.maxSpeed + this.pursuer.speed);
         var _loc3_:Vector2D = this.pursuer.currentPos.addedTo(this.pursuer.velocity.multipliedBy(_loc2_));
         if(this.showDebugMarker)
         {
            this.updateDebugMarker(_loc3_);
         }
         return Flee.force(entity,_loc3_,this.panicDist);
      }
      
      private function turnAroundTime() : Number
      {
         return 0;
      }
   }
}

