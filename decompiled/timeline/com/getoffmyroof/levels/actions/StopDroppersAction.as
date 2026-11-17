package com.getoffmyroof.levels.actions
{
   import com.getoffmyroof.levels.GameLevelManager;
   
   public class StopDroppersAction extends AAction
   {
      
      private var m_dropperIDs:Array;
      
      private var m_gameLevelManager:GameLevelManager;
      
      public function StopDroppersAction(param1:GameLevelManager)
      {
         super();
         this.m_dropperIDs = [];
         this.m_gameLevelManager = param1;
      }
      
      override public function initActionXML(param1:XML) : void
      {
         var _loc2_:String = null;
         if(param1.dropperID == null)
         {
            return;
         }
         for each(_loc2_ in param1.dropperID)
         {
            this.m_dropperIDs.push(_loc2_);
         }
      }
      
      override public function activate() : void
      {
         this.m_gameLevelManager.currentLevel.stopDroppers(this.m_dropperIDs);
      }
   }
}

