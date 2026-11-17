package com.getoffmyroof.levels.actions
{
   import com.getoffmyroof.levels.GameLevelManager;
   
   public class EndLevelAction extends AAction
   {
      
      private var m_gameLevelManager:GameLevelManager;
      
      public function EndLevelAction(param1:GameLevelManager)
      {
         super();
         this.m_gameLevelManager = param1;
      }
      
      override public function activate() : void
      {
         this.m_gameLevelManager.endLevel();
      }
      
      override public function initActionXML(param1:XML) : void
      {
      }
   }
}

