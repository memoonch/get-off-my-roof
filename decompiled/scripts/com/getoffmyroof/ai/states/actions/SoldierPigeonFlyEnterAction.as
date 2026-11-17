package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.entity.Pigeon;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.ai.steering.behaviors.Evade;
   import com.whatthefawk.ai.steering.behaviors.Pursuit;
   import com.whatthefawk.ai.steering.behaviors.Wander;
   import com.whatthefawk.audio.AudioManager;
   
   public class SoldierPigeonFlyEnterAction extends AAction implements IAction
   {
      
      private var m_pigeon:Pigeon;
      
      private var m_audioManager:AudioManager;
      
      public function SoldierPigeonFlyEnterAction()
      {
         super();
         this.m_audioManager = GameComponents.instance.getAudioManager();
      }
      
      override public function execute(param1:*) : void
      {
         this.m_pigeon = param1;
         this.m_pigeon.weaponSystem.switchCurrentWeapon(2);
         param1.steering.addBehavior(new Wander(60,0,2));
         param1.steering.addBehavior(new Pursuit(this.m_pigeon.target,200));
         param1.steering.addBehavior(new Evade(this.m_pigeon.target,this.m_pigeon.evadeDistance));
         this.m_audioManager.play("PigeonFlyingLoop",999,1,0,param1.id + "FlyingLoop");
      }
   }
}

