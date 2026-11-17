package com.whatthefawk.life
{
   import com.whatthefawk.life.stats.Stat;
   import com.whatthefawk.life.stats.StatParams;
   import com.whatthefawk.life.stats.Stats;
   import flash.events.EventDispatcher;
   
   public class Life extends EventDispatcher
   {
      
      public static const LIFE_STAT_ID:String = "life";
      
      public static const LIFE_STAT_NAME:String = "Life";
      
      public static const ALIVE:String = "alive";
      
      public static const DEAD:String = "dead";
      
      public static const GOD:String = "god";
      
      private var m_status:String = "alive";
      
      private var m_stats:Stats;
      
      public function Life(param1:LifeParams)
      {
         super();
         this.m_stats = param1.stats;
         this.m_stats.addStat(new StatParams({
            "id":Life.LIFE_STAT_ID,
            "name":Life.LIFE_STAT_NAME,
            "value":(param1.initialLife == -1 ? param1.maxLife : param1.initialLife),
            "maxValue":param1.maxLife
         }));
         this.checkLife();
      }
      
      public function get maxLife() : int
      {
         return this.m_stats.getStat(Life.LIFE_STAT_ID).maxValue;
      }
      
      public function toggleGodMode() : void
      {
         if(this.m_status == Life.DEAD)
         {
            return;
         }
         this.m_status = this.m_status == Life.GOD ? Life.ALIVE : Life.GOD;
      }
      
      public function get isInvincible() : Boolean
      {
         return false;
      }
      
      public function checkLife() : void
      {
         if(this.m_status == Life.GOD)
         {
            return;
         }
         if(this.m_stats.getStat(Life.LIFE_STAT_ID).value > 0)
         {
            this.m_status = Life.ALIVE;
            return;
         }
         this.kill();
      }
      
      public function get isDead() : Boolean
      {
         this.checkLife();
         return this.m_status == Life.DEAD;
      }
      
      public function update(param1:int) : void
      {
         this.checkLife();
      }
      
      public function get isGod() : Boolean
      {
         return this.m_status == Life.GOD;
      }
      
      public function revive(param1:int) : void
      {
         if(this.m_status != Life.DEAD)
         {
            return;
         }
         this.m_status = Life.ALIVE;
         this.m_stats.getStat(Life.LIFE_STAT_ID).setValue(param1,Stat.BOTH_VALUES);
         dispatchEvent(new LifeEvent(LifeEvent.REVIVE));
      }
      
      public function modifyLife(param1:int) : void
      {
         this.m_stats.getStat(Life.LIFE_STAT_ID).modifyValue(param1,Stat.BOTH_VALUES);
      }
      
      public function get status() : String
      {
         return this.m_status;
      }
      
      public function get life() : int
      {
         return this.m_stats.getStat(Life.LIFE_STAT_ID).value;
      }
      
      public function kill() : void
      {
         if(this.m_status != Life.ALIVE)
         {
            return;
         }
         this.m_status = Life.DEAD;
         this.m_stats.getStat(Life.LIFE_STAT_ID).setValue(0,Stat.BOTH_VALUES);
         dispatchEvent(new LifeEvent(LifeEvent.DEAD));
      }
   }
}

