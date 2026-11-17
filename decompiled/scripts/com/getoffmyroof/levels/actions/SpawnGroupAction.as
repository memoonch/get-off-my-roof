package com.getoffmyroof.levels.actions
{
   import com.getoffmyroof.levels.GameLevel;
   import com.getoffmyroof.levels.GameLevelManager;
   
   public class SpawnGroupAction extends AAction
   {
      
      private var m_groupIDs:Array;
      
      private var m_gameLevelManager:GameLevelManager;
      
      public function SpawnGroupAction(param1:GameLevelManager)
      {
         super();
         this.m_groupIDs = [];
         this.m_gameLevelManager = param1;
      }
      
      override public function initActionXML(param1:XML) : void
      {
         var _loc2_:String = null;
         if(param1.group == null)
         {
            throw new Error("<SpawnGroupAction::initActionXML()> The tag <group>(ID of group to spawn)</group> is missing from the XML definition of this action.");
         }
         for each(_loc2_ in param1.groupID)
         {
            this.m_groupIDs.push(_loc2_);
         }
      }
      
      override public function activate() : void
      {
         var _loc2_:String = null;
         var _loc1_:GameLevel = this.m_gameLevelManager.currentLevel;
         if(_loc1_)
         {
            for each(_loc2_ in this.m_groupIDs)
            {
               _loc1_.spawnGroup(_loc2_);
            }
         }
      }
   }
}

