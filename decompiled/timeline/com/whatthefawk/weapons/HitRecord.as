package com.whatthefawk.weapons
{
   public class HitRecord
   {
      
      public var hitDelay:int;
      
      public var numHits:int = 0;
      
      public var timeBetweenHits:int;
      
      public var timeHit:int;
      
      public function HitRecord(param1:int, param2:int = 1)
      {
         super();
         this.numHits = param2;
         this.timeHit = param1;
         this.hitDelay = 500;
      }
      
      public function canHit() : Boolean
      {
         return this.timeBetweenHits > 500;
      }
      
      public function update(param1:int) : void
      {
         this.timeBetweenHits = param1 - this.timeHit;
         if(this.timeBetweenHits > this.hitDelay)
         {
            ++this.numHits;
            this.timeHit = param1;
         }
      }
   }
}

