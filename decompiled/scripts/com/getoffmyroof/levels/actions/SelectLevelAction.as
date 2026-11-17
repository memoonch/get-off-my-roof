package com.getoffmyroof.levels.actions
{
   import com.getoffmyroof.levels.GameLevelManager;
   
   public class SelectLevelAction extends AAction
   {
      
      private var m_selectedLevelID:String;
      
      private var m_gameLevelManager:GameLevelManager;
      
      public function SelectLevelAction(param1:GameLevelManager)
      {
         super();
         this.m_gameLevelManager = param1;
      }
      
      override public function initActionXML(param1:XML) : void
      {
         if(!param1.@levelID.length() && param1.@levelID == "")
         {
            throw new Error("<SelectLevelAction::initActionXML()> Tag <levelID></levelID> is missing from XML definition of a SelectLevelAction.");
         }
         this.m_selectedLevelID = param1.levelID;
      }
      
      override public function activate() : void
      {
         this.m_gameLevelManager.selectGameLevel(this.m_selectedLevelID);
      }
   }
}

