package com.getoffmyroof.levels.spawners
{
   import com.getoffmyroof.levels.triggers.AGroupTrigger;
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.EntityEvent;
   import flash.events.EventDispatcher;
   
   public class SpawnGroup extends EventDispatcher
   {
      
      private var m_isSpawnersComplete:Boolean = false;
      
      private var m_pointsGained:int = 0;
      
      private var m_members:Array;
      
      private var m_triggers:Array;
      
      private var m_isComplete:Boolean = false;
      
      private var m_spawners:Array;
      
      private var m_secondsGained:int = 2;
      
      private var m_id:String;
      
      public function SpawnGroup(param1:String)
      {
         super();
         this.m_id = param1;
         this.m_members = [];
         this.m_spawners = [];
         this.m_triggers = [];
      }
      
      public function update(param1:int) : void
      {
         if(this.m_isComplete)
         {
            return;
         }
         this.updateSpawners(param1);
         this.checkTriggers();
         if(this.m_members.length == 0 && this.m_isSpawnersComplete)
         {
            this.m_isComplete = true;
            dispatchEvent(new SpawnGroupEvent(SpawnGroupEvent.GROUP_DEAD,{"spawnGroup":this}));
         }
      }
      
      public function addTrigger(param1:AGroupTrigger) : void
      {
         this.m_triggers.push(param1);
      }
      
      public function get members() : Array
      {
         return this.m_members;
      }
      
      public function get id() : String
      {
         return this.m_id;
      }
      
      public function reset() : void
      {
         var _loc1_:ASpawner = null;
         var _loc2_:* = undefined;
         for each(var _loc5_ in this.m_spawners)
         {
            _loc1_ = _loc5_;
            _loc5_;
            _loc1_.reset();
         }
         for each(_loc5_ in this.m_triggers)
         {
            _loc2_ = _loc5_;
            _loc5_;
            _loc2_.reset();
         }
         this.m_isComplete = false;
         this.m_isSpawnersComplete = false;
      }
      
      public function addSpawner(param1:ASpawner) : void
      {
         param1.addEventListener(SpawnerEvent.SPAWN,this.onSpawnerSpawn,false,0,true);
         param1.addEventListener(SpawnerEvent.COMPLETE,this.onSpawnerComplete,false,0,true);
         this.m_spawners.push(param1);
      }
      
      public function get pointsGained() : int
      {
         return this.m_pointsGained;
      }
      
      public function onSpawnerComplete(param1:SpawnerEvent) : void
      {
         var _loc2_:ASpawner = null;
         this.m_isSpawnersComplete = true;
         for each(var _loc5_ in this.m_spawners)
         {
            _loc2_ = _loc5_;
            _loc5_;
            if(!_loc2_.isComplete)
            {
               this.m_isSpawnersComplete = false;
               break;
            }
         }
         if(this.m_isSpawnersComplete)
         {
            dispatchEvent(new SpawnGroupEvent(SpawnGroupEvent.COMPLETE,{"spawnGroup":this}));
         }
      }
      
      public function checkTriggers() : void
      {
         var _loc1_:AGroupTrigger = null;
         for each(var _loc4_ in this.m_triggers)
         {
            _loc1_ = _loc4_;
            _loc4_;
            _loc1_.test();
         }
      }
      
      private function onEntityDispose(param1:EntityEvent) : void
      {
         var _loc2_:Entity = param1.currentTarget as Entity;
         var _loc3_:int = int(this.m_members.length);
         var _loc4_:int = _loc3_;
         while(--_loc4_ > -1)
         {
            if(_loc2_.id == this.m_members[_loc4_].id)
            {
               this.m_members.splice(_loc4_,1);
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:ASpawner = null;
         var _loc3_:* = undefined;
         for each(_loc1_ in this.m_members)
         {
         }
         this.m_members = null;
         for each(var _loc6_ in this.m_spawners)
         {
            _loc2_ = _loc6_;
            _loc6_;
         }
         this.m_spawners = null;
         for each(_loc6_ in this.m_triggers)
         {
            _loc3_ = _loc6_;
            _loc6_;
         }
         this.m_triggers = null;
      }
      
      public function onSpawnerSpawn(param1:SpawnerEvent) : void
      {
         var _loc2_:Entity = param1.data.spawnedEntity as Entity;
         _loc2_.addEventListener(EntityEvent.DISPOSE,this.onEntityDispose,false,0,true);
         this.m_members.push(_loc2_);
      }
      
      public function updateSpawners(param1:int) : void
      {
         var _loc2_:ASpawner = null;
         for each(var _loc5_ in this.m_spawners)
         {
            _loc2_ = _loc5_;
            _loc5_;
            _loc2_.update(param1);
         }
      }
      
      public function spawn() : void
      {
         var _loc1_:ASpawner = null;
         for each(var _loc4_ in this.m_spawners)
         {
            _loc1_ = _loc4_;
            _loc4_;
            _loc1_.spawn();
         }
      }
      
      public function get secondsGained() : int
      {
         return this.m_secondsGained;
      }
   }
}

