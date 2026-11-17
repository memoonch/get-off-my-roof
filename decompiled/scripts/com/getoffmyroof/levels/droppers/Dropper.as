package com.getoffmyroof.levels.droppers
{
   import com.getoffmyroof.levels.spawners.SpawnGroup;
   import com.whatthefawk.math.Chance;
   import com.whatthefawk.utils.TickRegulator;
   import flash.events.Event;
   
   public class Dropper
   {
      
      private var m_dropRate:int;
      
      private var m_timeBeforeDrop:int;
      
      private var m_dropChance:Chance;
      
      private var m_spawnGroup:SpawnGroup;
      
      private var m_isComplete:Boolean;
      
      private var m_dropTickRegulator:TickRegulator;
      
      private var m_id:String;
      
      private var m_timePassed:int;
      
      private var m_isSpawning:Boolean;
      
      private var m_lifeTime:int;
      
      public function Dropper(param1:DropperParams)
      {
         super();
         if(!param1.id || param1.id == null)
         {
            throw new Error("<Dropper> When creating a dropper, id is required.");
         }
         this.m_id = param1.id;
         this.m_lifeTime = param1.lifeTime;
         this.m_dropRate = param1.dropRate;
         this.m_dropChance = new Chance(1,param1.dropChance);
         this.m_timeBeforeDrop = param1.timeBeforeDrop;
         this.m_isComplete = param1.timeBeforeDrop == -1 ? true : false;
         this.m_isSpawning = true;
         this.m_dropTickRegulator = new TickRegulator(this.m_dropRate);
         this.m_dropTickRegulator.addEventListener(TickRegulator.TICK,this.onDropperTick,false,0,true);
      }
      
      public function get isComplete() : Boolean
      {
         return this.m_isComplete;
      }
      
      public function get spawnGroup() : SpawnGroup
      {
         return this.m_spawnGroup;
      }
      
      public function update(param1:int) : void
      {
         if(this.m_isComplete)
         {
            return;
         }
         if(!this.m_isSpawning && this.m_spawnGroup.members.length == 0)
         {
            this.m_isComplete = true;
         }
         if(!this.m_isSpawning)
         {
            return;
         }
         this.m_timePassed += param1;
         if(this.m_lifeTime != -1 && this.m_timePassed >= this.m_lifeTime + this.m_timeBeforeDrop)
         {
            this.m_isSpawning = false;
            return;
         }
         if(this.m_timePassed >= this.m_timeBeforeDrop)
         {
            this.m_dropTickRegulator.update(param1);
         }
      }
      
      public function onDropperTick(param1:Event) : void
      {
         if(this.m_dropChance.test())
         {
            this.spawnGroup.spawn();
         }
      }
      
      public function restart() : void
      {
         this.m_timePassed = 0;
         this.m_isSpawning = true;
         this.m_isComplete = false;
      }
      
      public function get isSpawning() : Boolean
      {
         return this.m_isSpawning;
      }
      
      public function get id() : String
      {
         return this.m_id;
      }
      
      public function dispose() : void
      {
         this.m_dropChance = null;
         this.m_spawnGroup = null;
      }
      
      public function start() : void
      {
         this.m_isSpawning = true;
      }
      
      public function stop() : void
      {
         this.m_isSpawning = false;
      }
      
      public function setSpawnGroup(param1:*) : void
      {
         this.m_spawnGroup = param1;
      }
   }
}

