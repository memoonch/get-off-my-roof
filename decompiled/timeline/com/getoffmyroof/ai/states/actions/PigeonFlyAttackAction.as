package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.entity.Pigeon;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.utils.TickRegulator;
   import flash.events.Event;
   
   public class PigeonFlyAttackAction extends AAction implements IAction
   {
      
      private var m_tickRegulator:TickRegulator;
      
      private var m_pigeon:Pigeon;
      
      public function PigeonFlyAttackAction()
      {
         super();
         this.m_tickRegulator = new TickRegulator();
         this.m_tickRegulator.addEventListener(TickRegulator.TICK,this.onTimeRateTick);
      }
      
      private function onTimeRateTick(param1:Event) : void
      {
         if(this.m_pigeon.currentPos.y > this.m_pigeon.attackHeight)
         {
            return;
         }
         if(this.m_pigeon.flyAttackChance.test())
         {
            this.m_pigeon.attack();
         }
      }
      
      override public function execute(param1:*) : void
      {
         this.m_pigeon = param1;
         this.m_tickRegulator.update();
      }
   }
}

