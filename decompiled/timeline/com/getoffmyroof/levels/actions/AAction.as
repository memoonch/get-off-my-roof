package com.getoffmyroof.levels.actions
{
   public class AAction
   {
      
      public function AAction()
      {
         super();
      }
      
      public function initActionXML(param1:XML) : void
      {
         throw new Error("<AAction::initActionXML> Abstract functions must be overridden.");
      }
      
      public function activate() : void
      {
         throw new Error("<AAction::activate> Abstract functions must be overridden.");
      }
   }
}

