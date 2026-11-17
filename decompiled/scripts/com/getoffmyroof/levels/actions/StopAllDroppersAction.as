package com.getoffmyroof.levels.actions
{
   import com.getoffmyroof.levels.GameLevelManager;
   
   public class StopAllDroppersAction extends AAction
   {
      
      private var m_gameLevelManager:GameLevelManager;
      
      public function StopAllDroppersAction(param1:GameLevelManager)
      {
         super();
         this.m_gameLevelManager = param1;
      }
      
      override public function activate() : void
      {
         this.m_gameLevelManager.currentLevel.stopDroppers();
      }
      
      override public function initActionXML(param1:XML) : void
      {
      }
   }
}

