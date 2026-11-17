package com.getoffmyroof.levels.spawners
{
   import com.getoffmyroof.engine.GameComponents;
   import com.whatthefawk.GameFactory;
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.EntityEvent;
   import flash.events.EventDispatcher;
   
   public class ASpawner extends EventDispatcher
   {
      
      private var m_lifeTime:int;
      
      private var m_entityType:String;
      
      private var m_spawnLimit:int;
      
      private var m_isComplete:Boolean;
      
      private var m_spawnTime:int;
      
      private var m_spawnCount:int;
      
      private var m_spawnRate:int;
      
      private var m_numToSpawn:int;
      
      private var m_timePassed:int;
      
      protected var _gameFactory:GameFactory;
      
      public function ASpawner(param1:SpawnerParams)
      {
         super();
         this._gameFactory = GameComponents.instance.getGameFactory();
         this.m_timePassed = 0;
         this.m_lifeTime = param1.lifeTime;
         this.m_spawnTime = 0;
         this.m_spawnRate = param1.spawnRate;
         this.m_spawnLimit = param1.spawnLimit;
         this.m_entityType = param1.entityType;
         this.m_numToSpawn = param1.numToSpawn;
         this.m_isComplete = false;
      }
      
      public function get isComplete() : Boolean
      {
         return this.m_isComplete;
      }
      
      public function update(param1:int) : void
      {
         if(this.m_isComplete)
         {
            return;
         }
         this.m_timePassed += param1;
         this.m_spawnTime += param1;
         if(this.m_spawnTime > this.m_spawnRate)
         {
            this.m_spawnTime -= this.m_spawnRate;
            this.spawn();
         }
         if(this.m_timePassed > this.m_lifeTime)
         {
            this.m_isComplete = true;
            dispatchEvent(new SpawnerEvent(SpawnerEvent.COMPLETE));
         }
      }
      
      public function spawn() : void
      {
         var _loc2_:Entity = null;
         if(this.m_spawnCount >= this.m_spawnLimit)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.numToSpawn)
         {
            if(this.m_spawnCount == this.m_spawnLimit)
            {
               break;
            }
            ++this.m_spawnCount;
            _loc2_ = this._gameFactory.getEntity(this.m_entityType);
            _loc2_.addEventListener(EntityEvent.DISPOSE,this.onEntityDispose,false,0,true);
            dispatchEvent(new SpawnerEvent(SpawnerEvent.SPAWN,{"spawnedEntity":_loc2_}));
            _loc1_++;
         }
      }
      
      public function get numToSpawn() : int
      {
         return this.m_numToSpawn;
      }
      
      private function onEntityDispose(param1:EntityEvent) : void
      {
         --this.m_spawnCount;
      }
      
      public function dispose() : void
      {
         this._gameFactory = null;
      }
      
      public function reset() : void
      {
         this.m_timePassed = 0;
         this.m_spawnTime = 0;
         this.m_isComplete = false;
      }
      
      public function get entityType() : String
      {
         return this.m_entityType;
      }
   }
}

