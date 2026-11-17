package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.engine.GameComponents;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.ai.steering.behaviors.FollowPath;
   import com.whatthefawk.audio.AudioManager;
   
   public class BasicPigeonFlyExitAction extends AAction implements IAction
   {
      
      private var m_audioManager:AudioManager;
      
      public function BasicPigeonFlyExitAction()
      {
         super();
         this.m_audioManager = GameComponents.instance.getAudioManager();
      }
      
      override public function execute(param1:*) : void
      {
         param1.steering.removeBehavior(FollowPath);
         this.m_audioManager.stopChannel(param1.id + "FlyingLoop");
      }
   }
}

