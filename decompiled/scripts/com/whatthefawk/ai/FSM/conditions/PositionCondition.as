package com.whatthefawk.ai.FSM.conditions
{
   import com.whatthefawk.ai.FSM.ACondition;
   import com.whatthefawk.ai.FSM.ICondition;
   import com.whatthefawk.math.Vector2D;
   
   public class PositionCondition extends ACondition implements ICondition
   {
      
      private var m_minDistance:int;
      
      private var m_position:Vector2D;
      
      public function PositionCondition(param1:Vector2D = null, param2:int = 10)
      {
         super();
         this.m_position = param1;
         this.m_minDistance = param2;
      }
      
      override public function test(param1:*) : Boolean
      {
         if(!this.m_position)
         {
            return false;
         }
         return param1.currentPos.distanceTo(this.m_position) < this.m_minDistance ? true : false;
      }
      
      public function set position(param1:Vector2D) : void
      {
         this.m_position = param1;
      }
      
      public function set minDistance(param1:int) : void
      {
         this.m_minDistance = param1;
      }
   }
}

