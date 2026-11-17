package com.whatthefawk.math
{
   public class Chance
   {
      
      private var m_lastResult:int;
      
      private var m_chance:int;
      
      private var m_outOf:int;
      
      public function Chance(param1:int = 1, param2:int = 100)
      {
         super();
         this.outOf = param2;
         this.chance = param1;
      }
      
      public static function test(param1:int = 1, param2:int = 100) : Boolean
      {
         return Math.random() * param2 <= param1 ? true : false;
      }
      
      public function set chance(param1:int) : void
      {
         if(param1 < 0 || param1 > this.m_outOf)
         {
            throw new Error("<Chance::set chance()> Chance must be a value between 0 and m_outOf (" + this.m_outOf + ").");
         }
         this.m_chance = param1;
      }
      
      public function set outOf(param1:int) : void
      {
         if(param1 < 0 || param1 < this.m_chance)
         {
            throw new Error("<Chance::set outOf()> OutOf must be a value greater than 0 and greater than m_chance (" + this.m_chance + ").");
         }
         this.m_outOf = param1;
      }
      
      public function get outOf() : int
      {
         return this.m_outOf;
      }
      
      public function test() : Boolean
      {
         this.m_lastResult = Math.random() * this.m_outOf;
         return this.m_lastResult < this.m_chance ? true : false;
      }
      
      public function get lastResult() : int
      {
         return this.m_lastResult;
      }
      
      public function get chance() : int
      {
         return this.m_chance;
      }
   }
}

