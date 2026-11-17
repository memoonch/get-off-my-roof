package com.getoffmyroof.levels
{
   import com.getoffmyroof.levels.droppers.Dropper;
   import com.getoffmyroof.levels.spawners.SpawnGroup;
   import com.getoffmyroof.levels.spawners.SpawnGroupEvent;
   import com.whatthefawk.entity.GameWorld;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class GameLevel extends EventDispatcher
   {
      
      private var m_levelObjects:Dictionary;
      
      private var m_currentSpawnGroup:int;
      
      private var m_music:String;
      
      private var m_isComplete:Boolean;
      
      private var m_numSpawnGroups:int;
      
      private var m_spawnGroups:Dictionary;
      
      private var m_name:String;
      
      private var m_description:String;
      
      private var m_id:String;
      
      private var m_defaultSpawnGroupID:String;
      
      private var m_droppers:Dictionary;
      
      private var m_spawnedGroups:Array;
      
      private var m_gameWorld:GameWorld;
      
      public function GameLevel(param1:GameLevelParams)
      {
         super();
         this.m_gameWorld = param1.gameWorld;
         this.m_id = param1.id;
         this.m_name = param1.name;
         this.m_description = param1.description;
         this.m_music = param1.music;
         this.m_droppers = new Dictionary();
         this.m_spawnGroups = new Dictionary();
         this.m_spawnedGroups = [];
         this.m_currentSpawnGroup = 0;
         this.m_numSpawnGroups = 0;
         this.m_levelObjects = new Dictionary();
         this.m_isComplete = false;
      }
      
      public function get description() : String
      {
         return this.m_description;
      }
      
      public function addSpawnGroup(param1:String, param2:SpawnGroup) : void
      {
         param2.addEventListener(SpawnGroupEvent.COMPLETE,this.onSpawnGroupComplete,false,0,true);
         param2.addEventListener(SpawnGroupEvent.GROUP_DEAD,this.onSpawnGroupDead,false,0,true);
         ++this.m_numSpawnGroups;
         this.m_spawnGroups[param1] = param2;
         if(!this.m_defaultSpawnGroupID)
         {
            this.m_defaultSpawnGroupID = param1;
         }
      }
      
      public function onSpawnGroupDead(param1:SpawnGroupEvent) : void
      {
         var _loc2_:SpawnGroup = param1.data.spawnGroup;
         this.removeSpawnedGroup(_loc2_);
      }
      
      public function get numSpawnGroups() : int
      {
         return this.m_numSpawnGroups;
      }
      
      public function spawnGroup(param1:String) : void
      {
         var _loc2_:SpawnGroup = this.getSpawnGroup(param1);
         if(!_loc2_)
         {
            throw new Error("<GameLevel::spawnGroup> Spawn Group " + param1 + " does not exist.");
         }
         this.m_spawnedGroups.push(_loc2_);
      }
      
      public function restartDroppers(param1:Array = null) : void
      {
         var _loc2_:Dropper = null;
         for each(_loc2_ in this.m_droppers)
         {
            if(!(param1.length > 0 && param1.indexOf(_loc2_.id) == -1))
            {
               _loc2_.restart();
            }
         }
      }
      
      public function stopDroppers(param1:Array = null) : void
      {
         var _loc2_:Dropper = null;
         for each(_loc2_ in this.m_droppers)
         {
            if(param1 != null)
            {
               if(param1.length > 0 && param1.indexOf(_loc2_.id) == -1)
               {
                  continue;
               }
            }
            _loc2_.stop();
         }
      }
      
      public function getLevelObject(param1:String) : *
      {
         return this.m_levelObjects[param1];
      }
      
      public function update(param1:int) : void
      {
         var _loc2_:SpawnGroup = null;
         var _loc3_:Dropper = null;
         var _loc4_:Dropper = null;
         if(this.m_spawnedGroups != null && this.m_spawnedGroups.length > 0)
         {
            for each(_loc2_ in this.m_spawnedGroups)
            {
               _loc2_.update(param1);
            }
         }
         if(this.m_droppers != null)
         {
            for each(_loc3_ in this.m_droppers)
            {
               _loc3_.update(param1);
            }
         }
         this.m_isComplete = true;
         if(this.m_spawnedGroups.length > 0)
         {
            this.m_isComplete = false;
         }
         else
         {
            for each(_loc4_ in this.m_droppers)
            {
               this.m_isComplete = _loc4_.isComplete;
               if(!this.m_isComplete)
               {
                  break;
               }
            }
         }
         if(this.m_isComplete)
         {
            dispatchEvent(new GameLevelEvent(GameLevelEvent.LEVEL_COMPLETE));
         }
      }
      
      public function addLevelObject(param1:String, param2:*) : void
      {
         this.m_levelObjects[param1] = param2;
      }
      
      public function get name() : String
      {
         return this.m_name;
      }
      
      public function getDropper(param1:String) : Dropper
      {
         if(!this.m_droppers[param1])
         {
            throw new Error("<GameLevel::getDropper> Dropper" + param1 + "does not exist.");
         }
         return this.m_droppers[param1];
      }
      
      public function dispose() : void
      {
         var _loc1_:SpawnGroup = null;
         for each(_loc1_ in this.m_spawnedGroups)
         {
            _loc1_.dispose();
         }
         this.m_droppers = null;
         this.m_spawnGroups = null;
         this.m_spawnedGroups = null;
         this.m_levelObjects = null;
      }
      
      public function get id() : String
      {
         return this.m_id;
      }
      
      public function get music() : String
      {
         return this.m_music;
      }
      
      public function getSpawnGroup(param1:String) : SpawnGroup
      {
         if(!this.m_spawnGroups[param1])
         {
            throw new Error("<GameLevel::getSpawnGroup> Spawn Group" + param1 + "does not exist.");
         }
         return this.m_spawnGroups[param1];
      }
      
      public function removeSpawnedGroup(param1:SpawnGroup) : void
      {
         param1.reset();
         var _loc2_:int = 0;
         while(_loc2_ < this.m_spawnedGroups.length)
         {
            if(param1 == this.m_spawnedGroups[_loc2_])
            {
               this.m_spawnedGroups.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      public function onSpawnGroupComplete(param1:SpawnGroupEvent) : void
      {
         ++this.m_currentSpawnGroup;
      }
      
      public function get currentSpawnGroup() : int
      {
         return this.m_currentSpawnGroup;
      }
      
      public function startGameLevel() : void
      {
         if(this.m_defaultSpawnGroupID)
         {
            this.spawnGroup(this.m_defaultSpawnGroupID);
         }
      }
      
      public function addDropper(param1:String, param2:Dropper) : void
      {
         this.m_droppers[param1] = param2;
      }
      
      public function startDroppers(param1:Array = null) : void
      {
         var _loc2_:Dropper = null;
         for each(_loc2_ in this.m_droppers)
         {
            if(!(param1.length > 0 && param1.indexOf(_loc2_.id) == -1))
            {
               _loc2_.start();
            }
         }
      }
   }
}

