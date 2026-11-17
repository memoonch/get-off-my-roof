package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.entity.Pigeon;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.utils.TickRegulator;
   import flash.events.Event;
   
   public class BasicPigeonWanderAction extends AAction implements IAction
   {
      
      private var m_tickRegulator:TickRegulator;
      
      private var m_pigeon:Pigeon;
      
      public function BasicPigeonWanderAction()
      {
         super();
         this.m_tickRegulator = new TickRegulator();
         this.m_tickRegulator.addEventListener(TickRegulator.TICK,this.onTimeRateTick);
      }
      
      private function onTimeRateTick(param1:Event) : void
      {
         if(this.m_pigeon.hopChance.test())
         {
            this.m_pigeon.hop();
         }
      }
      
      override public function execute(param1:*) : void
      {
         this.m_pigeon = param1;
         this.m_tickRegulator.update();
      }
   }
}

