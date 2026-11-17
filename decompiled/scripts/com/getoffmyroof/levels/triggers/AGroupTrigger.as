package com.getoffmyroof.levels.triggers
{
   import com.getoffmyroof.levels.spawners.SpawnGroup;
   import flash.events.EventDispatcher;
   
   public class AGroupTrigger extends EventDispatcher
   {
      
      private var m_isTriggered:Boolean;
      
      private var m_spawnGroup:SpawnGroup;
      
      protected var _actions:Array;
      
      public function AGroupTrigger(param1:SpawnGroup)
      {
         super();
         this.m_spawnGroup = param1;
         this.m_isTriggered = false;
         this._actions = [];
      }
      
      public function get spawnGroup() : SpawnGroup
      {
         return this.m_spawnGroup;
      }
      
      public function get isTriggered() : Boolean
      {
         return this.m_isTriggered;
      }
      
      public function reset() : void
      {
         this.m_isTriggered = false;
      }
      
      public function test() : void
      {
         throw new Error("<Abstract> <AGroupTrigger::test> Must be implemented in subclass.");
      }
      
      public function activate() : *
      {
         var _loc1_:* = undefined;
         this.m_isTriggered = true;
         for each(_loc1_ in this._actions)
         {
            _loc1_.activate();
         }
      }
      
      public function addAction(param1:*) : *
      {
         this._actions.push(param1);
      }
   }
}

