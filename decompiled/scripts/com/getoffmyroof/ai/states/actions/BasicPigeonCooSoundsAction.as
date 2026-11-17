package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.engine.GameComponents;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.math.Chance;
   import com.whatthefawk.utils.TickRegulator;
   import flash.events.Event;
   
   public class BasicPigeonCooSoundsAction extends AAction implements IAction
   {
      
      private var m_tickRegulator:TickRegulator;
      
      private var m_audioManager:AudioManager;
      
      public function BasicPigeonCooSoundsAction()
      {
         super();
         this.m_audioManager = GameComponents.instance.getAudioManager();
         this.m_tickRegulator = new TickRegulator(500);
         this.m_tickRegulator.addEventListener(TickRegulator.TICK,this.onTimeRateTick,false,0,true);
      }
      
      private function onTimeRateTick(param1:Event) : void
      {
         if(Chance.test(5,300))
         {
            this.m_audioManager.playRandom("PigeonCoo");
         }
         else if(Chance.test(5,1000))
         {
            this.m_audioManager.play("PigeonRustleFeathers");
         }
      }
      
      override public function execute(param1:*) : void
      {
         this.m_tickRegulator.update();
      }
   }
}

