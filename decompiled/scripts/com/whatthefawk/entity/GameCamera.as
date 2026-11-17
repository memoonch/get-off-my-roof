package com.whatthefawk.entity
{
   import com.whatthefawk.math.Vector2D;
   import flash.events.Event;
   
   public class GameCamera extends Entity
   {
      
      public static const MOVE:String = "camera_move";
      
      private var m_worldWidth:Number;
      
      private var m_worldHeight:Number;
      
      private var m_followPos:Vector2D;
      
      private var m_oldPos:Vector2D;
      
      public function GameCamera(param1:GameWorld, param2:Number, param3:Number)
      {
         var _loc4_:EntityParams = new EntityParams();
         _loc4_.type = "GameCamera";
         super(_loc4_);
         parent = param1;
         this.m_oldPos = new Vector2D(-1,-1);
         this.setSize(param2,param3);
         this.onWorldResize(new EntityEvent(EntityEvent.RESIZE,{
            "width":param1.bounds.width,
            "height":param1.bounds.height
         }));
         param1.addEventListener(EntityEvent.RESIZE,this.onWorldResize,false,0,true);
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         bounds.setSize(param1,param2);
         dispatchEvent(new EntityEvent(EntityEvent.RESIZE,{
            "width":param1,
            "height":param2
         }));
      }
      
      override public function update(param1:int) : void
      {
         if(this.m_followPos)
         {
            newPos.x = this.m_followPos.x;
            newPos.y = this.m_followPos.y;
         }
         if(!this.m_oldPos.isEqualTo(newPos))
         {
            this.m_oldPos.x = currentPos.x;
            this.m_oldPos.y = currentPos.y;
            currentPos.x = newPos.x;
            currentPos.y = newPos.y;
            if(currentPos.x - bounds.halfWidth < 0)
            {
               currentPos.x = bounds.halfWidth;
            }
            else if(currentPos.x + bounds.halfWidth >= this.m_worldWidth)
            {
               currentPos.x = this.m_worldWidth - bounds.halfWidth;
            }
            if(currentPos.y - bounds.halfHeight < 0)
            {
               currentPos.y = bounds.halfHeight;
            }
            else if(currentPos.y + bounds.halfHeight >= this.m_worldHeight)
            {
               currentPos.y = this.m_worldHeight - bounds.halfHeight;
            }
            newPos.x = currentPos.x;
            newPos.y = currentPos.y;
            bounds.moveTo(newPos);
            dispatchEvent(new Event(GameCamera.MOVE));
         }
      }
      
      public function followPos(param1:Vector2D) : void
      {
         this.m_followPos = param1;
      }
      
      private function onWorldResize(param1:EntityEvent) : void
      {
         this.m_worldWidth = param1.data.width;
         this.m_worldHeight = param1.data.height;
         this.update(0);
      }
   }
}

