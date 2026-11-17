package com.whatthefawk.life.stats
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class Stats extends EventDispatcher
   {
      
      private var m_stats:Dictionary;
      
      private var m_statEffectCounts:Dictionary;
      
      private var m_statEffects:Array;
      
      public function Stats(param1:StatsParams)
      {
         super();
         this.m_stats = new Dictionary();
         this.m_statEffects = [];
         this.m_statEffectCounts = new Dictionary();
         this.addStats(param1.initialStats);
      }
      
      public function onStatEffect(param1:StatEffectEvent) : void
      {
      }
      
      public function addStatEffect(param1:StatEffect) : void
      {
         var _loc2_:int = int(this.m_statEffectCounts[param1.id]);
         if(_loc2_ >= param1.maxStack)
         {
            return;
         }
         param1.statSystem = this;
         param1.update(1);
         this.m_statEffects.push(param1);
         if(this.m_statEffectCounts[param1.id] == null)
         {
            this.m_statEffectCounts[param1.id] = 1;
         }
         else
         {
            ++this.m_statEffectCounts[param1.id];
         }
      }
      
      public function update(param1:*) : void
      {
         this.processStatEffects(param1);
      }
      
      public function getStat(param1:String) : Stat
      {
         return this.m_stats[param1];
      }
      
      public function hasStat(param1:String) : Boolean
      {
         return this.m_stats[param1] != null;
      }
      
      public function addStat(param1:StatParams) : void
      {
         this.m_stats[param1.id] = new Stat(param1);
      }
      
      public function processStatEffects(param1:int) : void
      {
         var _loc2_:StatEffect = null;
         var _loc3_:int = int(this.m_statEffects.length);
         while(--_loc3_ > -1)
         {
            _loc2_ = this.m_statEffects[_loc3_];
            _loc2_.update(param1);
            if(_loc2_.isComplete)
            {
               this.m_statEffects.splice(_loc3_,1);
               --this.m_statEffectCounts[_loc2_.id];
            }
         }
      }
      
      public function modifyStat(param1:String, param2:int, param3:String = null, param4:Boolean = true) : void
      {
         if(!param3)
         {
            param3 = Stat.TEMP_VALUE;
         }
         if(this.hasStat(param1))
         {
            this.getStat(param1).modifyValue(param2,param3,param4);
         }
      }
      
      public function addStats(param1:Array) : void
      {
         var _loc2_:StatParams = null;
         for each(_loc2_ in param1)
         {
            this.addStat(_loc2_);
         }
      }
      
      public function hasStatEffect(param1:String) : Boolean
      {
         if(this.m_statEffectCounts[param1] != null && this.m_statEffectCounts[param1] != 0)
         {
            return true;
         }
         return false;
      }
   }
}

