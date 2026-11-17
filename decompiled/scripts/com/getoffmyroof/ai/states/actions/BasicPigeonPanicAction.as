package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.entity.Pigeon;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.audio.AudioManager;
   
   public class BasicPigeonPanicAction extends AAction implements IAction
   {
      
      private var m_audioManager:AudioManager;
      
      public function BasicPigeonPanicAction()
      {
         super();
         this.m_audioManager = GameComponents.instance.getAudioManager();
      }
      
      override public function execute(param1:*) : void
      {
         var _loc2_:Pigeon = param1 as Pigeon;
         _loc2_.panic();
         this.m_audioManager.playRandom("PigeonPanic");
      }
   }
}

