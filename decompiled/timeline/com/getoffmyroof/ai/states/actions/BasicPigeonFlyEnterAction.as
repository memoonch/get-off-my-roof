package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.entity.Pigeon;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.ai.steering.behaviors.FollowPath;
   import com.whatthefawk.ai.steering.path.Path;
   import com.whatthefawk.audio.AudioManager;
   
   public class BasicPigeonFlyEnterAction extends AAction implements IAction
   {
      
      private var m_pigeon:Pigeon;
      
      private var m_audioManager:AudioManager;
      
      public function BasicPigeonFlyEnterAction()
      {
         super();
         this.m_audioManager = GameComponents.instance.getAudioManager();
      }
      
      override public function execute(param1:*) : void
      {
         this.m_pigeon = param1;
         var _loc2_:Path = this.m_pigeon.pathManager.getRandomPath();
         if(Math.random() > 0.5)
         {
            _loc2_.reverseWaypoints();
         }
         this.m_pigeon.steering.addBehavior(new FollowPath(_loc2_));
         this.m_audioManager.play("PigeonFlyingLoop",999,1,0,param1.id + "FlyingLoop");
      }
   }
}

