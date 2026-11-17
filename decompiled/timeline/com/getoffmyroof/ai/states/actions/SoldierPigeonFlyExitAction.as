package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.engine.GameComponents;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.ai.steering.behaviors.Evade;
   import com.whatthefawk.ai.steering.behaviors.Pursuit;
   import com.whatthefawk.ai.steering.behaviors.Wander;
   import com.whatthefawk.audio.AudioManager;
   
   public class SoldierPigeonFlyExitAction extends AAction implements IAction
   {
      
      private var m_audioManager:AudioManager;
      
      public function SoldierPigeonFlyExitAction()
      {
         super();
         this.m_audioManager = GameComponents.instance.getAudioManager();
      }
      
      override public function execute(param1:*) : void
      {
         param1.weaponSystem.switchCurrentWeapon(1);
         param1.steering.removeBehavior(Wander);
         param1.steering.removeBehavior(Evade);
         param1.steering.removeBehavior(Pursuit);
         this.m_audioManager.stopChannel(param1.id + "FlyingLoop");
      }
   }
}

